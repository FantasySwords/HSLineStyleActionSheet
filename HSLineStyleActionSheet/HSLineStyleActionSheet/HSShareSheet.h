//
//  HSShareSheet.h
//  HSLineStyleActionSheet
//
//  Created by Jerry Ho on 16/7/21.
//  Copyright © 2016年 ThinkCode. All rights reserved.
//

#import "HSLineStyleActionSheet.h"

@interface HSShareSheet : HSLineStyleActionSheet

- (instancetype)initWithButtonClickedAction:(void (^)(NSIndexPath *)) buttonClickedAtIndexPath;

@end
