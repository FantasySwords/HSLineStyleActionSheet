//
//  HSLineStyleActionSheetItem.h
//  HSActionSheet
//
//  Created by Jerry Ho on 16/7/19.
//  Copyright © 2016年 ThinkCode. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HSLineStyleActionSheetCell;

@interface HSLineStyleActionSheetCell : UIView

@property (nonatomic, strong, readonly) UILabel * titleLabel;

@property (nonatomic, strong, readonly) UIImageView * imageView;

@property (nonatomic, strong) NSIndexPath * indexPath;

@end
