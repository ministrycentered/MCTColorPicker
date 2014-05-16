// MCTColorPickerBarLayer.m
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

#import "MCTColorPickerBarLayer.h"
#import "MCTColorPickerHelpers.h"

@interface MCTColorPickerBarLayer ()

@end

@implementation MCTColorPickerBarLayer

- (void)drawInContext:(CGContextRef)ctx {
    CGImageRef image = MCTColorPickerCreateBarImage(MCTHSVHue, (MCTHSV){0.0,1.0,1.0});
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

- (MCTHSV)hsvForPoint:(CGPoint)point {
    CGFloat width = CGRectGetWidth(self.bounds);
    if (width == 0.0) {
        return (MCTHSV){0.0,1.0,1.0};
    }
    CGFloat percent = point.x / width;
    CGFloat rawHue  = 360.0 * percent;
    CGFloat hue = rawHue / 360.0;
    
    return (MCTHSV){hue,1.0,1.0};
}

@end
