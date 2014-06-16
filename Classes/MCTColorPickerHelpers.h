// MCTColorPickerHelpers.h
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

@import Foundation;
@import QuartzCore;

#ifndef MCTColorPickerHelpers_h
#define MCTColorPickerHelpers_h

typedef struct {CGFloat h,s,v;} MCTHSV;
typedef struct {CGFloat r,g,b;} MCTRGB;
typedef NS_ENUM(uint32_t, MCTHSVIDX) {
    MCTHSVHue = 0,
    MCTHSVSat = 1,
    MCTHSVVal = 2
};

FOUNDATION_EXTERN CGImageRef MCTColorPickerCreateHSLMapImage(CGFloat hue);
FOUNDATION_EXTERN CGImageRef MCTColorPickerCreateBarImage(MCTHSVIDX hsvIndex, MCTHSV hsv);

FOUNDATION_EXTERN void MCTColorPickerHueComponentFactors(CGFloat hue, CGFloat *red, CGFloat *green, CGFloat *blue);

FOUNDATION_EXTERN MCTRGB MCTRGBFromMCTHSV(MCTHSV hsv);
FOUNDATION_EXTERN MCTHSV MCTHSVFromMCTRGB(MCTRGB rgb);

FOUNDATION_EXTERN UInt8 MCTBlendValue(UInt8 value, UInt8 percent);

FOUNDATION_EXTERN CGColorRef MCTCreateColorForHSV(MCTHSV hsv);
FOUNDATION_EXTERN CGColorRef MCTCreateColorFromRGB(MCTRGB rgb);

FOUNDATION_EXTERN MCTRGB MCTCreateRGBFromColor(CGColorRef color);
FOUNDATION_EXTERN MCTHSV MCTCreateHSVFromColor(CGColorRef color);

@protocol MCTColorPickerPointView <NSObject>

- (void)moveToPoint:(CGPoint)point;

@end

#endif
