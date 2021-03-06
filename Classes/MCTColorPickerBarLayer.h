// MCTColorPickerBarLayer.h
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

#ifndef MCTColorPickerBarLayer_h
#define MCTColorPickerBarLayer_h

@import QuartzCore;

#import "MCTColorPickerHelpers.h"

/**
 *  Layer for displaying a hue picker.
 */
@interface MCTColorPickerBarLayer : CALayer

/**
 *  Get the HSV for the passed point
 *
 *  @param point The point in the bounds of the layer to get the HSV for
 *
 *  @return The HSV for the point.  The saturation and value will always be 1.0
 */
- (MCTHSV)hsvForPoint:(CGPoint)point;

@end

#endif
