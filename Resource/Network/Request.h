//
//  Request.h
//  AppFramework
//
//  Created by zys on 2017/3/1.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworkHelper.h"
@interface Request : NSObject

@end

@interface UploadImageReq : Request <UpdateImageProtocol, RequestProtocol>

@property (nonatomic, strong) NSArray* images;
- (NSString*)url;
- (NSString *)method;
- (NSData*)data;
- (NSString*)fieldName;
@end
