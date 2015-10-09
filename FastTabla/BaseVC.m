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
@property (assign) CGRect rectOriginalView;

@end

@implementation BaseVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.rectOriginalView = self.view.frame;
}

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

-(void)keyboardWillShow:(NSNotification*)notification {
    NSLog(@"%s",__FUNCTION__);
    
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    _keyboardHeight = keyboardFrameBeginRect.size.height;
    
    [self setViewMovedUp:YES];
}

-(void)keyboardWillHide {
    NSLog(@"%s",__FUNCTION__);

    [self setViewMovedUp:NO];
}

-(void)setViewMovedUp:(BOOL)movedUp
{
    float deltaScaleWithoutKeyboard = (_rectOriginalView.size.height - _keyboardHeight)/_rectOriginalView.size.height;
    
    if (movedUp)
    {
        CGAffineTransform move = CGAffineTransformMakeTranslation(0, -(_keyboardHeight*deltaScaleWithoutKeyboard));
        CGAffineTransform scale = CGAffineTransformMakeScale(1, deltaScaleWithoutKeyboard);
        CGAffineTransform moveAndScaleAT = CGAffineTransformConcat(move, scale);
        
        self.view.transform = moveAndScaleAT;
        
        for (UIView *subView in [self.view subviews]) {
            subView.transform = CGAffineTransformInvert(scale);
        }
    }
    else
    {
        CGAffineTransform move = CGAffineTransformMakeTranslation(0, 0);
        CGAffineTransform scale = CGAffineTransformMakeScale(1, 1);
        self.view.transform = CGAffineTransformConcat(move, scale);
        for (UIView *subView in [self.view subviews]) {
            subView.transform = CGAffineTransformIdentity;
        }
        
    }
}


@end
