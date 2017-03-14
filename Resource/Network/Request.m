//
//  Request.m
//  AppFramework
//
//  Created by zys on 2017/3/1.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "Request.h"

@implementation Request

-(NSString *)method{
    return GET;
}
@end


@implementation UploadImageReq
- (NSString*)url{
    return @"";
}
- (NSMutableArray*)data{
    if (nil == self->_images){
        @throw [[NSException alloc]initWithName:@"no image data" reason:@"no image data" userInfo:nil];
    }
    return [self imageDatas];
}

- (NSMutableArray *)imageDatas{
    NSMutableArray *imageDatas = [[NSMutableArray alloc]init];
    for (UIImage *image in self.images) {
        NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
        if (!imageData) {
            imageData = UIImagePNGRepresentation(image);
        }
        if (imageData) {
            [imageDatas addObject:imageData];
        }
    }
    return imageDatas;
}
- (NSString*)fieldName{
    return @"uploadFile";
}
- (NSString *)method{
    return POST;
}
@end
