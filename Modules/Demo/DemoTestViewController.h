//
//  DemoTestViewController.h
//  AppFramework
//
//  Created by cnsunrun on 2017/6/6.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, DemoType) {
    DemoTypeVideo = 1,
    DemoTypeActive = 2,
};

@interface DemoTestViewController : BaseViewController

@property (nonatomic, assign) DemoType type;
@end
