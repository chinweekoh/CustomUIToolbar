//
//  ClassCustomUIToolbar.m
//  myMeal
//
//  Created by Chinwee Koh on 29/3/13.
//  Copyright (c) 2013 Chinwee Koh. All rights reserved.
//

#import "ClassCustomUIToolbar.h"

#define SCREENHEIGHT    (int)[[UIScreen mainScreen] bounds].size.height
#define SCREENWIDTH     (int)[[UIScreen mainScreen] bounds].size.width
#define KEYBOARDHEIGHT  216
#define TOOLBARHEIGHT   44

@interface ClassCustomUIToolbar ()

@property (strong, nonatomic) UIView *view;
@property (strong, nonatomic) UITextField *currentTextfield;

@end

@implementation ClassCustomUIToolbar


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

- (id)initWithView:(UIView*)inputview target:(id)target
{
    self = [super init];
    if (self) {
        _view = inputview;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissKeyBoard)];
        UIBarButtonItem *leftArrow = [[UIBarButtonItem alloc] initWithTitle:@"prev" style:UIBarButtonItemStyleBordered target:self action:@selector(prevTextField)];
        UIBarButtonItem *rightArrow = [[UIBarButtonItem alloc] initWithTitle:@"next" style:UIBarButtonItemStyleBordered target:self action:@selector(nextTextField)];
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        [self setFrame:CGRectMake(0, SCREENHEIGHT, SCREENHEIGHT, TOOLBARHEIGHT)];
        [self setBarStyle:UIBarStyleBlackTranslucent];
        [self setItems:[NSArray arrayWithObjects:leftArrow, rightArrow, flexibleSpace, done, nil]];
        
        [_view addSubview:self];
    }
    return self;
}

#pragma clang diagnostic pop

-(void)setCurrentTextField
{
    for (UIView *view in _view.subviews) {
        if (view.isFirstResponder) {
            _currentTextfield = (UITextField*)view;
        }
    }
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    int OFFSET = 0;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7)
        OFFSET = 20;
        
    [UIView animateWithDuration: 0.25 animations: ^ {
        [self setFrame:CGRectMake(0, SCREENHEIGHT-(KEYBOARDHEIGHT+TOOLBARHEIGHT)-OFFSET, SCREENWIDTH, TOOLBARHEIGHT)
         ];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration: 0.25 animations: ^ {
        [self setFrame:CGRectMake(0,SCREENHEIGHT, SCREENWIDTH, TOOLBARHEIGHT)
         ];
    }];
}

-(void)prevTextField
{
    [self setCurrentTextField];
    
    NSInteger prevTag = [_currentTextfield tag] - 1;
    
    UITextField *textField = _currentTextfield;

    UIResponder* prevResponder = [textField.superview viewWithTag:prevTag];
    
    if (prevResponder) {
        [prevResponder becomeFirstResponder];
    }
}

-(void)nextTextField
{
    [self setCurrentTextField];
    
    NSInteger nextTag = [_currentTextfield tag] + 1;
    
    UITextField *textField = _currentTextfield;
    
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    
    if (nextResponder) {
        [nextResponder becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
}

#pragma mark - CustomUIToolbarDelegate

-(void)dismissKeyBoard
{
    [self setCurrentTextField];
    
    [[self delegate] dismissKeyboard:_currentTextfield];
}

@end
