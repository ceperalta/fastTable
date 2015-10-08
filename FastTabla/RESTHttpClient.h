//
//  RESTHttpClient.h
//  FastTabla
//
//  Created by Carlos Peralta on 7/10/15.
//  Copyright © 2015 Carlos Peralta. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "Tarea.h"

@class Tarea;

@interface RESTHttpClient : AFHTTPSessionManager

+(RESTHttpClient*)createRESTHttpClientSingleton;
-(void)addTask:(Tarea*)taskToAdd;
-(void)deleteTask:(Tarea*)taskToDelete;
-(void)editTask:(Tarea*)taskToEdit;

@end
