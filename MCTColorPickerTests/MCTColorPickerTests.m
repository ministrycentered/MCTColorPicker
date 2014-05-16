//
//  MCTColorPickerTests.m
//  MCTColorPickerTests
//
//  Created by Skylar Schipper on 5/15/14.
//  Copyright (c) 2014 Ministry Centered Technology. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "MCTColorPickerBarLayer.h"

@interface MCTColorPickerTests : XCTestCase

@end

@implementation MCTColorPickerTests

- (void)testBarLayerHSVPointGetter {
    MCTColorPickerBarLayer *layer = [[MCTColorPickerBarLayer alloc] init];
    
    CGRect frame = CGRectMake(0.0, 0.0, 360.0, 60.0);
    
    layer.frame = frame;
    
    CGFloat _acc = 0.0001;
    
    MCTHSV hsv = [layer hsvForPoint:CGPointMake(0.0, 30.0)];
    XCTAssertEqualWithAccuracy(hsv.h, 0.0, _acc);
    XCTAssertEqualWithAccuracy(hsv.s, 1.0, _acc);
    XCTAssertEqualWithAccuracy(hsv.v, 1.0, _acc);
    
    hsv = [layer hsvForPoint:CGPointMake(360.0, 30.0)];
    XCTAssertEqualWithAccuracy(hsv.h, 1.0, _acc);
    XCTAssertEqualWithAccuracy(hsv.s, 1.0, _acc);
    XCTAssertEqualWithAccuracy(hsv.v, 1.0, _acc);
    
    hsv = [layer hsvForPoint:CGPointMake(180.0, 30.0)];
    XCTAssertEqualWithAccuracy(hsv.h, 0.5, _acc);
    XCTAssertEqualWithAccuracy(hsv.s, 1.0, _acc);
    XCTAssertEqualWithAccuracy(hsv.v, 1.0, _acc);
    
    hsv = [layer hsvForPoint:CGPointMake(90.0, 30.0)];
    XCTAssertEqualWithAccuracy(hsv.h, 0.25, _acc);
    XCTAssertEqualWithAccuracy(hsv.s, 1.0, _acc);
    XCTAssertEqualWithAccuracy(hsv.v, 1.0, _acc);
    
    hsv = [layer hsvForPoint:CGPointMake(270.0, 30.0)];
    XCTAssertEqualWithAccuracy(hsv.h, 0.75, _acc);
    XCTAssertEqualWithAccuracy(hsv.s, 1.0, _acc);
    XCTAssertEqualWithAccuracy(hsv.v, 1.0, _acc);
}


@end
