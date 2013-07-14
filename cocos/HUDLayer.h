//
//  HUDLayer.h
//  Mighty Sword
//
//  Created by Panos Albanis on 14/07/2013.
//  Copyright (c) 2013 alex. All rights reserved.
//

#import "cocos2d.h"

@interface HUDLayer : CCLayer {
    
    CCLabelTTF * _statusLabel;

}

 - (void)setStatusString:(NSString *)string;

@end
