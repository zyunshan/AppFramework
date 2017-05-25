//
//  BaseTableViewCell.h
//  AppFramework
//
//  Created by cnsunrun on 2017/2/25.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

@property (weak, nonatomic) id model;

@property (nonatomic, copy) void (^clickCallback)(NSInteger tag, id info);

-(void)updateCellWithModel:(id)model;

+(CGFloat)rowHeightWithModel:(id)model;

+(NSDictionary *)atributes;

/**
 多选选择效果处理
 */
-(void)multipleSelected:(BOOL)selected;

/**
 计算文字高度

 @param content 文字内容
 @param size 文字显示大小
 @return 自适应大小
 */
+(CGFloat )heightWithContent:(NSString *)content inSize:(CGSize)size;
@end
