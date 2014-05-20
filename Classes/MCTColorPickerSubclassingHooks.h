//
//  MCTColorPickerSubclassingHooks.h
//  MCTColorPicker
//
//  Created by Skylar Schipper on 5/20/14.
//  Copyright (c) 2014 Ministry Centered Technology. All rights reserved.
//

#ifndef MCTColorPicker_MCTColorPickerSubclassingHooks_h
#define MCTColorPicker_MCTColorPickerSubclassingHooks_h

#import "MCTColorPickerView.h"
#import "MCTColorPickerBarView.h"

@interface MCTColorPickerView (SubclassingHooks)

- (CGPoint)normalizeSelectedPoint:(CGPoint)point;

@end

@interface MCTColorPickerBarView (SubclassingHooks)

- (CGPoint)normalizeSelectedPoint:(CGPoint)point;

@end

#endif
