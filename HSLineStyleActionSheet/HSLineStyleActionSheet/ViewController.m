//
//  ViewController.m
//  HSLineStyleActionSheet
//
//  Created by 东电创新 on 16/7/20.
//  Copyright © 2016年 Jerry Ho. All rights reserved.
//

#import "ViewController.h"
#import "HSLineStyleActionSheet.h"
#import "HSShareSheet.h"

@interface ViewController ()<HSLineStyleActionSheetDelegate>

@property (nonatomic, strong) NSArray * line1Array;

@property (nonatomic, strong) NSArray * line1ImageArray;

@property (nonatomic, strong) NSArray * line2Array;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _line1Array = @[@"微信朋友圈", @"微信好友", @"手机QQ", @"QQ空间", @"新浪微博", @"支付宝", @"生活圈"];
    _line1ImageArray = @[@"circlefriends", @"weixin", @"qq", @"qzone", @"weibo", @"zhifubao", @"zhifubao_friend"];
    
    _line2Array = @[@"系统分享", @"短信", @"邮件", @"复制链接"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)btn1:(id)sender {
    HSLineStyleActionSheet * actionSheet = [[HSLineStyleActionSheet alloc] init];
    actionSheet.delegate = self;
    [actionSheet show];
}


- (IBAction)btn2:(id)sender {
    HSShareSheet * shareSheet = [[HSShareSheet alloc] initWithButtonClickedAction:^(NSIndexPath * indexPath) {
         NSLog(@"点击了第%ld个",indexPath.item);
    }];
    [shareSheet show];
}

- (NSInteger)numberOfRowsInLineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet
{
    return 2;
}

- (NSInteger)lineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet numberOfItemsInRow:(NSInteger)row
{
    switch (row) {
        case 0:
            return _line1Array.count;
            break;
        case 1:
            return _line2Array.count;
            break;
        default:
            break;
    }
   
    return 0;
}

- (NSString *)lineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet titleForHeaderInRow:(NSInteger)row
{
    if (row == 0) {
        return @"分享到";
    }
    
    return nil;
}


- (HSLineStyleActionSheetItem *)lineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet itemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        HSLineStyleActionSheetItem * item = [[HSLineStyleActionSheetItem alloc] init];
        item.title =  _line1Array[indexPath.item];
        item.image = [UIImage imageNamed:_line1ImageArray[indexPath.item]];
        return item;
    }else {
        HSLineStyleActionSheetItem * item = [[HSLineStyleActionSheetItem alloc] init];
        item.title =  _line2Array[indexPath.item];
        item.image = [UIImage imageNamed:@"simple-icon"];
        return item;
    }
}

- (void)lineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet touchAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了第%ld行，第%ld列", indexPath.section, indexPath.item);
}

@end
