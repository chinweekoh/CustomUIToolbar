//
//  ClassCustomUIToolbar.h
//  myMeal
//
//  Created by Chinwee Koh on 29/3/13.
//  Copyright (c) 2013 Chinwee Koh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomUIToolbarDelegate <UIToolbarDelegate>

-(void)dismissKeyboard:(UITextField*)textfield;

@end

@interface ClassCustomUIToolbar : UIToolbar

@property (assign, nonatomic) id <CustomUIToolbarDelegate> delegate;

- (id)initWithView:(UIView*)view target:(id)target;

@end