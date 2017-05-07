//
//  AFNetworkHelper.m
//  AppFramework
//
//  Created by zys on 2017/3/1.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "AFNetworkHelper.h"
#define AFWEBAPI_REQUEST_TIMEOUT 10

@implementation AFNetworkHelper

+(instancetype)instance{
    
    static AFNetworkHelper *network = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        network = [[AFNetworkHelper alloc]init];
    });
    return network;
}

#pragma mark - 上传图片

-(void)uploadReq:(id<UpdateImageProtocol, RequestProtocol>)req success:(void(^)(id responseObject))success failure:(void(^)(NSInteger code, NSString *errMsg))failure{
    
#pragma mark - 添加参数
//    UserInfoModel *user = [UserData instance].getUserInfo;
//    NSMutableDictionary *dict = [NSMutableDictionary new];
//    [dict setObject:user.idCard forKey:@"memberId"];
//    [dict setObject:[NSDate currentTimeWithFormatter:@"yyyyMMDDHHmmss"] forKey:@"fileName"];
//    [self uploadImageWithURL:[req url] imgData:[req data] parameters:dict fileName:[req fieldName] success:success failure:failure];
}

-(void)uploadImageWithURL:(NSString *)url imgData:(NSMutableArray *)imgDatas parameters:(id)parameters fileName:(NSString *)fileName success:(void(^)(NSString *url))success failure:(void(^)(NSInteger code, NSString *msg))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    manager.requestSerializer.timeoutInterval = AFWEBAPI_REQUEST_TIMEOUT;
    __block typeof(imgDatas) weakData = imgDatas;
    __block typeof(fileName) weakName = fileName;
    __block typeof(self) weakSelf = self;
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:parameters];
//    [dict setObject:UPLOADVERSON forKey:@"ver"];
    
    [manager POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSInteger imgCount = 0;
        for (NSData *imageData in weakData) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmssSSS";
            NSString *filename = [NSString stringWithFormat:@"%@%@",[formatter stringFromDate:[NSDate date]],@(imgCount)];
            [formData appendPartWithFileData:imageData name:weakName fileName:filename mimeType:@"image/jpeg"];
            imgCount++;
            weakName = [weakName stringByAppendingString:[@(imgCount)description]];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf dealWithResponseObject:responseObject responseClass:nil success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure([error.domain integerValue], [error.userInfo objectForKey:@"NSLocalizedDescription"]);
    }];
}

-(void)uploadImgWithUrl:(NSString *)URLString uploadImg:(UIImage *)img parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:parameters];
//    [dict setObject:UPLOADVERSON forKey:@"ver"];
    
    manager.requestSerializer.timeoutInterval = AFWEBAPI_REQUEST_TIMEOUT;
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSString *fileName  = @"img.png";
        NSData *imageData = nil;
        [formData appendPartWithFileData:imageData name:@"uploadFile" fileName:fileName mimeType:@"image/png"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        return success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        return failure(task,error);
    }];
}


#pragma mark - 一般网络请求

-(void)requestWithURL:(NSString *)url method:(NSString *)method parameters:(id)parameters success:(void(^)(NSURLSessionDataTask *task, id responseObject))success failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure{
    
    AFHTTPSessionManager *sessionManager=[AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    sessionManager.requestSerializer.timeoutInterval = AFWEBAPI_REQUEST_TIMEOUT;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
//    [params setObject:UPLOADVERSON forKey:@"ver"];
    //删除空元素
    for (NSString *key in [params allKeys]) {
        NSString *value = params[key];
        if ([value isKindOfClass:[NSString class]]) {
            if (!(value.length > 0)) {
                [params removeObjectForKey:key];
            }
        }
    }
    
//    UserInfoModel *user = [UserData instance].getUserInfo;
//    if (user.idCard.length > 0) {
//        [params setObject:[user idCard] forKey:@"memberId"];
//    }
    
    if ([method isEqualToString:METHOD_GET]) {
        [sessionManager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {} success:success failure:failure];
    }else{
        [sessionManager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {} success:success failure:failure];
    }
}

-(void)requestWithURL:(NSString *)url method:(NSString *)method parameters:(id)parameters response:(Class)clsss success:(void(^)(id responseObject))success failure:(void(^)(NSInteger code, NSString *errMsg))failure{
    __block typeof(self) weakSelf = self;
    void (^successHandler)(NSURLSessionDataTask *task, id responseObject) = ^(NSURLSessionDataTask *task, id responseObject){
        [weakSelf dealWithResponseObject:responseObject responseClass:clsss success:success failure:failure];
    };
    
    void (^failerHandler)(NSURLSessionDataTask *task, NSError *error) = ^(NSURLSessionDataTask *task, NSError *error){
        NSString *returnMsg = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        if (returnMsg.length == 0 || !returnMsg) {
            returnMsg = @"网络请求错误";
        }
        failure([error.domain integerValue],returnMsg);
        NSLog(@"%@\n%@", task.response.URL, error);
    };
    
    [self requestWithURL:url method:method parameters:parameters success:successHandler failure:failerHandler];
}

-(void)reqeust:(id<RequestProtocol>)request response:(Class)clsss success:(void(^)(id responseObject))success failure:(void(^)(NSInteger code, NSString *errMsg))failure{
    
    [self requestWithURL:[request url] method:[request method] parameters:[(NSObject *)request toDictionary] response:clsss success:success failure:failure];
}

-(void)sendRequest:(id<RequestProtocol>)request response:(void(^)(BOOL result, NSString *errMsg))response{
    [self reqeust:request response:nil success:^(id responseObject) {
        response(YES, nil);
    } failure:^(NSInteger code, NSString *errMsg) {
        response(NO, errMsg);
    }];
}

-(void)dealWithResponseObject:(id)responseObject responseClass:(Class)clss success:(void(^)(id responseObject))success failure:(void(^)(NSInteger code, NSString *errMsg))failure{
    
    NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
    NSDictionary *response = [responseObject objectForKey:@"res"];
    NSString *errMsg = [response objectForKey:@"msg"];
    NSDictionary *data = [response objectForKey:@"data"];
    
    if (clss == nil) {
        if (code == 0) {
            success(data);
        }else{
            failure(code,errMsg);
#ifdef DEBUG
            NSLog(@"%@", responseObject);
#endif
        }
        return;
    }
    
    if (code != 0) {
        failure(code, errMsg);
        return;
    }
    id resObject = [data parserWithClass:clss];
    if (success) {
        success(resObject);
    }
}

@end
