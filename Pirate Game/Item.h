//
//  Item.h
//  Pirate Game
//
//  Created by Sean McBride on 9/3/14.
//  Copyright (c) 2014 Sean McBride. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Item : NSObject

@property (strong, nonatomic) NSString *name;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic) CGPoint currentLocation;

@end
