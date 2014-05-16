//
//  MCTViewController.m
//  MCTColorPicker
//
//  Created by Skylar Schipper on 5/15/14.
//  Copyright (c) 2014 Ministry Centered Technology. All rights reserved.
//

#import "MCTViewController.h"

@interface MCTViewController ()

@end

@implementation MCTViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.pickerView.color = [UIColor redColor];
    
    self.barView.changeHandler = ^(MCTColorPickerBarView *view, UIColor *color) {
        self.pickerView.color = color;
    };
    self.pickerView.changeHandler = ^(MCTColorPickerView *view, UIColor *color) {
        self.colorView.backgroundColor = color;
    };
    
    [self.pickerView updateColors];
}

@end
