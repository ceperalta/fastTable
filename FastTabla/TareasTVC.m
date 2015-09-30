//
//  TareasTVC.m
//  FastTabla
//
//  Created by Carlos Peralta on 28/9/15.
//  Copyright (c) 2015 Carlos Peralta. All rights reserved.
//

#import "TareasTVC.h"
#import "Tarea.h"
#import "Tarea+Modelo.h"
#import "AppDelegate.h"
#import "EditarVC.h"
#import <CoreData/CoreData.h>

#define ROWS_BATCH_REQUEST 20

@interface TareasTVC () <UISearchBarDelegate, NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (assign) BOOL yaIniciadoB;
@property (strong,nonatomic)NSSortDescriptor *nsSortDescriptor;
@end

@implementation TareasTVC

-(void)dealloc{
    NSLog(@"%s",__FUNCTION__);
    self.fetchedResultsController = nil;
}

-(NSFetchedResultsController *)fetchedResultsController{
    NSLog(@"%s",__FUNCTION__);
    if (!_fetchedResultsController) {
        [self updateTasksFromDB];
    }
    
    return _fetchedResultsController;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"%s",__FUNCTION__);
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    self.fetchedResultsController.delegate = nil;
    self.fetchedResultsController = nil;
 
    NSFetchRequest *fetchRequestFiltrado = [Tarea filtrar_texto:searchText];
    
    [fetchRequestFiltrado setSortDescriptors:@[_nsSortDescriptor]];
    [fetchRequestFiltrado setFetchBatchSize:ROWS_BATCH_REQUEST];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequestFiltrado managedObjectContext:app.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController.delegate = self;
    [self.fetchedResultsController performFetch:nil];
    
    
    [self.tableView reloadData];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"%s",__FUNCTION__);
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        UITableViewCell * cell = (UITableViewCell*)sender;
        NSIndexPath *indexPathSelectedCell = [self.tableView indexPathForCell:cell];
        EditarVC *editarVC = (EditarVC*)segue.destinationViewController;
        
        editarVC.tareaAEditar = [self.fetchedResultsController objectAtIndexPath:indexPathSelectedCell];
    }

}
- (IBAction)refreshTable:(id)sender {
    NSLog(@"%s",__FUNCTION__);
    [self updateTasksFromDB];
    self.searchBar.text = @"";
    
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
    
    [self.tableView setContentOffset:CGPointMake(0, -20) animated:YES];
}

- (void)updateTasksFromDB{
    NSLog(@"%s",__FUNCTION__);

    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Tarea" inManagedObjectContext:app.managedObjectContext];
    [fetch setEntity:entity];
    
    _nsSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"texto" ascending:YES];
    
    [fetch setSortDescriptors:@[_nsSortDescriptor]];
    
    [fetch setFetchBatchSize:ROWS_BATCH_REQUEST];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetch managedObjectContext:app.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController.delegate = self;
    
    [self.fetchedResultsController performFetch:nil];
 
}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"%s",__FUNCTION__);
    [self updateTasksFromDB];
    [self.tableView reloadData];
    if(!_yaIniciadoB){
        [self.tableView setContentOffset:CGPointMake(0, 44) animated:NO];
        _yaIniciadoB = true;
    }
}

- (void)viewDidLoad {
    NSLog(@"%s",__FUNCTION__);
    [super viewDidLoad];
    _yaIniciadoB = false;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.searchBar.delegate = self;
}

- (void)didReceiveMemoryWarning {
    NSLog(@"%s",__FUNCTION__);
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configurarCelda:(UITableViewCell*)celda enElIndexPath:(NSIndexPath*)indexPath{
    NSLog(@"%s",__FUNCTION__);
    Tarea *t = (Tarea*)[self.fetchedResultsController objectAtIndexPath:indexPath];
    celda.textLabel.text = t.texto;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"%s",__FUNCTION__);
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%s",__FUNCTION__);
    id  sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    
    NSLog(@"Nro resultados: %d",[sectionInfo numberOfObjects]);
    
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s",__FUNCTION__);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MiCelda" forIndexPath:indexPath];
    [self configurarCelda:cell enElIndexPath:indexPath];
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s",__FUNCTION__);
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s",__FUNCTION__);
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
  
        Tarea *tareaAEliminar = (Tarea*)[self.fetchedResultsController objectAtIndexPath:indexPath];
        //http://stackoverflow.com/questions/16395428/delete-from-uitableview-using-an-nsfetchedresultscontroller
        [self.fetchedResultsController.managedObjectContext deleteObject:tareaAEliminar];
        
        [app.managedObjectContext save:nil];
    }
}


#pragma mark - NSFetchedResultsControllerDelegate
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    NSLog(@"%s",__FUNCTION__);
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    NSLog(@"%s",__FUNCTION__);
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configurarCelda:[tableView cellForRowAtIndexPath:indexPath] enElIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    NSLog(@"%s",__FUNCTION__);
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            break;
            
        case NSFetchedResultsChangeMove:
            break;
            
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    NSLog(@"%s",__FUNCTION__);
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}

@end
