//
//  RESTHttpClient.m
//  FastTabla
//
//  Created by Carlos Peralta on 7/10/15.
//  Copyright © 2015 Carlos Peralta. All rights reserved.
//

#import "RESTHttpClient.h"
#import "Tarea.h"
#import "Tarea+Modelo.h"

static RESTHttpClient *restHttpClientSingleton = nil;

@implementation RESTHttpClient



+(RESTHttpClient*)createRESTHttpClientSingleton{
    NSLog(@"%s",__FUNCTION__);
    if (restHttpClientSingleton == nil) {
        NSLog(@"making the singleton");
        NSString *strBaseURL = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"baseURL"];
        restHttpClientSingleton = [[self alloc] initWithBaseURL:[NSURL URLWithString:strBaseURL]];
    }

    return restHttpClientSingleton;
}

-(void)addTask:(Tarea*)taskToAdd{
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"id"] =  [Tarea getIDStringFromNSManagedObjectTask:taskToAdd];
    parameters[@"task"] = taskToAdd.textoMod3;
    parameters[@"description"] = taskToAdd.descripcionMod;
    
    [self POST:@"rest" parameters:parameters
        success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"new task was sent to the rest server");
        }
        failure:^(NSURLSessionDataTask *task, NSError *error) {}
    ];
}

-(void)deleteTask:(Tarea*)taskToDelete{
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"id"] =  [Tarea getIDStringFromNSManagedObjectTask:taskToDelete];
   
    [self  DELETE:@"rest" parameters:parameters
       success:^(NSURLSessionDataTask *task, id responseObject) {
           NSLog(@"task %@ was deleted",taskToDelete.textoMod3);
       }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
           NSLog(@"task %@ was NOT deleted - Error: %@",taskToDelete.textoMod3,error.description);
       }
     ];
}

-(void)editTask:(Tarea*)taskToEdit{
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"id"] =  [Tarea getIDStringFromNSManagedObjectTask:taskToEdit];
    parameters[@"task"] = taskToEdit.textoMod3;
    parameters[@"description"] = taskToEdit.descripcionMod;
    
    [self PUT:@"rest" parameters:parameters
       success:^(NSURLSessionDataTask *task, id responseObject) {
           NSLog(@"update task was sent to the rest server");
       }
       failure:^(NSURLSessionDataTask *task, NSError *error) {}
     ];
}

@end
