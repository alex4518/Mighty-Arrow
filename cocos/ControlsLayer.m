//
//  ControlsLayer.m
//  Mighty_Arrow
//
//  Created by alex on 26/08/2013.
//  Copyright (c) 2013 alex. All rights reserved.
//

#import "ControlsLayer.h"
#import "MainMenuLayer.h"

@implementation ControlsLayer

+(id) scene{
    
    CCScene *scene=[CCScene node];
    
    ControlsLayer* layer = [ControlsLayer node];
    
    [scene addChild:layer];
    
    return scene;
}

-(id)init {
    
    if( (self=[super init] )) {

    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    NSString* controls = [NSString stringWithFormat:@"%@\r%@\r%@\r%@",@"Use the joystick on the lower", @"left corner of the screen to move",@" the character and the button on the",@" lower right corner to launch arrows"];
    
    CCLabelTTF* label = [CCLabelTTF labelWithString:controls fontName:@"Courier New" fontSize:24];
    label.position = ccp(winSize.width/2, winSize.height/2);
    
    [self addChild:label];
    
    
    CCMenuItem* back = [CCMenuItemFont itemWithString:@"Back"target:self selector:@selector(back:)];
    
    CCMenu *menu = [CCMenu menuWithItems:back, nil];
    menu.position = ccp(winSize.width-50,20);
    [self addChild: menu];
    
    }
    
    return self;
    
}

- (void) back : (id) sender {
    
    [[CCDirector sharedDirector] replaceScene:[MainMenuLayer scene]];
}

@end
