//
//  Level2.h
//  Mighty Sword
//
//  Created by alex on 25/07/2013.
//  Copyright (c) 2013 alex. All rights reserved.
//

#import "GameLayer.h"
#import "InputLayer.h"

@interface Level2 : GameLayer

@property(nonatomic,strong) CCTMXLayer *objectsLayer ;

@property(nonatomic,readwrite) CGRect exitRect ;

+(Level2*) Level2Layer;

@end
