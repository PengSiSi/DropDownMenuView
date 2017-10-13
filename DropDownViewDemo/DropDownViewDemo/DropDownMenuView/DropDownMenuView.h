//
//  DropDownMenuView.h
//  DropDownViewDemo
//
//  Created by 思 彭 on 2017/10/13.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropDownMenuView : UIView

@property (nonatomic, copy) void(^didSelectBlock)(NSInteger index, NSString *selectedStr);/**<选择的返回类型回调 */

+ (instancetype)shareInstance;

- (void)setMenuTitles:(NSArray *)titlesArr rowHeight:(CGFloat)rowHeight;  // 设置下拉菜单控件样式

- (void)showDropDown; // 显示下拉菜单
- (void)hideDropDown; // 隐藏下拉菜单

@end
