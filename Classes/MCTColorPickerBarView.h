// MCTColorPickerBarView.h
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

#ifndef MCTColorPickerBarView_h
#define MCTColorPickerBarView_h

@import UIKit;

#import "MCTColorPickerBarLayer.h"

@class MCTColorPickerBarView;
@class MCTColorPickerView;

typedef void (^MCTColorPickerBarChangeHandler)(MCTColorPickerBarView *, UIColor *color);
typedef void (^MCTColorPickerBarInteractionChangeHandler)(MCTColorPickerBarView *, BOOL isInteracting);

@interface MCTColorPickerBarView : UIView

@property (nonatomic, weak) MCTColorPickerView *pickerView;

@property (nonatomic, strong, readonly) MCTColorPickerBarLayer *barLayer;

@property (nonatomic, copy) MCTColorPickerBarChangeHandler changeHandler;

@property (nonatomic, strong) UIView<MCTColorPickerPointView> *pointView;

- (void)setHue:(CGFloat)hue;

@property (nonatomic, copy) MCTColorPickerBarInteractionChangeHandler inputChangeHandler;

@end

#endif
