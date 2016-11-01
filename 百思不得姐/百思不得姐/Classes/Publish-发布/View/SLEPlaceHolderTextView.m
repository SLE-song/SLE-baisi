//
//  SLEPlaceHolderTextView.m
//  百思不得姐
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLEPlaceHolderTextView.h"

@interface SLEPlaceHolderTextView()

/** 占位文字的label */
@property (weak ,nonatomic) UILabel *placeholderLabel;

@end

@implementation SLEPlaceHolderTextView

- (UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.sle_x = 4;
        placeholderLabel.sle_y = 8;
        placeholderLabel.numberOfLines = 0;
        [self addSubview:placeholderLabel];
        
        _placeholderLabel = placeholderLabel;
    }

    return _placeholderLabel;

}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.font = [UIFont systemFontOfSize:15];
        self.alwaysBounceVertical = YES;
        
        self.placeHolderColor = [UIColor grayColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }

    return self;


}

- (void)dealloc
{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)textDidChange
{
    self.placeholderLabel.hidden = self.hasText;

}


- (void)layoutSubviews
{

    [super layoutSubviews];

    self.placeholderLabel.sle_width = self.sle_width - 2 *self.placeholderLabel.sle_x;
//    CGSize maxSize = CGSizeMake(SLEScreenW - 2 *self.placeholderLabel.sle_x, MAXFLOAT);
//    
//    self.placeholderLabel.sle_size = [self.placeHolder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:nil].size;
    [self.placeholderLabel sizeToFit];

}

//- (void)drawRect:(CGRect)rect {
//    
//    if (self.hasText) return;
//    
//    rect.origin.x = 5;
//    rect.origin.y = 8;
//    rect.size.width -= 2 *rect.origin.x;
//    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
//    attr[NSForegroundColorAttributeName] = self.placeHolderColor;
//    attr[NSFontAttributeName] = self.font;
//    [self.placeHolder drawInRect:rect withAttributes:attr];
//
//    
//}




#pragma mark   重写setter方法
- (void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    
    _placeHolderColor = placeHolderColor;
    self.placeholderLabel.textColor = placeHolderColor;
    
    
}
- (void)setPlaceHolder:(NSString *)placeHolder
{
    
    _placeHolder = [placeHolder copy];
    self.placeholderLabel.text = placeHolder;
    
    [self setNeedsLayout];
    
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}


@end
