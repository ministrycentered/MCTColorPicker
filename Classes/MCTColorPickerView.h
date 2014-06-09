// MCTColorPickerView.h
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

#ifndef MCTColorPickerView_h
#define MCTColorPickerView_h

@import UIKit;

#import "MCTColorPickerLayer.h"

@class MCTColorPickerView;

typedef void (^MCTColorPickerChangeHandler)(MCTColorPickerView *, UIColor *color);
typedef void (^MCTColorPickerInteractionChangeHandler)(MCTColorPickerView *, BOOL isInteracting);

/**
 *  A UIView that displays a color picker, and responds to user input for picking that color.
 */
@interface MCTColorPickerView : UIView

/**
 *  The color to display.
 */
@property (nonatomic, strong) UIColor *color;

/**
 *  The picker display layer
 */
@property (nonatomic, strong, readonly) MCTColorPickerLayer *pickerLayer;

/**
 *  The currently selected color
 */
@property (nonatomic, strong, readonly) UIColor *selectedColor;

/**
 *  When ever the selected color is changed this block is called if it was set.
 *
 *  There are multiple ways this is called. If you don't want it called when making programatic changes or setup use performSetup:
 *
 *  @see performSetup:
 */
@property (nonatomic, copy) MCTColorPickerChangeHandler changeHandler;

/**
 *  Updates the current color
 *
 *  @param notifyChangeHandler Don't call the change handler
 */
- (void)updateColorsNotifyChangeHandler:(BOOL)notifyChangeHandler;

/**
 *  Setting this will add it as a subview and call MCTColorPickerPointView's moveToPoint: method on user input
 */
@property (nonatomic, strong) UIView<MCTColorPickerPointView> *pointView;

/**
 *  Called when user interaction begins and ends.
 */
@property (nonatomic, copy) MCTColorPickerInteractionChangeHandler inputChangeHandler;

/**
 *  Set the HSV satuation and value levels
 *
 *  @param saturation The color saturation
 *  @param value      The color value
 */
- (void)selectSaturation:(CGFloat)saturation value:(CGFloat)value;

/**
 *  Perform the block without calling the change handlers
 *
 *  @param setup The block to call
 */
- (void)performSetup:(void(^)(MCTColorPickerView *view))setup;

@end

#endif
