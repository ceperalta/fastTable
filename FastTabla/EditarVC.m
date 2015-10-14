//
//  EditarVC.m
//  FastTabla
//
//  Created by Carlos Peralta on 28/9/15.
//  Copyright (c) 2015 Carlos Peralta. All rights reserved.
//

#import "EditarVC.h"
#import "AppDelegate.h"
#import "Tarea+Modelo.h"

#define EDIT NSLocalizedStringFromTable(@"EDIT", @"EditarVC", @"edit button in editarVC")

@interface EditarVC ()


@property (weak, nonatomic) IBOutlet UITextField *descriptionTF;

@end

@implementation EditarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = EDIT; // @"Editar"
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)editButton_press:(id)sender {
    [Tarea editTaskOnDB:self.tareaAEditar taskTitle:self.editarTF.text taskDescription:self.descriptionTF.text];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.editarTF.text = self.tareaAEditar.textoMod3;
    self.descriptionTF.text = self.tareaAEditar.descripcionMod;
}




@end
