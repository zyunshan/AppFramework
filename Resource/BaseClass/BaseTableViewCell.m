//
//  BaseTableViewCell.m
//  AppFramework
//
//  Created by cnsunrun on 2017/2/25.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateCellWithModel:(id)model{
    self.model = model;
}

+(CGFloat)rowHeightWithModel:(id)model{
    return 44;
}

/**
 文字属性
 */
+(NSDictionary *)atributes{
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc]init];
    para.lineSpacing = 4;
    return @{NSFontAttributeName : [UIFont systemFontOfSize:16],
             NSParagraphStyleAttributeName : para};
}

+(CGFloat )heightWithContent:(NSString *)content inSize:(CGSize)size{
    if (validateEmpty(content)) {
        return 0;
    }
    CGSize contentSize = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:[self atributes] context:NULL].size;
    return contentSize.height;
}


-(void)multipleSelected:(BOOL)selected{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITableViewCellEditControl")]) {
            UIImageView *imageView = [view valueForKey:@"imageView"];
            if (imageView) {
                if (selected) {
                  imageView.image = [UIImage imageNamed:@"home_message_choose"];
                }else{
                    imageView.image = [UIImage imageNamed:@"home_message_choose_no"];
                }
            }
        }
    }
}
@end
