//
//  AgregarVC.m
//  FastTabla
//
//  Created by Carlos Peralta on 28/9/15.
//  Copyright (c) 2015 Carlos Peralta. All rights reserved.
//

#import "AgregarVC.h"
#import "AppDelegate.h"
#import "Tarea.h"
#import "Tarea+Modelo.h"


@interface AgregarVC ()

@property (assign) float keyboardHeight;

@end

@implementation AgregarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Nueva Tarea";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)agregarTareasBTN_press:(id)sender {
    [Tarea addTaskToBDTaskNNS:self.agregarTF.text descriptionNSS:self.descripcionTF.text];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}


#pragma mark - ManageKeyBoard and the Scrollview ;)

#define KEYBOARD_ADJUST_JUST_PERFECT_TO_SUBTRACT_HEIGHT 32;


-(void)keyboardWillShow:(NSNotification*)notification {
    
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    NSLog(@"height ok keyboard: %f",keyboardFrameBeginRect.size.height);
    _keyboardHeight = keyboardFrameBeginRect.size.height - KEYBOARD_ADJUST_JUST_PERFECT_TO_SUBTRACT_HEIGHT;
    
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if ([sender isEqual:self.agregarTF])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView animateWithDuration: 0.3
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseInOut //UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse
                     animations:^{
                         CGRect rect = self.view.frame;
                         if (movedUp)
                         {
                             // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
                             // 2. increase the size of the view so that the area behind the keyboard is covered up.
                             rect.origin.y -= _keyboardHeight;
                             rect.size.height += _keyboardHeight;
                         }
                         else
                         {
                             // revert back to the normal state.
                             rect.origin.y += _keyboardHeight;
                             rect.size.height -= _keyboardHeight;
                         }
                         self.view.frame = rect;
                         
                     }
                     completion:nil];
}


@end
