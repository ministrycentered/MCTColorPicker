/*!
*  ColorPickerHelperTests.m
*  MCTColorPicker
*
*  Created by Skylar Schipper on 5/15/14.
*    Copyright (c) 2014 Ministry Centered Technology. All rights reserved.
*/

#import <XCTest/XCTest.h>
#import "MCTColorPickerHelpers.h"

@interface ColorPickerHelperTests : XCTestCase

@end

@implementation ColorPickerHelperTests

- (void)testRGBtoHSV {
    CGFloat _acc = 0.00001;
    
    // Black
    MCTRGB rgb = (MCTRGB){0.0,0.0,0.0};
    MCTHSV color = MCTHSVFromMCTRGB(rgb);
    XCTAssertEqualWithAccuracy(color.h, 0.0, _acc, @"Expected hue to be 0.0 got %f",color.h);
    XCTAssertEqualWithAccuracy(color.s, 0.0, _acc, @"Expected sat to be 0.0 got %f",color.s);
    XCTAssertEqualWithAccuracy(color.v, 0.0, _acc, @"Expected val to be 0.0 got %f",color.v);
    
    // White
    rgb = (MCTRGB){1.0,1.0,1.0};
    color = MCTHSVFromMCTRGB(rgb);
    XCTAssertEqualWithAccuracy(color.h, 0.0, _acc, @"Expected hue to be 0.0 got %f",color.h);
    XCTAssertEqualWithAccuracy(color.s, 0.0, _acc, @"Expected sat to be 0.0 got %f",color.s);
    XCTAssertEqualWithAccuracy(color.v, 1.0, _acc, @"Expected val to be 1.0 got %f",color.v);
    
    // Red
    rgb = (MCTRGB){1.0,0.0,0.0};
    color = MCTHSVFromMCTRGB(rgb);
    XCTAssertEqualWithAccuracy(color.h, 0.0, _acc, @"Expected hue to be 0.0 got %f",color.h);
    XCTAssertEqualWithAccuracy(color.s, 1.0, _acc, @"Expected sat to be 1.0 got %f",color.s);
    XCTAssertEqualWithAccuracy(color.v, 1.0, _acc, @"Expected val to be 1.0 got %f",color.v);
    
    // Green
    rgb = (MCTRGB){0.0,1.0,0.0};
    color = MCTHSVFromMCTRGB(rgb);
    XCTAssertEqualWithAccuracy(color.h, 0.33333, _acc, @"Expected hue to be 0.33 got %f",color.h);
    XCTAssertEqualWithAccuracy(color.s, 1.0, _acc, @"Expected sat to be 1.0 got %f",color.s);
    XCTAssertEqualWithAccuracy(color.v, 1.0, _acc, @"Expected val to be 1.0 got %f",color.v);
    
    // Blue
    rgb = (MCTRGB){0.0,0.0,1.0};
    color = MCTHSVFromMCTRGB(rgb);
    XCTAssertEqualWithAccuracy(color.h, .666666667, _acc, @"Expected hue to be ..666666667 got %f",color.h);
    XCTAssertEqualWithAccuracy(color.s, 1.0, _acc, @"Expected sat to be 1.0 got %f",color.s);
    XCTAssertEqualWithAccuracy(color.v, 1.0, _acc, @"Expected val to be 1.0 got %f",color.v);
}

- (void)testHSVtoRGB {
    CGFloat _acc = 0.005;
    MCTHSV hsv;
    MCTRGB rgb;
    
    // Red
    hsv = (MCTHSV){0.0,1.0,1.0};
    rgb = MCTRGBFromMCTHSV(hsv);
    XCTAssertEqualWithAccuracy(rgb.r, 1.0, _acc, @"Expected red to be 1.0 got %f",rgb.r);
    XCTAssertEqualWithAccuracy(rgb.g, 0.0, _acc, @"Expected grn to be 0.0 got %f",rgb.g);
    XCTAssertEqualWithAccuracy(rgb.b, 0.0, _acc, @"Expected blu to be 0.0 got %f",rgb.b);
    
    // Random
    hsv = (MCTHSV){0.555555556,0.75,0.50};
    rgb = MCTRGBFromMCTHSV(hsv);
    XCTAssertEqualWithAccuracy(rgb.r, 0.121568627, _acc, @"Expected red to be .121568627 got %f",rgb.r);
    XCTAssertEqualWithAccuracy(rgb.g, 0.37254902, _acc,  @"Expected grn to be .37254902 got %f",rgb.g);
    XCTAssertEqualWithAccuracy(rgb.b, 0.498039216, _acc, @"Expected blu to be .498039216 got %f",rgb.b);
    
    // Black
    hsv = (MCTHSV){0.0,0.0,0.0};
    rgb = MCTRGBFromMCTHSV(hsv);
    XCTAssertEqualWithAccuracy(rgb.r, 0.0, _acc, @"Expected red to be .0 got %f",rgb.r);
    XCTAssertEqualWithAccuracy(rgb.g, 0.0, _acc, @"Expected grn to be .0 got %f",rgb.g);
    XCTAssertEqualWithAccuracy(rgb.b, 0.0, _acc, @"Expected blu to be .0 got %f",rgb.b);
    
    // White
    hsv = (MCTHSV){0.0,0.0,1.0};
    rgb = MCTRGBFromMCTHSV(hsv);
    XCTAssertEqualWithAccuracy(rgb.r, 1.0, _acc, @"Expected red to be 1.0 got %f",rgb.r);
    XCTAssertEqualWithAccuracy(rgb.g, 1.0, _acc, @"Expected grn to be 1.0 got %f",rgb.g);
    XCTAssertEqualWithAccuracy(rgb.b, 1.0, _acc, @"Expected blu to be 1.0 got %f",rgb.b);
    
    // Green
    hsv = (MCTHSV){0.33333,1.0,1.0};
    rgb = MCTRGBFromMCTHSV(hsv);
    XCTAssertEqualWithAccuracy(rgb.r, 0.0, _acc, @"Expected red to be 0.0 got %f",rgb.r);
    XCTAssertEqualWithAccuracy(rgb.g, 1.0, _acc, @"Expected grn to be 1.0 got %f",rgb.g);
    XCTAssertEqualWithAccuracy(rgb.b, 0.0, _acc, @"Expected blu to be 0.0 got %f",rgb.b);
    
    // Blue
    hsv = (MCTHSV){0.666666667,1.0,1.0};
    rgb = MCTRGBFromMCTHSV(hsv);
    XCTAssertEqualWithAccuracy(rgb.r, 0.0, _acc, @"Expected red to be 0.0 got %f",rgb.r);
    XCTAssertEqualWithAccuracy(rgb.g, 0.0, _acc, @"Expected grn to be 0.0 got %f",rgb.g);
    XCTAssertEqualWithAccuracy(rgb.b, 1.0, _acc, @"Expected blu to be 1.0 got %f",rgb.b);
}

@end
