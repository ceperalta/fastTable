//
//  AppDelegate.m
//  FastTabla
//
//  Created by Carlos Peralta on 28/9/15.
//  Copyright (c) 2015 Carlos Peralta. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.gmail.ceperalta.FastTabla" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"FastTabla" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

/*
 
 
 ------------------------------------
 
 
 https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CoreDataVersioning/Articles/vmInitiating.html#//apple_ref/doc/uid/TP40004399-CH7-SW1
 
 The Default Migration Process
 
 To open a store and perform migration (if necessary), you use addPersistentStoreWithType:configuration:URL:options:error: and add to the options dictionary an entry where the key is NSMigratePersistentStoresAutomaticallyOption and the value is an NSNumber object that represents YES. Your code looks similar to the following example:
 
 Listing 6-1  Opening a store using automatic migration
 NSError *error;
 NSPersistentStoreCoordinator *psc = <#The coordinator#>;
 NSURL *storeURL = <#The URL of a persistent store#>;
 NSDictionary *optionsDictionary =
 [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES]
 forKey:NSMigratePersistentStoresAutomaticallyOption];
 
 NSPersistentStore *store = [psc addPersistentStoreWithType:<#Store type#>
 configuration:<#Configuration or nil#>
 URL:storeURL
 options:optionsDictionary
 error:&error];
 If the migration proceeds successfully, the existing store at storeURL is renamed with a “~” suffix before any file extension and the migrated store saved to storeURL.
 
 In its implementation of addPersistentStoreWithType:configuration:URL:options:error: Core Data does the following:
 
 Tries to find a managed object model that it can use to open the store.
 Core Data searches through your application’s resources for models and tests each in turn. If it cannot find a suitable model, Core Data returns nil and a suitable error.
 
 Tries to find a mapping model that maps from the managed object model for the existing store to that in use by the persistent store coordinator.
 Core Data searches through your application’s resources for available mapping models and tests each in turn. If it cannot find a suitable mapping, Core Data returns NO and a suitable error.
 
 Note that you must have created a suitable mapping model in order for this phase to succeed.
 
 Creates instances of the migration policy objects required by the mapping model.
 Note that even if you use the default migration process you can customize the migration itself using custom migration policy classes.
 
 
 Lightweight Migration Core Data in Swift - Xcode 6 iOS 8 Tutorial:
 https://www.youtube.com/watch?v=HXDdYtKtwEc
 
 
 +
 
 NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption:@YES,
 NSInferMappingModelAutomaticallyOption:@YES};
 
 NSString *failureReason = @"There was an error creating or loading the application's saved data.";
 if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
 
 
 ----------------------------------------------------
 
 */

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"FastTabla.sqlite"];
    NSError *error = nil;
    
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption:@YES,
                              NSInferMappingModelAutomaticallyOption:@YES};
    
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
