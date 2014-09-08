//
//  Enemy.h
//  Pirate Game
//
//  Created by Sean McBride on 9/2/14.
//  Copyright (c) 2014 Sean McBride. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Enemy : NSObject

@property (strong, nonatomic) NSString *name;
@property (nonatomic) int healthTotal;
@property (nonatomic) int currentHealth;
@property (nonatomic) int damageValue;
@property (nonatomic) int cooldownTime;
@property (nonatomic) CGPoint currentLocation;
@property (nonatomic, strong) UIImage *enemyImage;

@end
