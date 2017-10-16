//
//  ViewController.m
//  DropDownViewDemo
//
//  Created by 思 彭 on 2017/10/13.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "ViewController.h"
#import "DropDownMenuView.h"
#import "CustomButton.h"
#import "UIButton+ImageTitleSpacing.h"

@interface ViewController ()

@property (nonatomic, strong) DropDownMenuView * dropdownMenu;
@property (nonatomic, assign) BOOL flag;
@property (nonatomic, weak) UIButton *changeButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    self.navigationController.navigationBar.translucent = NO;
    [self setupNavItem];
}

- (void)setupNavItem {

    UIButton *changeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [changeButton setTitle:@"全部全部" forState:UIControlStateNormal];
    changeButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [changeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.changeButton = changeButton;
    [changeButton setImage:[UIImage imageNamed:@"address_select"] forState:UIControlStateNormal];
    [changeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    changeButton.frame = CGRectMake(0, 0, 80, 20);
    // 我们随意创建一个按钮比如button，在设置完按钮的图片、标题和frame后，只需要加上如下代码：
    [changeButton layoutButtonWithEdgeInsetsStyle: MKButtonEdgeInsetsStyleRight imageTitleSpace: 5];
    changeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [changeButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeButton];
    self.navigationItem.titleView = changeButton;
}

- (void)click:(UIButton *)button {
    
    button.selected = !button.selected;
    self.flag = button.selected;
    __weak typeof(self) weakSelf = self;
    if (self.flag) {
        self.dropdownMenu = [DropDownMenuView shareInstance];
        [self.dropdownMenu setMenuTitles:@[@"全部全部", @"选项一",@"选项二",@"选项三",@"选项四", @"选项五", @"选项六选项六选项六选项六"] rowHeight:44];
        [self.view addSubview:self.dropdownMenu];
        self.dropdownMenu.didSelectBlock = ^(NSInteger index, NSString *selectedStr) {
            NSLog(@"index = %ld str = %@", index, selectedStr);
            [weakSelf.changeButton setTitle:selectedStr forState:UIControlStateNormal];
            // 这里需要计算下文字的宽度
            CGFloat width = [selectedStr boundingRectWithSize:CGSizeMake(9999, 40) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:20]} context:nil].size.width;
            weakSelf.changeButton.frame = CGRectMake(0, 0, width, 40);
            [weakSelf.changeButton layoutButtonWithEdgeInsetsStyle: MKButtonEdgeInsetsStyleRight imageTitleSpace: 5];
        };
        [self.dropdownMenu showDropDown];
    } else {
//        NSLog(@"隐藏");
        [self.dropdownMenu hideDropDown];
    }
}

@end
