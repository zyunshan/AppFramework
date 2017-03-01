//
//  AFNetworkHelper.h
//  AppFramework
//
//  Created by zys on 2017/3/1.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>

#define METHOD_POST     @"POST"
#define METHOD_GET      @"GET"

@protocol UpdateImageProtocol <NSObject>

- (NSMutableArray*)data;
- (NSString*)fieldName;
@optional
- (NSDictionary *)parameter;
- (NSString *)method;
@end


@protocol RequestProtocol <NSObject>

@required

-(NSString *)url;

@optional

-(NSString *)method;

@end


@interface AFNetworkHelper : NSObject


+(instancetype)instance;

#pragma mark - 上传图片

/**
 *  上传图片
 *
 *  @param req     <#req description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
-(void)uploadReq:(id<UpdateImageProtocol, RequestProtocol>)req success:(void(^)(id responseObject))success failure:(void(^)(NSInteger code, NSString *errMsg))failure;


/**
 *  上传图片
 *
 *  @param url        <#url description#>
 *  @param imgDatas   <#imgDatas description#>
 *  @param parameters <#parameters description#>
 *  @param fileName   <#fileName description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 */
-(void)uploadImageWithURL:(NSString *)url imgData:(NSMutableArray *)imgDatas parameters:(id)parameters fileName:(NSString *)fileName success:(void(^)(NSString *url))success failure:(void(^)(NSInteger code, NSString *msg))failure;


#pragma mark - 其他请求

/**
 *  发送请求
 *
 *  @param url        请求地址
 *  @param method     请求方式
 *  @param parameters 参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
-(void)requestWithURL:(NSString *)url method:(NSString *)method parameters:(id)parameters success:(void(^)(NSURLSessionDataTask *task, id responseObject))success failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  对象方式请求
 *
 *  @param request 请求对象
 *  @param clsss   返回对象类型
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)reqeust:(id<RequestProtocol>)request response:(Class)clsss success:(void(^)(id responseObject))success failure:(void(^)(NSInteger code, NSString *errMsg))failure;

/**
 *  <#Description#>
 *
 *  @param request  <#request description#>
 *  @param response <#response description#>
 */
-(void)sendRequest:(id<RequestProtocol>)request response:(void(^)(BOOL result, NSString *errMsg))response;

/**
 *  自定义请求
 *
 *  @param url        <#url description#>
 *  @param method     <#method description#>
 *  @param parameters <#parameters description#>
 *  @param clsss      <#clsss description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 */
-(void)requestWithURL:(NSString *)url method:(NSString *)method parameters:(id)parameters response:(Class)clsss success:(void(^)(id responseObject))success failure:(void(^)(NSInteger code, NSString *errMsg))failure;

@end
