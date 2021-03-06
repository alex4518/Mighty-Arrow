//
//  MainMenuLayer.m
//  Mighty Sword
//
//  Created by Alexandros Almpanis on 19/07/2013.
//  Copyright (c) 2013 alex. All rights reserved.
//

#import "MainMenuLayer.h"
#import "GameLayer.h"
#import "Level1.h"
#import "EndSceneLayer.h"
#import "ControlsLayer.h"
#import "AboutLayer.h"
#import "SoundMenu.h"
#import "SimpleAudioEngine.h"

@implementation MainMenuLayer

+(id) scene
{
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    CCScene *scene = [CCScene node];
    
    MainMenuLayer *layer = [MainMenuLayer node];
    
    [scene addChild: layer];
    
    CCLabelTTF *title = [CCLabelTTF labelWithString:@"Mighty Arrow" fontName:@"Courier" fontSize:64];
    title.position =  ccp(winSize.width/2, 260);
    [scene addChild: title];
    
    CCLayer *menuLayer = [[CCLayer alloc] init];
    [scene addChild:menuLayer];
    
    CCSprite* menuImage = [CCSprite spriteWithFile:@"menu-image.png"];
    
    menuImage.position = ccp(winSize.width/4 + 50,120);
    [scene addChild:menuImage];
    
    
    CCMenuItemImage *newGameButton = [CCMenuItemImage
                                    itemWithNormalImage:@"new-game.png"
                                    selectedImage:@"new-game-selected.png"
                                    target:layer
                                    selector:@selector(startGame:)];
    
    
    CCMenuItemImage *controlsButton = [CCMenuItemImage
                                       itemWithNormalImage:@"controls.png"
                                       selectedImage:@"controls-selected.png"
                                       target:layer
                                       selector:@selector(controls:)];
    
    CCMenuItemImage *settingsButton = [CCMenuItemImage
                                       itemWithNormalImage:@"settings.png"
                                       selectedImage:@"settings-selected.png"
                                       target:layer
                                       selector:@selector(setttings:)];
    
    CCMenuItemImage *aboutButton = [CCMenuItemImage
                                       itemWithNormalImage:@"about.png"
                                       selectedImage:@"about-selected.png"
                                       target:layer
                                       selector:@selector(about:)];
    
    CCMenu *menu = [CCMenu menuWithItems: newGameButton, controlsButton, settingsButton, aboutButton,  nil];
    [menuLayer addChild: menu];
    
    menu.position = ccp(winSize.width/2 + 150, 120);
    [menu alignItemsVerticallyWithPadding:5];
    
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Celestial_Aeon_Project_-_Suspicion.mp3"];
    
    return scene;
}

- (void) startGame: (id) sender
{
    [[CCDirector sharedDirector] replaceScene:[Level1 scene]];
}

- (void) controls: (id) sender
{
    [[CCDirector sharedDirector] replaceScene:[ControlsLayer scene]];
}

- (void) setttings: (id) sender
{
    [[CCDirector sharedDirector] replaceScene:[SoundMenu scene]];
}

- (void) about: (id) sender
{
    [[CCDirector sharedDirector] replaceScene:[AboutLayer scene]];
}

-(id) init
{
    
    if( (self=[super initWithColor:ccc4(0, 0, 0, 0)])) {
        
    }
    return self;
}

@end
