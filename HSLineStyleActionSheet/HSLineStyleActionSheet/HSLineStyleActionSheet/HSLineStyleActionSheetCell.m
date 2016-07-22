//
//  HSLineStyleActionSheetItem.m
//  HSActionSheet
//
//  Created by Jerry Ho on 16/7/19.
//  Copyright © 2016年 ThinkCode. All rights reserved.
//

#import "HSLineStyleActionSheetCell.h"

@interface HSLineStyleActionSheetCell ()

@property (nonatomic, strong, readwrite) UILabel * titleLabel;

@property (nonatomic, strong, readwrite) UIImageView * imageView;

@end

@implementation HSLineStyleActionSheetCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
     
        [self setupLineStyleActionSheetItemUI];
    }
    return self;
}

- (void)setupLineStyleActionSheetItemUI
{
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    
    self.imageView.frame = CGRectMake((self.frame.size.width - 56) / 2, 0, 56, 56);
    
    self.titleLabel.frame = CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20);
    self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
}

- (UILabel *)titleLabel
{
    if (_titleLabel) {
        return _titleLabel;
    }
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.font = [UIFont systemFontOfSize:12];
    _titleLabel.textColor = [UIColor colorWithRed:0.25 green:0.24 blue:0.24 alpha:1.00];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    return _titleLabel;
}

- (UIImageView *)imageView
{
    if (_imageView ) {
        return _imageView;
    }
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    return _imageView;
}


@end
