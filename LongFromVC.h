//
//  LongFromVC.h
//  FastTabla
//
//  Created by Carlos Peralta on 30/9/15.
//  Copyright (c) 2015 Carlos Peralta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"

@interface LongFromVC : BaseVC
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (assign) float keyboardHeight;
@property (weak, nonatomic) IBOutlet UITextField *textField1;

@end
