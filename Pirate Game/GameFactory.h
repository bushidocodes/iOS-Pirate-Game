//
//  GameFactory.h
//  Pirate Game
//
//  Created by Sean McBride on 9/2/14.
//  Copyright (c) 2014 Sean McBride. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tile.h"
#import "Character.h"
#import "Enemy.h"

@interface GameFactory : NSObject

+ (NSMutableArray *) generateGameBoard;
+ (CGPoint) randomLocationOnGameboard:(NSMutableArray *) gameBoard;
+ (Character *) generateCharacter;
+ (Enemy *) generateEnemy;
+ (Weapon *) generateWeapon;
+ (Armor *) generateArmor;


@end
