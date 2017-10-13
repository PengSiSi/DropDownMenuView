//
//  DropDownMenuView.m
//  DropDownViewDemo
//
//  Created by 思 彭 on 2017/10/13.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "DropDownMenuView.h"

#define AnimateTime 0.25f   // 下拉动画时间
#define kTableViewHeight 200.0f  // tabelView的高度

#define K_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define K_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

static DropDownMenuView *shareInstance = nil;

@interface DropDownMenuView () <UITableViewDataSource,UITableViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) NSArray *titlesArr;
@property (nonatomic, assign) CGFloat rowHeight;

@end

@implementation DropDownMenuView

+ (instancetype)shareInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc]init];
    });
    // 一进来就展开
//    [shareInstance showDropDown];
    return shareInstance;
}

- (instancetype)init {
    
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self createSubViews];
        [self addTapGestureRecognizerToSelf];
    }
    return self;
}

#pragma mark - setupUI

- (void)createSubViews {
    
    self.maskView = [[UIView alloc]initWithFrame:CGRectMake(0, -K_SCREEN_HEIGHT, K_SCREEN_WIDTH, kTableViewHeight)];
    [self addSubview:self.maskView];
    self.tableView.frame = CGRectMake(0, 0, K_SCREEN_WIDTH, kTableViewHeight);
    [self addSubview:self.tableView];
}

//添加手势
- (void)addTapGestureRecognizerToSelf {
    
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMaskView:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
}

#pragma mark - UIGestureRecognizerDelegate
/*
 解决didSelectRowAtIndexPath不能响应事件：
 UITapGestureRecognizer吞掉了touch事件，导致didSelectRowAtIndexPath方法无法响应。
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch  {
    // 输出点击的view的类名
    NSLog(@"%@", NSStringFromClass([touch.view class]));
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

- (void)setMenuTitles:(NSArray *)titlesArr rowHeight:(CGFloat)rowHeight {
    
    self.titlesArr = titlesArr;
    self.rowHeight = rowHeight;
}

- (void)tapMaskView: (UITapGestureRecognizer *)tap {
    NSLog(@"收起");
    [self hideDropDown];
}

- (void)showDropDown {
    
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:AnimateTime animations:^{
        CGRect newframe = self.maskView.frame;
        newframe.origin.y = 0;
        self.maskView.frame = newframe;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    } completion:^(BOOL finished) {
    }];
}

- (void)hideDropDown {
    
    [UIView animateWithDuration:AnimateTime animations:^{
        CGRect newframe = self.maskView.frame;
        newframe.origin.y = -K_SCREEN_HEIGHT;
        self.maskView.frame = newframe;
    } completion:^(BOOL finished) {
        self.backgroundColor = [UIColor clearColor];
        [self removeFromSuperview];
    }];
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.rowHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.titlesArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = self.titlesArr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:11.0f];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    !self.didSelectBlock ? : self.didSelectBlock(indexPath.row, self.titlesArr[indexPath.row]);
    [self hideDropDown];
}

#pragma mark - 懒加载

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, 200) style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

@end
