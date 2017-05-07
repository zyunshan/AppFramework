//
//  SettingKindCell2.h
//  AppFramework
//
//  Created by cnsunrun on 2017/4/26.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface SettingKindModel2 : NSObject

@property (nonatomic, copy) NSString *leftText;
@property (nonatomic, copy) NSString *rightText;
//点击 cell 触发方法名
@property (copy, nonatomic) NSString *method;
@end

@interface SettingKindCell2 : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *leftTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightTextLabel;
@end
