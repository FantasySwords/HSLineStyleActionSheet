//
//  HSShareSheet.m
//  HSLineStyleActionSheet
//
//  Created by 东电创新 on 16/7/21.
//  Copyright © 2016年 Jerry Ho. All rights reserved.
//

#import "HSShareSheet.h"

@interface HSShareSheet () <HSLineStyleActionSheetDelegate>

@property (nonatomic, strong) NSArray * shareTitleArray;

@property (nonatomic, strong) NSArray * shareImageArray;

//buttonClickedAction
@property (nonatomic, copy) void (^buttonClickedAction)(NSIndexPath *);

@end

@implementation HSShareSheet

- (instancetype)initWithButtonClickedAction:(void (^)(NSIndexPath *)) buttonClickedAtIndexPath
{
    if (self = [super init]) {
        self.buttonClickedAction = buttonClickedAtIndexPath;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _shareTitleArray = @[@"微信朋友圈", @"微信好友", @"手机QQ", @"QQ空间", @"新浪微博", @"支付宝", @"生活圈"];
    _shareImageArray = @[@"circlefriends", @"weixin", @"qq", @"qzone", @"weibo", @"zhifubao", @"zhifubao_friend"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setDelegate:(id<HSLineStyleActionSheetDelegate>)delegate
{
    if (delegate == self) {
        [super setDelegate:delegate];
    }
}

- (void)show
{
     self.delegate = self;
    [super show];
}


- (NSInteger)numberOfRowsInLineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet
{
    return 1;
}

- (NSInteger)lineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet numberOfItemsInRow:(NSInteger)row
{
    switch (row) {
        case 0:
            return _shareTitleArray.count;
            break;
        default:
            break;
    }
    
    return 0;
}

- (NSString *)lineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet titleForHeaderInRow:(NSInteger)row
{
    return @"分享到";
}


- (HSLineStyleActionSheetItem *)lineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet itemAtIndexPath:(NSIndexPath *)indexPath
{
    HSLineStyleActionSheetItem * item = [[HSLineStyleActionSheetItem alloc] init];
    item.title = _shareTitleArray[indexPath.item];
    item.image = [UIImage imageNamed:_shareImageArray[indexPath.item]];
    return item;
}

- (void)lineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet touchAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.buttonClickedAction) {
        self.buttonClickedAction(indexPath);
    }
}

@end
