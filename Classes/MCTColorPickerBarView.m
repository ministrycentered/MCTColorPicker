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
#import "MCTColorPickerSubclassingHooks.h"

@interface MCTColorPickerBarView ()

@property (nonatomic) CGPoint selectedPoint;

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
    
    self.selectedPoint = CGPointZero;
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(mct_gestureRecognizerDidRecognize:)];
    longPress.minimumPressDuration = 0.01;
    [self addGestureRecognizer:longPress];
}

+ (Class)layerClass {
    return [MCTColorPickerBarLayer class];
}
- (CGSize)intrinsicContentSize {
    return CGSizeMake(255.0, UIViewNoIntrinsicMetric);
}

- (MCTColorPickerBarLayer *)barLayer {
    if ([self.layer isKindOfClass:[MCTColorPickerBarLayer class]]) {
        return (MCTColorPickerBarLayer *)self.layer;
    }
    return nil;
}

- (void)setHue:(CGFloat)hue {
    self.selectedPoint = CGPointMake(CGRectGetWidth(self.bounds) * hue, self.selectedPoint.y);
}

#pragma mark -
#pragma mark - Point View
- (void)setPointView:(UIView<MCTColorPickerPointView> *)pointView {
    if (_pointView) {
        [_pointView removeFromSuperview];
        _pointView = nil;
    }
    _pointView = pointView;
    
    if (_pointView) {
        [self addSubview:_pointView];
        [_pointView moveToPoint:self.selectedPoint];
    }
}

#pragma mark -
#pragma mark - Layout
- (void)layoutSubviews {
    [self.pointView moveToPoint:self.selectedPoint];
    [super layoutSubviews];
}

#pragma mark -
#pragma mark - Point
- (void)setSelectedPoint:(CGPoint)selectedPoint {
    selectedPoint = [self normalizeSelectedPoint:selectedPoint];
    
    _selectedPoint = selectedPoint;
    
    [self.pointView moveToPoint:selectedPoint];
    
    CGColorRef cgColor = MCTCreateColorForHSV([self.barLayer hsvForPoint:selectedPoint]);
    
    if (cgColor) {
        UIColor *color = [UIColor colorWithCGColor:cgColor];
        CGColorRelease(cgColor);
        
        if (color) {
            self.pickerView.color = color;
            if (self.changeHandler) {
                typeof(self) __weak welf = self;
                self.changeHandler(welf, color);
            }
        }
    }
    
   
}
- (CGPoint)normalizeSelectedPoint:(CGPoint)point {
    point.x = MIN(CGRectGetWidth(self.bounds), MAX(0.0, point.x));
    point.y = MIN(CGRectGetHeight(self.bounds), MAX(0.0, point.y));
    return point;
}

#pragma mark -
#pragma mark - Gesture
- (void)mct_gestureRecognizerDidRecognize:(UILongPressGestureRecognizer *)longPress {
    if (self.inputChangeHandler) {
        typeof(self) __weak welf = self;
        if (longPress.state == UIGestureRecognizerStateBegan) {
            self.inputChangeHandler(welf, YES);
        }
        if (longPress.state == UIGestureRecognizerStateEnded || longPress.state == UIGestureRecognizerStateCancelled) {
            self.inputChangeHandler(welf, NO);
        }
    }
    self.selectedPoint = [longPress locationInView:self];
}

@end
