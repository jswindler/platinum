//
//  InstaItem.h
//  PlatinumTest
//
//  Created by Joe on 6/14/15.
//  Copyright (c) 2015 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface InstaItem : NSObject

@property(nonatomic, strong) UIImage *thumbnailImage;
@property(nonatomic, copy) NSString *username;
@property(nonatomic, copy) NSNumber *comments;
@property(nonatomic, copy) NSNumber *likes;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
