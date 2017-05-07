//
//  SettingKindCell1.m
//  AppFramework
//
//  Created by cnsunrun on 2017/4/25.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "SettingKindCell1.h"

@implementation SettingModelKind1


@end

@implementation SettingKindCell1

-(void)updateCellWithModel:(SettingModelKind1*)model{
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.iconUrl]];
    self.leftTextLabel.text = model.leftText;
}
@end

