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

- (void)loadView {
    [super loadView];
    
    self.barView.pickerView = self.pickerView;
    self.pickerView.changeHandler = ^(MCTColorPickerView *view, UIColor *color) {
        self.colorView.backgroundColor = color;
    };
    
    self.pickerView.pointView = [[MCTPointView alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0, 20.0)];
    self.pickerView.pointView.backgroundColor = [UIColor orangeColor];
    
    self.barView.pointView = [[MCTPointView alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0, 20.0)];
    [((MCTPointView *)self.barView.pointView) setFixY:YES];
    self.barView.pointView.backgroundColor = [UIColor orangeColor];
    
    self.pickerView.color = [UIColor redColor];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end

@implementation MCTPointView

- (void)moveToPoint:(CGPoint)point {
    if (self.fixY) {
        point.y = CGRectGetHeight(self.superview.bounds) / 2.0;
    }
    self.center = point;
}

@end
