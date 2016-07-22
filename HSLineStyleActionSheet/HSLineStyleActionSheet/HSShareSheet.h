//
//  HSShareSheet.h
//  HSLineStyleActionSheet
//
//  Created by 东电创新 on 16/7/21.
//  Copyright © 2016年 Jerry Ho. All rights reserved.
//

#import "HSLineStyleActionSheet.h"

@interface HSShareSheet : HSLineStyleActionSheet

- (instancetype)initWithButtonClickedAction:(void (^)(NSIndexPath *)) buttonClickedAtIndexPath;

@end
