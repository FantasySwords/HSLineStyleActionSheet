//
//  HSLineStyleActionSheet.m
//  HSActionSheet
//
//  Created by Jerry Ho on 16/7/18.
//  Copyright © 2016年 ThinkCode. All rights reserved.
//

#import "HSLineStyleActionSheet.h"
#import "HSLineStyleActionSheetCell.h"
#define SCREEN_SIZE ([UIScreen mainScreen].bounds.size)

//动画时间
#define SHOW_ANIMATION_DURATION     0.2
#define DISMISS_ANIMATION_DURATION  0.25

#define SHEET_BUTTON_HEIGHT         48.f
#define DEFAULT_ROW_HEADER_HEIGHT   48.f

#define DEFAULT_CONTAINER_BACKGROUND_COLOR [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00]

@interface HSLineStyleActionSheet ()


//底部
@property (nonatomic, strong) UIView * bottomContainerView;

//背景图层
@property (nonatomic, strong) UIView * backgroundView;

//取消按钮
@property (nonatomic, strong) UIButton * cancelButton;

//Window
@property (nonatomic, strong) UIWindow * alertWindow;

@property (nonatomic, strong) NSArray * allSnsArray;

@end

@implementation HSLineStyleActionSheet
{
    CGFloat _bottomContainerViewHeight;
    //CGFloat _bottomContainerViewWidth;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self calcBottomContainerViewHeight];
    [self setupLineStyleActionSheetUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 配置UI
- (void)setupLineStyleActionSheetUI
{
    CGFloat screenHeight = SCREEN_SIZE.height;
    CGFloat screenWidth = SCREEN_SIZE.width;
    
    _backgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    _backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.24];
    _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_backgroundView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewTapAction:)];
    [_backgroundView addGestureRecognizer:tap];
    
    _bottomContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight, screenWidth, _bottomContainerViewHeight)];
    _bottomContainerView.backgroundColor = self.backgroundColor ?self.backgroundColor :DEFAULT_CONTAINER_BACKGROUND_COLOR ;
    [self.view addSubview:_bottomContainerView];
}

- (void)cancelButtonClicked:(UIButton *)button
{
    [self dismissWithAnimated:YES];
}

- (void)buildSheetItems
{
    CGFloat screenWidth = SCREEN_SIZE.width;
    
    CGFloat containerRelativeHeight = 0;
    for (int  i = 0;  i < [self numberOfRows]; i++) {
        CGFloat relativeHeight = 0;
        UIEdgeInsets insets = [self insetsForRowAtIndex:i];
        
        CGFloat itemHeight = [self heightForRow:i] + [self heightForHeaderInRow:i] + insets.top + insets.bottom;
        UIView * itemView = [[UIView alloc] initWithFrame:CGRectMake(0, containerRelativeHeight, screenWidth, itemHeight)];
        relativeHeight += insets.top;
        
        NSString * headerTitle = [self titleForHeaderInRow:i];
        CGFloat headerHeight = [self heightForHeaderInRow:i];
        if (headerTitle && headerHeight > 0.f) {
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(insets.left, relativeHeight, screenWidth - insets.left - insets.right, headerHeight)];
            label.text = headerTitle;
            label.textColor = [UIColor colorWithRed:0.41 green:0.41 blue:0.41 alpha:1.00];
            label.font = [UIFont systemFontOfSize:15];
            //label.backgroundColor = [UIColor redColor];
            [itemView addSubview:label];
            relativeHeight += headerHeight;
        }
        
        UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, relativeHeight, screenWidth, [self heightForRow:i])];
        //scrollView.backgroundColor = [UIColor blueColor];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        [itemView addSubview:scrollView];
        
        {
            CGFloat relativeX = 7;
            CGFloat cellHeight = [self heightForRow:i];
            for (int col = 0; col < [self numberOfItemsInRow:i]; col++) {
                CGFloat cellWidth = [self widthForItemAtIndexPath:[NSIndexPath indexPathForItem:col inSection:i]];
                HSLineStyleActionSheetItem * itemModel = [self itemAtIndexPath:[NSIndexPath indexPathForItem:col inSection:i]];
                HSLineStyleActionSheetCell * cell = [[HSLineStyleActionSheetCell alloc] initWithFrame:CGRectMake(relativeX, 0, cellWidth, cellHeight)];
                cell.titleLabel.text = itemModel.title;
                cell.imageView.image = itemModel.image;
                //cell.backgroundColor = [UIColor redColor];
                [scrollView addSubview:cell];
                
                //Tap
                UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer:)];
                [cell addGestureRecognizer:tap];
                
                cell.indexPath = [NSIndexPath indexPathForItem:col inSection:i];
                
                relativeX += cellWidth;
            }
            
            relativeX += 7;
            scrollView.contentSize = CGSizeMake(relativeX - 1 , cellHeight);
        }
        
        relativeHeight += [self heightForRow:i];
        relativeHeight += insets.bottom;
        [_bottomContainerView addSubview:itemView];
        containerRelativeHeight = itemHeight;
        
        if (i != [self numberOfRows] - 1) {
            UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, relativeHeight - 1 , screenWidth, 1)];
            lineView.backgroundColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.00];
            [itemView addSubview:lineView];
        }
    }
    
    //取消按钮
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButton.frame = CGRectMake(0, _bottomContainerViewHeight - SHEET_BUTTON_HEIGHT, screenWidth, SHEET_BUTTON_HEIGHT);
    _cancelButton.backgroundColor = [UIColor whiteColor];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    _cancelButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [_cancelButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomContainerView addSubview:_cancelButton];
    
}

