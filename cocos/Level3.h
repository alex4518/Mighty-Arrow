//
//  Level3.h
//  Mighty Sword
//
//  Created by Alexandros Almpanis on 31/07/2013.
//  Copyright (c) 2013 alex. All rights reserved.
//

#import "GameLayer.h"
#import "InputLayer.h"

@interface Level3 : GameLayer

@property(nonatomic,strong) CCTMXLayer *objectsLayer ;

@property(nonatomic,readwrite) CGRect exitRect ;

+(Level3*) Level3Layer;


@end
