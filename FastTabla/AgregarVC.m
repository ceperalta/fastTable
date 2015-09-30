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

@interface AgregarVC ()

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
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    Tarea *tarea = [NSEntityDescription insertNewObjectForEntityForName:@"Tarea" inManagedObjectContext:app.managedObjectContext];
    tarea.texto = self.agregarTF.text;
    [app.managedObjectContext save:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