//
- (CGFloat)calcBottomContainerViewHeight
{
    _bottomContainerViewHeight = SHEET_BUTTON_HEIGHT;
    for (int i = 0; i < [self numberOfRows]; i++) {
        UIEdgeInsets insets = [self insetsForRowAtIndex:i];
        _bottomContainerViewHeight += ([self heightForRow:i] + [self heightForHeaderInRow:i] + insets.top + insets.bottom);
    }

    return _bottomContainerViewHeight;
}



#pragma mark - Event Action

- (void)backgroundViewTapAction:(UITapGestureRecognizer *)tap
{
    [self dismissWithAnimated:YES];
}


- (UIWindow *)alertWindow
{
    if (_alertWindow == nil) {
        
        _alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _alertWindow.windowLevel       = UIWindowLevelStatusBar;
        _alertWindow.backgroundColor   = [UIColor clearColor];
        _alertWindow.hidden = NO;
        _alertWindow.rootViewController = self;
    }
    
    return _alertWindow;
}

- (void)tapGestureRecognizer:(UITapGestureRecognizer *)tap
{
    NSIndexPath * indexPath = ((HSLineStyleActionSheetCell *) tap.view).indexPath;
    
    if ([self.delegate respondsToSelector:@selector(lineStyleActionSheet:touchAtIndexPath:)]) {
        [self.delegate lineStyleActionSheet:self touchAtIndexPath:indexPath];
    }
    
    [self dismissWithAnimated:YES];
}

#pragma mark - public
- (void)showWithAnimated:(BOOL)animated
{
    [self alertWindow];
    
    self.bottomContainerView.frame = CGRectMake(0, SCREEN_SIZE.height , SCREEN_SIZE.width, _bottomContainerViewHeight);
    //self.backgroundView.alpha = 0;
    
    [UIView animateWithDuration:(animated ?SHOW_ANIMATION_DURATION :0.f) delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.bottomContainerView.frame = CGRectMake(0, SCREEN_SIZE.height - _bottomContainerViewHeight, SCREEN_SIZE.width, _bottomContainerViewHeight);
        self.backgroundView.alpha = 1.f;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)show
{
    [self showWithAnimated:YES];
    [self buildSheetItems];
}

- (void)dismissWithAnimated:(BOOL)animated
{
    [UIView animateWithDuration:(animated ?DISMISS_ANIMATION_DURATION :0.f) delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.bottomContainerView.frame = CGRectMake(0, SCREEN_SIZE.height, SCREEN_SIZE.width, _bottomContainerViewHeight);
        self.backgroundView.alpha = 0;
        //self.bottomContainerView.alpha = 0;
        
    } completion:^(BOOL finished) {
        self.alertWindow.hidden = YES;
        self.alertWindow.rootViewController = nil;
    }];
}


#pragma mark - Getter And Setter

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    backgroundColor = _backgroundColor;
    self.bottomContainerView.backgroundColor = backgroundColor;
}

#pragma mark - delegate call wrapper

- (NSInteger)numberOfRows
{
    if ([self.delegate respondsToSelector:@selector(numberOfRowsInLineStyleActionSheet:)]) {
        return [self.delegate numberOfRowsInLineStyleActionSheet:self];
    }
    
    return 1;
}

- (NSInteger)numberOfItemsInRow:(NSInteger)row
{
    if ([self.delegate respondsToSelector:@selector(lineStyleActionSheet:numberOfItemsInRow:)]) {
        return [self.delegate lineStyleActionSheet:self numberOfItemsInRow:row];
    }
    
    return 0;
}


- (NSString *)titleForHeaderInRow:(NSInteger)row
{
    if ([self.delegate respondsToSelector:@selector(lineStyleActionSheet:titleForHeaderInRow:)]) {
        return [self.delegate lineStyleActionSheet:self titleForHeaderInRow:row];
    }
    
    return nil;
}

- (UIEdgeInsets)insetsForRowAtIndex:(NSInteger)row
{
    if ([self.delegate respondsToSelector:@selector(lineStyleActionSheet:insetsForRowAtIndex:)]) {
        return [self.delegate lineStyleActionSheet:self insetsForRowAtIndex:row];
    }
    
    if ([self titleForHeaderInRow:row]) {
         return UIEdgeInsetsMake(0, 16, 10, 20);
    }
    
    return UIEdgeInsetsMake(13, 16, 10, 20);
}

- (CGFloat)widthForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(lineStyleActionSheet:widthForItemAtIndexPath:)]) {
        return [self.delegate lineStyleActionSheet:self widthForItemAtIndexPath:indexPath];
    }
    
    return 72;
}

- (CGFloat) heightForHeaderInRow:(NSInteger)row
{
    if ([self.delegate respondsToSelector:@selector(lineStyleActionSheet:heightForHeaderInRow:)]) {
        return [self.delegate lineStyleActionSheet:self heightForHeaderInRow:row];
    }else {
        if ([self titleForHeaderInRow:row]) {
            return DEFAULT_ROW_HEADER_HEIGHT;
        }
    }

    return 0;
}

- (CGFloat)heightForRow:(NSInteger)row
{
    if ([self.delegate respondsToSelector:@selector(lineStyleActionSheet:heightForRow:)]) {
        return [self.delegate lineStyleActionSheet:self heightForRow:row];
    }
    
    return 80;
}

- (HSLineStyleActionSheetItem *)itemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(lineStyleActionSheet:itemAtIndexPath:)]) {
        return [self.delegate lineStyleActionSheet:self itemAtIndexPath:indexPath];
    }
    
    return nil;
}

@end
