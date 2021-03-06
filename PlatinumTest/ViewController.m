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
    
    self.items = [NSMutableArray array];
    [self downloadProductData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)downloadProductData
{
    NSString *jsonUrlString = [NSString stringWithFormat:@"https://api.instagram.com/v1/media/popular?client_id=f529e29bebcf499388ca00729e996a03"];
    NSURL *url = [NSURL URLWithString:[jsonUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
  // show a visual loading indicator
  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
  
  // Send request
  [[[NSURLSession sharedSession] dataTaskWithURL:url
                               completionHandler:^(NSData *data,
                                                   NSURLResponse *response,
                                                   NSError *error) {
                                 //NSLog(@"Response: %@", response);
                                 // Parse JSON response
                                 if (error == nil) {
                                   NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                   
                                   NSDictionary *data = [result objectForKey:@"data"];
                                   if (data != nil) {
                                     for (NSDictionary *dict in data)
                                     {
                                       //NSLog(@"Item: %@", dict);
                                       InstaItem *item = [[InstaItem alloc] initWithDictionary:dict];
                                       [self.items addObject:item];
                                     }
                                   }
                                   
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                     [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                     [self.tableView reloadData];
                                   });
                                 }
                                 else {
                                   //TODO: Handle error case
                                 }
                               }] resume];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell != nil) {
        InstaItem *item = [self.items objectAtIndex:indexPath.row];
        if (item != nil) {
            cell.imageView.image = item.thumbnailImage;
            cell.textLabel.text = item.username;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"Likes: %@, Comments: %@",
                                         [item.likes stringValue], [item.comments stringValue]];
        }
    }
    return cell;
}

#pragma mark - UITableViewDelegate

// TODO...

@end
