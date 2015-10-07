//
//  Tarea+Modelo.h
//  FastTabla
//
//  Created by Carlos Peralta on 29/9/15.
//  Copyright (c) 2015 Carlos Peralta. All rights reserved.
//

#import "Tarea.h"

@interface Tarea (Modelo)

+(NSFetchRequest*)filtrar_texto:(NSString*)textoAFiltrar;
+(void)addTaskToBDTaskNNS:(NSString*)taskNNS descriptionNSS:(NSString*)descriptionNSS;
+(Tarea*)getTaskFromDBTask:(Tarea*)task;

@end
