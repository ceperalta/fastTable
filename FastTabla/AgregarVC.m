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
    self.title = @"Nueva Tarea";
}

- (IBAction)agregarTareasBTN_press:(id)sender {
    [Tarea addTaskToBDTaskNNS:self.agregarTF.text descriptionNSS:self.descripcionTF.text];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
