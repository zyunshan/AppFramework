//
//  SettingKindCell3.h
//  AppFramework
//
//  Created by cnsunrun on 2017/4/26.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface SettingKindModel3 : NSObject

@property (nonatomic, copy) NSString *leftText;
//点击 cell 触发方法名
@property (copy, nonatomic) NSString *method;
@end

@interface SettingKindCell3 : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *leftTextLabel;
@end
