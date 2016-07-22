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

//设置Sheet的背景色
@property (nonatomic, strong) UIColor * backgroundColor;

- (void)show;

@end


@protocol HSLineStyleActionSheetDelegate <NSObject>

@optional

/**
 *  设置指定行的上下左右边距 #Waring 当前版本请不要使用
 *
 *  @param row              指定行的索引
 */
- (UIEdgeInsets)lineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet insetsForRowAtIndex:(NSInteger)row;

/**
 * 设置指定item的宽度
 */
- (CGFloat)lineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet widthForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 * 设置指定行item的高度 #Waring item的高度不是行高，行高= item高度 + 上边距 + 下边距
 */
- (CGFloat)lineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet heightForHeaderInRow:(NSInteger)row;

/**
 *  设置行标题的高度 #Waring 当前版本请不要使用
 */
- (CGFloat)lineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet heightForRow:(NSInteger)row;

/**
 *  用户点击某个item
 *
 *  @param indexPath       点击item的indexPath indexPath.section表示行，indexPath.item表示列
 */
- (void)lineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet touchAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  设置指定行的标题
 *
 *  @param row             行索引
 *
 *  @return 指定行的标题
 */
- (NSString *)lineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet titleForHeaderInRow:(NSInteger)row;

@required

/**
 *  代理方法：获取LineStyleActionSheet的行数
 */
- (NSInteger)numberOfRowsInLineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet;

/**
 *  代理方法：获取指定行的Item数量
 *
 *  @param row             指定行的索引
 */
- (NSInteger)lineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet numberOfItemsInRow:(NSInteger)row;


/**
 *  代理方法：获取指定Item的图片和标题
 *
 *  @param indexPath       item的indexPath indexPath.section表示行，indexPath.item表示列
 *
 *  @return 以HSLineStyleActionSheetItem对象的形式返回图片和标题
 */
- (HSLineStyleActionSheetItem *)lineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet itemAtIndexPath:(NSIndexPath *)indexPath;

@end