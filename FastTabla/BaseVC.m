//
//  BaseVC.m
//  FastTabla
//
//  Created by Carlos Peralta on 8/10/15.
//  Copyright © 2015 Carlos Peralta. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()

@property (assign) float keyboardHeight;

@end

@implementation BaseVC


- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%s",__FUNCTION__);
    [super viewWillAppear:animated];
   
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
    NSLog(@"%s",__FUNCTION__);
    [super viewWillDisappear:animated];
   
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
    NSLog(@"%s",__FUNCTION__);
    
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    NSLog(@"height ok keyboard: %f",keyboardFrameBeginRect.size.height);
    _keyboardHeight = keyboardFrameBeginRect.size.height - KEYBOARD_ADJUST_JUST_PERFECT_TO_SUBTRACT_HEIGHT;
    
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
    NSLog(@"%s",__FUNCTION__);
    
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}



-(void)setViewMovedUp:(BOOL)movedUp
{
    NSLog(@"%s",__FUNCTION__);
    [UIView animateWithDuration: 0.3
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         CGRect rect = self.view.frame;
                         if (movedUp)
                         {
                             rect.origin.y -= _keyboardHeight;
                             rect.size.height += _keyboardHeight;
                         }
                         else
                         {
                             rect.origin.y += _keyboardHeight;
                             rect.size.height -= _keyboardHeight;
                         }
                         self.view.frame = rect;
                         
                     }
                     completion:nil];
    
}


@end
