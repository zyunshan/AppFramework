//
//  IMGScaleView.h
//  DogFoodApp
//
//  Created by cnsunrun on 2017/2/22.
//  Copyright © 2017年 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IMGScaleView : UIView

-(instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)image;

+(void)showWithView:(UIView *)view andImage:(UIImage *)image;
@end
