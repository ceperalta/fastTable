//
//  EditarVC.m
//  FastTabla
//
//  Created by Carlos Peralta on 28/9/15.
//  Copyright (c) 2015 Carlos Peralta. All rights reserved.
//

#import "EditarVC.h"
#import "AppDelegate.h"


@interface EditarVC ()

@end

@implementation EditarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Editar";
}


-(void)viewWillAppear:(BOOL)animated{
    self.editarTF.text = self.tareaAEditar.texto;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)editButton_press:(id)sender {
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Tarea" inManagedObjectContext:app.managedObjectContext];
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    [fetch setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self == %@",self.tareaAEditar];
    [fetch setPredicate:predicate];
   
    Tarea *tareaAEditarAux = (Tarea*)[[app.managedObjectContext executeFetchRequest:fetch error:nil] objectAtIndex:0];
    tareaAEditarAux.texto = self.editarTF.text;
    
    [app.managedObjectContext save:nil];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
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
