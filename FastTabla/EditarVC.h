//
//  EditarVC.h
//  FastTabla
//
//  Created by Carlos Peralta on 28/9/15.
//  Copyright (c) 2015 Carlos Peralta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tarea.h"

@interface EditarVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *editarTF;
@property (strong, nonatomic) Tarea *tareaAEditar;

@end
