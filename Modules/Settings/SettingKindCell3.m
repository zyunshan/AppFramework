//
//  SettingKindCell3.m
//  AppFramework
//
//  Created by cnsunrun on 2017/4/26.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "SettingKindCell3.h"

@implementation SettingKindModel3

@end

@implementation SettingKindCell3

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)updateCellWithModel:(SettingKindModel3 *)model{
    self.leftTextLabel.text = model.leftText;
}
@end
