//
//  ViewController.m
//  DropDownViewDemo
//
//  Created by 思 彭 on 2017/10/13.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "ViewController.h"
#import "DropDownMenuView.h"

@interface ViewController ()

@property (nonatomic, strong) DropDownMenuView * dropdownMenu;
@property (nonatomic, assign) BOOL flag;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    self.navigationController.navigationBar.translucent = NO;
    [self setupNavItem];
}

- (void)setupNavItem {

    UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0 , 100, 40);
    [button setTitle:@"点击" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = button;
}

- (void)click:(UIButton *)button {
    
    button.selected = !button.selected;
    self.flag = button.selected;
    if (self.flag) {
//        NSLog(@"显示");
        self.dropdownMenu = [DropDownMenuView shareInstance];
        [self.dropdownMenu setMenuTitles:@[@"选项一",@"选项二",@"选项三",@"选项四", @"选项五", @"选项六"] rowHeight:44];
        [self.view addSubview:self.dropdownMenu];
        self.dropdownMenu.didSelectBlock = ^(NSInteger index, NSString *selectedStr) {
            NSLog(@"index = %ld str = %@", index, selectedStr);
        };
        [self.dropdownMenu showDropDown];
    } else {
//        NSLog(@"隐藏");
        [self.dropdownMenu hideDropDown];
    }
}

@end
