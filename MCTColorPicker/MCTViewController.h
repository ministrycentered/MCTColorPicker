//
//  MCTViewController.h
//  MCTColorPicker
//
//  Created by Skylar Schipper on 5/15/14.
//  Copyright (c) 2014 Ministry Centered Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MCTColorPickerView.h"
#import "MCTColorPickerBarView.h"

@interface MCTViewController : UIViewController

@property (nonatomic, weak) IBOutlet MCTColorPickerView *pickerView;
@property (nonatomic, weak) IBOutlet MCTColorPickerBarView *barView;

@property (nonatomic, weak) IBOutlet UIView *colorView;

@end
