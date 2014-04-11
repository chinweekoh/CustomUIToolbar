//
//  ViewController.m
//  CustomToolBar
//
//  Created by Chinwee Koh on 10/4/14.
//  Copyright (c) 2014 Chinwee Koh. All rights reserved.
//

#import "ViewController.h"

#import "ClassCustomUIToolbar.h"

@interface ViewController () <CustomUIToolbarDelegate>
@property (weak, nonatomic) IBOutlet UITextField *keyboard;
@property (weak, nonatomic) IBOutlet UITextField *keypad;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [_keyboard setTag:1];
    [_keypad setTag:2];
    
    UIToolbar *toolbar = [[ClassCustomUIToolbar alloc] initWithView:[self view] target:self];
    [toolbar setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard:(UITextField *)textfield
{
    [textfield resignFirstResponder];
}

@end
