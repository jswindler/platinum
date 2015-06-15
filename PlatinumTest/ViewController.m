//
//  ViewController.m
//  PlatinumTest
//
//  Created by Joe on 6/14/15.
//  Copyright (c) 2015 Joe. All rights reserved.
//

#import "ViewController.h"
#import "InstaItem.h"

@interface ViewController ()

@property(nonatomic, strong) NSMutableArray *items;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self downloadProductData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)downloadProductData
{
    // Create request
    NSHTTPURLResponse *response = nil;
    NSString *jsonUrlString = [NSString stringWithFormat:@"https://api.instagram.com/v1/media/popular?client_id=f529e29bebcf499388ca00729e996a03"];
    NSURL *url = [NSURL URLWithString:[jsonUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    // Send request
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    // Parse JSON response
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
//    NSLog(@"Response: %@", result);
    
    NSDictionary *data = [result objectForKey:@"data"];
    if (data != nil) {
        for (NSDictionary *dict in data)
        {
            //NSLog(@"Item: %@", dict);
            InstaItem *item = [[InstaItem alloc] initWithDictionary:dict];
            [self.items addObject:item];
        }
    }
}

@end
