//
//  Level1.h
//  Mighty Sword
//
//  Created by alex on 20/07/2013.
//  Copyright 2013 alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameLayer.h"
#import "InputLayer.h"

@interface Level1 : GameLayer {
    int count;
}


@property(nonatomic,strong) CCTMXTiledMap *themap;
@property(nonatomic,strong) CCTMXLayer *backgroundLayer ;
@property(nonatomic,strong) CCTMXLayer *objectsLayer ;

@end