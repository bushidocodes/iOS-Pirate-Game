//
//  Tile.h
//  Pirate Game
//
//  Created by Sean McBride on 9/2/14.
//  Copyright (c) 2014 Sean McBride. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weapon.h"
#import "Armor.h"

@interface Tile : NSObject

@property (strong, nonatomic) NSString *textDescription;
@property (nonatomic, strong) UIImage *backgroundImage;




@end
