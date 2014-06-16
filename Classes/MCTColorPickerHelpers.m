// MCTColorPickerHelpers.m
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

/* 
 * using the method presented here http://www.cs.rit.edu/~ncs/color/t_convert.html#RGB%20to%20HSV%20&%20HSV%20to%20RGB for conversions
 */

#import "MCTColorPickerHelpers.h"

#define MCT_RGB_MAX_I 255
#define MCT_RGB_MAX_F 255.0
#define MCT_BYTE_MULTI 4
#define MCT_BYTE_COMP 8

CGImageRef MCTColorPickerCreateHSLMapImage(CGFloat hue) {
    CGSize size = CGSizeMake(MCT_RGB_MAX_F, MCT_RGB_MAX_F);
    
    void *data = malloc(size.width * size.height * MCT_BYTE_MULTI);
    if (!data) {
        return nil;
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipFirst;
    
    CGContextRef context = CGBitmapContextCreate(data, size.width, size.height, MCT_BYTE_COMP, size.width * MCT_BYTE_MULTI, colorSpace, bitmapInfo);
    
    CGColorSpaceRelease(colorSpace);
    
    if (!context) {
        free(data);
        return nil;
    }
    
    UInt8 *dataPointer = data;
    
    size_t bytesPerRow = CGBitmapContextGetBytesPerRow(context);
    
    CGFloat r, g, b;
    MCTColorPickerHueComponentFactors(hue, &r, &g, &b);
    
    UInt8 redPercent   = (UInt8)((1.0 - r) * MCT_RGB_MAX_F);
    UInt8 greenPercent = (UInt8)((1.0 - g) * MCT_RGB_MAX_F);
    UInt8 bluePercent  = (UInt8)((1.0 - b) * MCT_RGB_MAX_F);
    
    uint32_t height = (uint32_t)size.height;
    uint32_t width = (uint32_t)size.width;
    
    for (int32_t idx = 0; idx <= width; ++idx) {
        UInt8 *ptr = dataPointer;
        
        uint32_t red   = width - MCTBlendValue(idx, redPercent);
        uint32_t green = width - MCTBlendValue(idx, greenPercent);
        uint32_t blue  = width - MCTBlendValue(idx, bluePercent);
        
        for (int32_t val = height; val >= 0; --val) {
            ptr[0] = (UInt8) (val * blue >> MCT_BYTE_COMP);
            ptr[1] = (UInt8) (val * green >> MCT_BYTE_COMP);
            ptr[2] = (UInt8) (val * red >> MCT_BYTE_COMP);
            
            ptr += bytesPerRow;
        }
        
        dataPointer += MCT_BYTE_MULTI;
    }
    
    CGImageRef image = CGBitmapContextCreateImage(context);
    
    CGContextRelease(context);
    free(data);
    
    return image;
}

CGImageRef MCTColorPickerCreateBarImage(MCTHSVIDX hsvIndex, MCTHSV hsv) {
    static size_t size = MCT_RGB_MAX_I + 1;
    
	UInt8 data[size * MCT_BYTE_MULTI];
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipFirst;
    
    CGContextRef context = CGBitmapContextCreate(data, size, 1.0, MCT_BYTE_COMP, size * MCT_BYTE_MULTI, colorSpace, bitmapInfo);
    
    CGColorSpaceRelease(colorSpace);
    
    if (!context) {
        return nil;
	}
	
	UInt8* ptr = CGBitmapContextGetData(context);
	if (ptr == nil) {
		CGContextRelease(context);
		return nil;
	}
	
    MCTRGB rgb;
	for (uint32_t x = 0; x < size; ++x) {
        CGFloat val = (CGFloat)x / MCT_RGB_MAX_F;
        switch (hsvIndex) {
            case MCTHSVHue:
                hsv.h = val;
                break;
            case MCTHSVSat:
                hsv.s = val;
                break;
            case MCTHSVVal:
                hsv.v = val;
            default:
                break;
        }
        rgb = MCTRGBFromMCTHSV(hsv);
		
		ptr[0] = (UInt8) (rgb.b * MCT_RGB_MAX_F);
		ptr[1] = (UInt8) (rgb.g * MCT_RGB_MAX_F);
		ptr[2] = (UInt8) (rgb.r * MCT_RGB_MAX_F);
		
		ptr += MCT_BYTE_MULTI;
	}
	
	CGImageRef image = CGBitmapContextCreateImage(context);
	
	CGContextRelease(context);
	
	return image;
}

void MCTColorPickerHueComponentFactors(CGFloat hue, CGFloat *red, CGFloat *green, CGFloat *blue) {
    NSCAssert(red != NULL, @"Red can't be NULL");
    NSCAssert(green != NULL, @"Green can't be NULL");
    NSCAssert(blue != NULL, @"Blue can't be NULL");
    
    CGFloat hueDeg = hue * 360.0;
    
    CGFloat hueValue = hueDeg / 60.0;
    CGFloat val = 1.0 - fabs(fmodf(hueValue, 2.0) - 1.0);
    
    if (hueValue < 1.0) {
        *red = 1.0;
        *green = val;
        *blue = 0.0;
    } else if (hueValue < 2.0) {
        *red = val;
        *green = 1.0;
        *blue = 0.0;
    } else if (hueValue < 3.0) {
        *red = 0.0;
        *green = 1.0;
        *blue = val;
    } else if (hueValue < 4.0) {
        *red = 0.0;
        *green = val;
        *blue = 1.0;
    } else if (hueValue < 5.0) {
        *red = val;
        *green = 0.0;
        *blue = 1.0;
    } else {
        *red = 1.0;
        *green = 0.0;
        *blue = val;
    }
}


MCTRGB MCTRGBFromMCTHSV(MCTHSV hsv) {
    CGFloat r,g,b;
    MCTColorPickerHueComponentFactors(hsv.h, &r, &g, &b);
    
    CGFloat valSat = hsv.v * hsv.s;
    CGFloat valOff = hsv.v - valSat;
    
    MCTRGB rgb;
    
    rgb.r = r * valSat + valOff;
    rgb.g = g * valSat + valOff;
    rgb.b = b * valSat + valOff;
    
    return rgb;
}
MCTHSV MCTHSVFromMCTRGB(MCTRGB rgb) {
    MCTHSV hsv;
    
    CGFloat maximum = MAX(rgb.b, MAX(rgb.r, rgb.g));
    CGFloat minimum = MIN(rgb.b, MIN(rgb.r, rgb.g));
    
    hsv.v = maximum;
    
    CGFloat delta = maximum - minimum;
    
    if (maximum != 0.0) {
        hsv.s = delta / maximum;
    } else {
        hsv.s = 0.0;
    }

    if (hsv.s == 0.0) {
        hsv.h = 0.0;
    } else {
        CGFloat hue = 0.0;
        if (rgb.r == maximum) {
            hue = (rgb.g - rgb.b) / delta;
        } else if (rgb.g == maximum) {
            hue = 2.0 + (rgb.b - rgb.r) / delta;
        } else if (rgb.b == maximum) {
            hue = 4.0 + (rgb.r - rgb.g) / delta;
        }
        
        if (isnan(hue)) {
            hue = 0.0;
        }
        
        hue = hue / 6.0;
        if (hue < 0.0) {
            hue += 1.0;
        }
        hsv.h = hue;
    }
    
    return hsv;
}
UInt8 MCTBlendValue(UInt8 value, UInt8 percent) {
    return (UInt8)((uint32_t)value * percent / MCT_RGB_MAX_F);
}

CGColorRef MCTCreateColorForHSV(MCTHSV hsv) {
    return MCTCreateColorFromRGB(MCTRGBFromMCTHSV(hsv));
}
CGColorRef MCTCreateColorFromRGB(MCTRGB rgb) {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGFloat components[4];
    
    components[0] = rgb.r;
    components[1] = rgb.g;
    components[2] = rgb.b;
    components[3] = 1.0;
    
    CGColorRef color = CGColorCreate(colorSpace, components);
    
    CFRelease(colorSpace);
    
    return color;
}

MCTRGB MCTCreateRGBFromColor(CGColorRef color) {
    CGColorRetain(color);
    
    MCTRGB rgb;
    
    size_t count = CGColorGetNumberOfComponents(color);
    
    if (count == 4) {
        const CGFloat *comp = CGColorGetComponents(color);
        rgb.r = comp[0];
        rgb.g = comp[1];
        rgb.b = comp[2];
    }
    
    
    CGColorRelease(color);
    return rgb;
}
MCTHSV MCTCreateHSVFromColor(CGColorRef color) {
    return MCTHSVFromMCTRGB(MCTCreateRGBFromColor(color));
}
