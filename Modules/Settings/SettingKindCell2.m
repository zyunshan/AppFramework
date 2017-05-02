//
//  SettingKindCell2.m
//  AppFramework
//
//  Created by cnsunrun on 2017/4/26.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "SettingKindCell2.h"
@implementation SettingKindModel2

@end

@implementation SettingKindCell2

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)updateCellWithModel:(SettingKindModel2 *)model{
    self.leftTextLabel.text = model.leftText;
    self.rightTextLabel.text = model.rightText;
}
@end
