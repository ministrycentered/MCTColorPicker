// MCTColorPickerBarView.m
// 
// Copyright (c) 2014 Ministry Centered Technology
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "MCTColorPickerBarView.h"

@interface MCTColorPickerBarView ()

@end

@implementation MCTColorPickerBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self mct_setupView];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self mct_setupView];
    }
    return self;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        [self mct_setupView];
    }
    return self;
}
- (void)mct_setupView {
    [self.barLayer setNeedsDisplay];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(mct_gestureRecognizerDidRecognize:)];
    longPress.minimumPressDuration = 0.01;
    [self addGestureRecognizer:longPress];
}

+ (Class)layerClass {
    return [MCTColorPickerBarLayer class];
}

- (MCTColorPickerBarLayer *)barLayer {
    if ([self.layer isKindOfClass:[MCTColorPickerBarLayer class]]) {
        return (MCTColorPickerBarLayer *)self.layer;
    }
    return nil;
}

#pragma mark -
#pragma mark - Gesture
- (void)mct_gestureRecognizerDidRecognize:(UILongPressGestureRecognizer *)longPress {
    if (self.changeHandler) {
        CGColorRef cgColor = MCTCreateColorForHSV([self.barLayer hsvForPoint:[longPress locationInView:self]]);
        
        if (cgColor) {
            UIColor *color = [UIColor colorWithCGColor:cgColor];
            CGColorRelease(cgColor);
            
            if (color) {
                typeof(self) __weak welf = self;
                self.changeHandler(welf, color);
            }
        }
    }
}

@end
