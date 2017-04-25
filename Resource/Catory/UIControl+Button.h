//
//  UIControl+button.h
//  App
//
//  Created by huanchi on 15/10/27.
//  Copyright © 2015年  上海欢炽网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIControl (Button)

/**
 button 重复点击时间间隔
 */
@property (nonatomic, assign) NSTimeInterval acceptEventInterval;

@property (nonatomic, readonly) NSTimeInterval acceptedEventTime;

+(void)load;

@end

typedef void (^TouchUpInsideEvent)();

@interface UIButton (Custom)

@property (nonatomic, copy) TouchUpInsideEvent clickEvent;

@end
