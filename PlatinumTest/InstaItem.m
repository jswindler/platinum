//
//  InstaItem.m
//  PlatinumTest
//
//  Created by Joe on 6/14/15.
//  Copyright (c) 2015 Joe. All rights reserved.
//

#import "InstaItem.h"

@implementation InstaItem

- (id)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        NSDictionary *user = [dict objectForKey:@"user"];
        self.username = [user objectForKey:@"username"];

        NSDictionary *comments = [dict objectForKey:@"comments"];
        self.comments = [comments objectForKey:@"count"];

        NSDictionary *images = [dict objectForKey:@"images"];
        NSDictionary *thumbnail = [images objectForKey:@"thumbnail"];
        NSString *url = [thumbnail objectForKey:@"url"];
        NSURL *imageUrl = [NSURL URLWithString:url];
        self.thumbnailImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
        /*  thumbnail =         {
            height = 150;
            url = "https://scontent.cdninstagram.com/hphotos-xaf1/t51.2885-15/s150x150/e15/11325693_415374078669184_1277615091_n.jpg";
            jwidth = 150;
         };*/
        
        NSDictionary *likes = [dict objectForKey:@"likes"];
        self.likes = [likes objectForKey:@"count"];
        
        //NSDictionary *caption = [dict objectForKey:@"caption"];
        //NSDictionary *likes = [dict objectForKey:@"likes"];
        //NSString *created = [dict objectForKey:@"created_time"];
    }
 
    return self;
}

@end
