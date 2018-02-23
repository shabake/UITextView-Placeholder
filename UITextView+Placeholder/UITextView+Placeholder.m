//
//  UITextView+Placeholder.m
//  UITextView+Placeholder
//
//  Created by GHome on 2018/2/22.
//  Copyright © 2018年 GHome. All rights reserved.
//

#import "UITextView+Placeholder.h"
#import <objc/runtime.h>

static NSString *placeholderKey = @"placeholderKey";
static NSString *placeholderViewKey = @"placeholderViewKey";
static NSString *placeholderFontKey = @"placeholderFontKey";
static NSString *placeholderColorKey = @"placeholderColorKey";
static NSString *lastHeightKey = @"lastHeightKey";
static NSString *maxHeightKey = @"maxHeightKey";
static NSString *minHeightKey = @"minHeightKey";
static NSString *textViewHeightDidChangedKey = @"textViewHeightDidChangedKey";

@interface UITextView()<UITextViewDelegate>
// 存储最后一次改变高度后的值
@property (nonatomic, assign) CGFloat lastHeight;
@end
@implementation UITextView (Placeholder)

- (void)textViewTextChange {
    UITextView *placeholderView = objc_getAssociatedObject(self, &placeholderViewKey);
    placeholderView.hidden = self.text.length > 0 ? YES:NO;
    
    NSInteger currentHeight = ceil([self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)].height);
    self.scrollEnabled = NO;

    if (currentHeight >= self.bounds.size.height) {
        
        if (currentHeight >= self.lastHeight) {
            CGFloat currentTextViewHeight = currentHeight;
            CGRect frame = self.frame;
            frame.size.height = currentTextViewHeight;
            self.frame = frame;
            self.lastHeight = currentTextViewHeight;
                if (self.textViewHeight) {
                    self.textViewHeight(currentTextViewHeight,self);
                }
        }
    }else {
        
        if (currentHeight < self.lastHeight) {
            CGFloat currentTextViewHeight = currentHeight;
            CGRect frame = self.frame;
            frame.size.height = currentTextViewHeight;
            self.frame = frame;
            self.lastHeight = currentTextViewHeight;
            if (self.textViewHeight) {
                self.textViewHeight(currentTextViewHeight,self);
            }
        }
    }

}

#pragma mark - set
- (void)setTextViewHeight:(textViewHeight)textViewHeight {
    objc_setAssociatedObject(self, &textViewHeightDidChangedKey, textViewHeight, OBJC_ASSOCIATION_RETAIN);
}
- (void)setLastHeight:(CGFloat)lastHeight {
    objc_setAssociatedObject(self, &lastHeightKey, [NSNumber numberWithFloat:lastHeight], OBJC_ASSOCIATION_RETAIN);

}
- (void)setMinHeight:(CGFloat)minHeight {
    objc_setAssociatedObject(self, &minHeightKey, [NSNumber numberWithFloat:minHeight], OBJC_ASSOCIATION_RETAIN);
}
- (void)setMaxHeight:(CGFloat)maxHeight {
    objc_setAssociatedObject(self, &maxHeightKey, [NSNumber numberWithFloat:maxHeight], OBJC_ASSOCIATION_RETAIN);
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    objc_setAssociatedObject(self, &placeholderColor, placeholderColor, OBJC_ASSOCIATION_RETAIN);
    UITextView *placeholderView = objc_getAssociatedObject(self, &placeholderViewKey);
    placeholderView.textColor = placeholderColor;
}
- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    objc_setAssociatedObject(self, &placeholderFontKey, placeholderFont, OBJC_ASSOCIATION_RETAIN);
    UITextView *placeholderView = objc_getAssociatedObject(self, &placeholderViewKey);
    placeholderView.font = placeholderFont;
    self.font = placeholderFont;

}
- (void)setPlaceholder:(NSString *)placeholder {
    objc_setAssociatedObject(self, &placeholderKey, placeholder, OBJC_ASSOCIATION_RETAIN);
    [self placeholderView].text = placeholder;
}

#pragma mark - get

- (textViewHeight)textViewHeight{
    return objc_getAssociatedObject(self, &textViewHeightDidChangedKey);

}
- (CGFloat)lastHeight {
    NSNumber *lastHeight = objc_getAssociatedObject(self, &lastHeightKey);
    return lastHeight.floatValue;
}
- (CGFloat)minHeight {
    NSNumber *minHeight = objc_getAssociatedObject(self, &minHeightKey);
    minHeight = @44;
    return minHeight.floatValue;
}
- (CGFloat)maxHeight {
    NSNumber *maxHeight = objc_getAssociatedObject(self, &maxHeightKey);
    maxHeight = [NSNumber numberWithFloat:self.bounds.size.height];
    return maxHeight.floatValue;
}
- (UIColor *)placeholderColor {
    return objc_getAssociatedObject(self, &placeholderColorKey);

}
- (UIFont *)placeholderFont {
    return objc_getAssociatedObject(self, &placeholderFontKey);
}

- (UITextView *)placeholderView {
    
    UITextView *placeholderView = objc_getAssociatedObject(self, &placeholderViewKey);
    
    if (!placeholderView) {
        
        placeholderView = [[UITextView alloc] init];
        objc_setAssociatedObject(self, &placeholderViewKey, placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        placeholderView = placeholderView;
        
        placeholderView.frame = self.bounds;
        placeholderView.scrollEnabled = placeholderView.userInteractionEnabled = NO;
        placeholderView.backgroundColor = [UIColor clearColor];
        [self addSubview:placeholderView];
        
        // 监听文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextChange) name:UITextViewTextDidChangeNotification object:self];
        
        NSArray *propertys = @[@"frame", @"bounds", @"font", @"text", @"textAlignment", @"textContainerInset"];
        
        // 监听属性
        for (NSString *property in propertys) {
            [self addObserver:self forKeyPath:property options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        }
        
    }
    return placeholderView;
}

#pragma mark - KVO监听属性改变
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSLog(@"22222");
}
- (NSString *)placeholder {
    NSString *placeholder = objc_getAssociatedObject(self, &placeholderKey);
   
    return placeholder.length > 0 ? objc_getAssociatedObject(self, &placeholderKey) : nil;
}


@end
