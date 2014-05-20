// MCTColorPickerView.m
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

#import "MCTColorPickerView.h"
#import "MCTColorPickerSubclassingHooks.h"

static void *MCTColorPickerViewColorChangeContext = &MCTColorPickerViewColorChangeContext;

static CGFloat const MCTSelectedPointDefault = -MAXFLOAT;

@interface MCTColorPickerView ()

@property (nonatomic, strong, readwrite) UIColor *selectedColor;
@property (nonatomic) CGPoint selectedPoint;

@end

@implementation MCTColorPickerView
@synthesize selectedPoint = _selectedPoint;

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
    [self.pickerLayer addObserver:self forKeyPath:NSStringFromSelector(@selector(color)) options:0 context:MCTColorPickerViewColorChangeContext];
    
    self.color = [UIColor redColor];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(mct_gestureRecognizerDidRecognize:)];
    longPress.minimumPressDuration = 0.01;
    [self addGestureRecognizer:longPress];
    
    self.selectedPoint = CGPointMake(MCTSelectedPointDefault, MCTSelectedPointDefault);
}

+ (Class)layerClass {
    return [MCTColorPickerLayer class];
}

- (MCTColorPickerLayer *)pickerLayer {
    if ([self.layer isKindOfClass:[MCTColorPickerLayer class]]) {
        return (MCTColorPickerLayer *)self.layer;
    }
    return nil;
}
- (void)dealloc {
    [self.pickerLayer removeObserver:self forKeyPath:NSStringFromSelector(@selector(color)) context:MCTColorPickerViewColorChangeContext];
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(255.0, 255.0);
}

#pragma mark -
#pragma mark - Color
- (void)setColor:(UIColor *)color {
    self.pickerLayer.color = [color CGColor];
}
- (UIColor *)color {
    return [UIColor colorWithCGColor:self.pickerLayer.color];
}

#pragma mark -
#pragma mark - Setters
- (void)setSelectedColor:(UIColor *)selectedColor {
    _selectedColor = selectedColor;
    if (self.changeHandler) {
        typeof(self) __weak welf = self;
        self.changeHandler(welf, selectedColor);
    }
}
- (void)setSelectedPoint:(CGPoint)selectedPoint {
    selectedPoint = [self normalizeSelectedPoint:selectedPoint];
    _selectedPoint = selectedPoint;
    [self.pointView moveToPoint:self.selectedPoint];
    [self mct_updateFromPoint];
}
- (CGPoint)selectedPoint {
    CGPoint point = _selectedPoint;
    if (point.x == MCTSelectedPointDefault) {
        point.x = CGRectGetWidth(self.bounds);
    }
    if (point.y == MCTSelectedPointDefault) {
        point.y = 0.0;
    }
    return point;
}
- (CGPoint)normalizeSelectedPoint:(CGPoint)point {
    if (point.x != MCTSelectedPointDefault) {
        point.x = MIN(CGRectGetWidth(self.bounds), MAX(0.0, point.x));
    }
    if (point.y != MCTSelectedPointDefault) {
        point.y = MIN(CGRectGetHeight(self.bounds), MAX(0.0, point.y));
    }
    
    return point;
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
#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == MCTColorPickerViewColorChangeContext) {
        [self mct_updateFromPoint];
        return;
    }
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

#pragma mark -
#pragma mark - Update
- (void)mct_updateFromPoint {
    [self updateColors];
}

- (void)updateColors {
    CGColorRef color = MCTCreateColorForHSV([self.pickerLayer hsvForPoint:self.selectedPoint]);
    if (color) {
        self.selectedColor = [UIColor colorWithCGColor:color];
        CGColorRelease(color);
    }
}

#pragma mark -
#pragma mark - Gesture
- (void)mct_gestureRecognizerDidRecognize:(UILongPressGestureRecognizer *)longPress {
    self.selectedPoint = [longPress locationInView:self];
}

@end
