//
//  AFNetworkHelper.h
//  AppFramework
//
//  Created by zys on 2017/3/1.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>

#define POST     @"POST"
#define GET      @"GET"

typedef void(^ReqResponse)(id value, ...);

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
 *  @param req     遵循协议的请求对象
 */
-(void)uploadReq:(id<UpdateImageProtocol, RequestProtocol>)req success:(void(^)(id responseObject))success failure:(void(^)(NSString *errMsg))failure;


/**
 *  上传图片
 *
 */
-(void)uploadImageWithURL:(NSString *)url imgData:(NSMutableArray *)imgDatas parameters:(id)parameters fileName:(NSString *)fileName success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;


#pragma mark - 其他请求

/**
 *  发送请求
 *
 *  @param url        请求地址
 *  @param method     请求方式
 *  @param parameters 参数
 */
-(void)requestWithURL:(NSString *)url method:(NSString *)method parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/**
 *  对象方式请求
 *
 *  @param request 请求对象
 *  @param clsss   返回对象类型
 */
-(void)reqeust:(id<RequestProtocol>)request response:(Class)clsss success:(void(^)(id responseObject))success failure:(void(^)(NSInteger code, NSString *errMsg))failure;

/**
 *  发送请求
 *
 */
-(void)sendRequest:(id<RequestProtocol>)request response:(void(^)(NSString *errMsg))response;

/**
 *  自定义请求
 *
 */
-(void)requestWithURL:(NSString *)url method:(NSString *)method parameters:(id)parameters response:(Class)clsss success:(void(^)(id responseObject))success failure:(void(^)(NSInteger code, NSString *errMsg))failure;

@end
