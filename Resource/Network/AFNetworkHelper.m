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

-(void)uploadReq:(id<UpdateImageProtocol, RequestProtocol>)req success:(void(^)(id responseObject))success failure:(void(^)(NSString *errMsg))failure{
    
    void (^failerHandler)(NSError *error) = ^(NSError *error){
        NSString *returnMsg = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        if (returnMsg.length == 0 || !returnMsg) {
            returnMsg = @"网络请求错误";
        }
        failure(returnMsg);
    };
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [self uploadImageWithURL:[req url] imgData:[req data] parameters:dict fileName:[req fieldName] success:success failure:failerHandler];
}

-(void)uploadImageWithURL:(NSString *)url imgData:(NSMutableArray *)imgDatas parameters:(id)parameters fileName:(NSString *)fileName success:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    manager.requestSerializer.timeoutInterval = AFWEBAPI_REQUEST_TIMEOUT;
    
    NSMutableURLRequest *reqest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSMutableData *formData = [[NSMutableData alloc]init];
    for (int i=0; i< imgDatas.count; i++) {
        [formData appendData:imgDatas[i]];
    }
    NSURLSessionUploadTask *task = [manager uploadTaskWithRequest:reqest fromData:formData progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
    }];
    [task resume];
}

#pragma mark - 一般网络请求

-(void)requestWithURL:(NSString *)url method:(NSString *)method parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    AFHTTPSessionManager *sessionManager=[AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    sessionManager.requestSerializer.timeoutInterval = AFWEBAPI_REQUEST_TIMEOUT;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:parameters];
    NSURL *URL = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:method];
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil]];
    
    NSURLSessionDataTask *task = [sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            failure(error);
        }else{
            success(responseObject);
        }
    }];
    [task resume];
}

-(void)requestWithURL:(NSString *)url method:(NSString *)method parameters:(id)parameters response:(Class)clsss success:(void(^)(id responseObject))success failure:(void(^)(NSInteger code, NSString *errMsg))failure{
    __block typeof(self) weakSelf = self;
    //处理请求成功后的结果
    void (^successHandler)(id responseObject) = ^(id responseObject){
        [weakSelf dealWithResponseObject:responseObject responseClass:clsss success:success failure:failure];
    };
    //处理网络失败后的结果
    void (^failerHandler)(NSError *error) = ^(NSError *error){
        NSString *returnMsg = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        if (returnMsg.length == 0 || !returnMsg) {
            returnMsg = @"网络请求错误";
        }
        failure([error.domain integerValue],returnMsg);
    };
    
    [self requestWithURL:url method:method parameters:parameters success:successHandler failure:failerHandler];
}

-(void)reqeust:(id<RequestProtocol>)request response:(Class)clsss success:(void(^)(id responseObject))success failure:(void(^)(NSInteger code, NSString *errMsg))failure{
    [self requestWithURL:[request url] method:[request method] parameters:[(NSObject *)request toDictionary] response:clsss success:success failure:failure];
}

-(void)sendRequest:(id<RequestProtocol>)request response:(void(^)(NSString *errMsg))response{
    [self reqeust:request response:nil success:^(id responseObject) {
        response(nil);
    } failure:^(NSInteger code, NSString *errMsg) {
        response(errMsg);
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
