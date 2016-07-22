//
//  HSLineStyleActionSheet.h
//  HSActionSheet
//
//  Created by Jerry Ho on 16/7/18.
//  Copyright © 2016年 ThinkCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSLineStyleActionSheetItem.h"

@protocol HSLineStyleActionSheetDelegate;



@interface HSLineStyleActionSheet : UIViewController


@property (nonatomic, weak) id<HSLineStyleActionSheetDelegate> delegate;

@property (nonatomic, strong) UIColor * backgroundColor;

- (void)show;

@end


@protocol HSLineStyleActionSheetDelegate <NSObject>

@optional

- (UIEdgeInsets)lineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet insetsForRowAtIndex:(NSInteger)row;

- (CGFloat)lineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet widthForItemAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)lineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet heightForHeaderInRow:(NSInteger)row;

- (CGFloat)lineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet heightForRow:(NSInteger)row;

- (void)lineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet touchAtIndexPath:(NSIndexPath *)indexPath;

@required

- (NSInteger)numberOfRowsInLineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet;

- (NSInteger)lineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet numberOfItemsInRow:(NSInteger)row;

- (NSString *)lineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet titleForHeaderInRow:(NSInteger)row;

- (HSLineStyleActionSheetItem *)lineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet itemAtIndexPath:(NSIndexPath *)indexPath;

@end