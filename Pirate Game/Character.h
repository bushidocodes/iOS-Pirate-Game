//
//  Character.h
//  Pirate Game
//
//  Created by Sean McBride on 9/2/14.
//  Copyright (c) 2014 Sean McBride. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Weapon.h"
#import "Armor.h"
#import "Tile.h"

@interface Character : NSObject

@property (nonatomic) int healthTotal;
@property (nonatomic) int currentHealth;
@property (strong, nonatomic) Weapon *equippedWeapon;
@property (strong, nonatomic) Armor *equippedArmor;
@property (nonatomic) CGPoint currentLocation;

@end
