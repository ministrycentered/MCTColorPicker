// MCTColorPickerLayer.h
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

#ifndef MCTColorPickerLayer_h
#define MCTColorPickerLayer_h

@import QuartzCore;

#import "MCTColorPickerHelpers.h"

/**
 *  Layer for displaying the saturation/value picker
 */
@interface MCTColorPickerLayer : CALayer

/**
 *  The HSV for the current color.
 *
 *  Saturation and Value will always be 1.0
 */
@property (nonatomic, readonly) MCTHSV hsv;

/**
 *  The CGColor that is currently being displayed
 */
@property (nonatomic) CGColorRef color;

/**
 *  Return the HSV value for the passed point
 *
 *  @param point The point for the HSV in the layers coordinate space
 *
 *  @return The HSV
 */
- (MCTHSV)hsvForPoint:(CGPoint)point;

@end

#endif
