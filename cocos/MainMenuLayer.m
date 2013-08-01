//
//  MainMenuLayer.m
//  Mighty Sword
//
//  Created by alex on 19/07/2013.
//  Copyright (c) 2013 alex. All rights reserved.
//

#import "MainMenuLayer.h"
#import "GameLayer.h"
#import "Level1.h"
#import "SoundMenu.h"

@implementation MainMenuLayer

+(id) scene
{
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    CCScene *scene = [CCScene node];
    
    MainMenuLayer *layer = [MainMenuLayer node];
    
    [scene addChild: layer];
    
    CCLabelTTF *title = [CCLabelTTF labelWithString:@"Game Title" fontName:@"Courier" fontSize:64];
    title.position =  ccp(winSize.width/2, 260);
    [scene addChild: title];
    
    CCLayer *menuLayer = [[CCLayer alloc] init];
    [scene addChild:menuLayer];
    
    CCMenuItemImage *newGameButton = [CCMenuItemImage
                                    itemWithNormalImage:@"new-game.png"
                                    selectedImage:@"new-game-selected.png"
                                    target:layer
                                    selector:@selector(startGame:)];
    
    CCMenuItemImage *loadGameButton = [CCMenuItemImage
                                    itemWithNormalImage:@"load-game.png"
                                    selectedImage:@"load-game-selected.png"
                                    target:layer
                                    selector:@selector(startGame:)];
    
    CCMenuItemImage *controlsButton = [CCMenuItemImage
                                       itemWithNormalImage:@"controls.png"
                                       selectedImage:@"controls-selected.png"
                                       target:layer
                                       selector:@selector(startGame:)];
    
    CCMenuItemImage *settingsButton = [CCMenuItemImage
                                       itemWithNormalImage:@"settings.png"
                                       selectedImage:@"settings-selected.png"
                                       target:layer
                                       selector:@selector(setttings:)];
    
    CCMenuItemImage *aboutButton = [CCMenuItemImage
                                       itemWithNormalImage:@"about.png"
                                       selectedImage:@"about-selected.png"
                                       target:layer
                                       selector:@selector(startGame:)];
    
    CCMenu *menu = [CCMenu menuWithItems: newGameButton, loadGameButton, controlsButton, settingsButton, aboutButton,  nil];
    [menuLayer addChild: menu];
    
    menu.position = ccp(winSize.width/2 + 150, 120);
    [menu alignItemsVerticallyWithPadding:5];
    
    return scene;
}

- (void) startGame: (id) sender
{
    [[CCDirector sharedDirector] replaceScene:[Level1 scene]];
}

- (void) setttings: (id) sender
{
    [[CCDirector sharedDirector] replaceScene:[SoundMenu scene]];
}

-(id) init
{
    
    if( (self=[super initWithColor:ccc4(0, 0, 0, 0)])) {
        
    }
    return self;
}

@end
