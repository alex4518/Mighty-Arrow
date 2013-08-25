//
//  HUDLayer.h
//  Mighty Sword
//
//  Created by Panos Albanis on 14/07/2013.
//  Copyright (c) 2013 alex. All rights reserved.
//


@interface HUDLayer : CCLayer {
    
    CCLabelTTF * _statusLabel;
    CCLabelTTF * _label;
    CCSprite* healthBar;
    CCProgressTimer* progressTimer;
}

 - (void)setStatusString:(NSString *)string;

@end
