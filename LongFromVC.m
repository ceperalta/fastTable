//
//  LongFromVC.m
//  FastTabla
//
//  Created by Carlos Peralta on 30/9/15.
//  Copyright (c) 2015 Carlos Peralta. All rights reserved.
//

#import "LongFromVC.h"

@interface LongFromVC ()

@property (assign) CGSize originalViewSize;

@end


@implementation LongFromVC


-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.scrollView layoutIfNeeded];
    
    self.scrollView.contentSize = self.view.frame.size;
    _originalViewSize = self.view.frame.size;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - ManageKeyBoard and the Scrollview ;)

// http://stackoverflow.com/questions/13161666/how-do-i-scroll-the-uiscrollview-when-the-keyboard-appears

-(void)keyboardWillShow:(NSNotification*)notification {
    
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, self.textField1.frame.origin.y-kbSize.height) animated:YES];

}

-(void)keyboardWillHide {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}



@end
