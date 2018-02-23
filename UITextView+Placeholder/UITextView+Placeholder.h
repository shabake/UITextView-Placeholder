//
//  UITextView+Placeholder.h
//  UITextView+Placeholder
//
//  Created by GHome on 2018/2/22.
//  Copyright © 2018年 GHome. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^textViewHeight)(CGFloat textViewHeight,UITextView *textView);

@interface UITextView (Placeholder)
/** 占位文字 */
@property (nonatomic , copy) NSString *placeholder;
/** 占位文字字体 */
@property (nonatomic , strong) UIFont *placeholderFont;
/** 占位文字颜色 */
@property (nonatomic , strong) UIColor *placeholderColor;

@property (nonatomic, copy) textViewHeight textViewHeight;
@property (nonatomic, assign) CGFloat maxHeight;
@property (nonatomic, assign) CGFloat minHeight;
@end
