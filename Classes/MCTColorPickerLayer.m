// MCTColorPickerLayer.m
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

#import "MCTColorPickerLayer.h"

@interface MCTColorPickerLayer ()

@property (nonatomic, readwrite) MCTHSV hsv;

@end

@implementation MCTColorPickerLayer

- (void)setColor:(CGColorRef)color {
    [self willChangeValueForKey:@"color"];
    [self mct_ReleaseColor];
    
    _color = color;
    
    CGColorRetain(_color);
    
    MCTHSV hsv = MCTCreateHSVFromColor(_color);
    hsv.s = 1.0;
    hsv.v = 1.0;
    self.hsv = hsv;
    
    
    [self didChangeValueForKey:@"color"];
    
    [self setNeedsDisplay];
}

- (void)drawInContext:(CGContextRef)ctx {
    CGImageRef image = MCTColorPickerCreateHSLMapImage(self.hsv.h);
    if (!image) {
        return;
    }
    
    CGRect draw = CGContextGetClipBoundingBox(ctx);
    
    CGContextSaveGState(ctx); {
        CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, CGRectGetHeight(draw));
        CGContextConcatCTM(ctx, flipVertical);
        CGContextDrawImage(ctx, draw, image);
    } CGContextRestoreGState(ctx);
    
    CGImageRelease(image);
}

- (void)dealloc {
    [self mct_ReleaseColor];
}

#pragma mark -
#pragma mark - Helper
- (MCTHSV)hsvForPoint:(CGPoint)point {
    CGFloat sPer = (point.x / CGRectGetWidth(self.bounds));
    CGFloat vPer = 1.0 - (point.y / CGRectGetHeight(self.bounds));
    
    MCTHSV hsv;
    hsv.h = self.hsv.h;
    hsv.s = sPer;
    hsv.v = vPer;
    
    return hsv;
}
- (CGPoint)pointForHSV:(MCTHSV)hsv {
    CGFloat x = CGRectGetWidth(self.bounds) * hsv.s;
    CGFloat y = CGRectGetHeight(self.bounds) - (CGRectGetHeight(self.bounds) * hsv.v);
    return (CGPoint){floorf(x),floorf(y)};
}

#pragma mark -
#pragma mark - Mem
- (void)mct_ReleaseColor {
    if (_color) {
        CGColorRelease(_color);
    }
}

@end
