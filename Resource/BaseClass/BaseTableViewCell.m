//
//  BaseTableViewCell.m
//  AppFramework
//
//  Created by cnsunrun on 2017/2/25.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

-(instancetype)initWithReuseIndentifier:(NSString *)indentifier{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    if (self) {
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateCellWithModel:(id)model{
    self.model = model;
}

+(CGFloat)rowHeight{
    return 44;
}
@end
