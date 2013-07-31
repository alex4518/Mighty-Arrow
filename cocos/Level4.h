//
//  Level4.h
//  Mighty Sword
//
//  Created by alex on 31/07/2013.
//  Copyright (c) 2013 alex. All rights reserved.
//

#import "GameLayer.h"
#import "InputLayer.h"


@interface Level4 : GameLayer

@property(nonatomic,strong) CCTMXLayer *objectsLayer ;

@property(nonatomic,readwrite) CGRect exitRect ;

+(Level4*) Level4Layer;

@end
