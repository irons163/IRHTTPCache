//
//  CacheViewController.m
//  demo
//
//  Created by irons on 2021/3/30.
//

#import "CacheViewController.h"
#import <IRHTTPCache/IRHTTPCache.h>
#import "CacheItemZoneCell.h"
#import "CacheItemView.h"

@interface CacheViewController () <UITableViewDelegate, UITableViewDataSource, CacheItemViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray<IRHCDataCacheItem *> *items;

@end

@implementation CacheViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupItems];
}

- (void)setupItems
{
    self.items = [IRHTTPCache cacheAllCacheItems];
    [self.tableView reloadData];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    IRHCDataCacheItem *item = [self.items objectAtIndex:section];
    return item.zones.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IRHCDataCacheItem *item = [self.items objectAtIndex:indexPath.section];
    IRHCDataCacheItemZone *zone = [item.zones objectAtIndex:indexPath.row];
    CacheItemZoneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CacheItemZoneCell"];
    [cell configureWithOffset:zone.offset length:zone.length];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    IRHCDataCacheItem *item = [self.items objectAtIndex:section];
    CacheItemView *view = [[CacheItemView alloc] initWithURLString:item.URL.absoluteString totalLength:item.totalLength cacheLength:item.cacheLength];
    view.delegate = self;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 120;
}

#pragma mark - CacheItemViewDelegate

- (void)cacheItemView:(CacheItemView *)view deleteButtonDidClick:(NSString *)URLString
{
    [IRHTTPCache cacheDeleteCacheWithURL:[NSURL URLWithString:URLString]];
    [self setupItems];
}

- (IBAction)deleteAllCache:(UIButton *)sender
{
    [IRHTTPCache cacheDeleteAllCaches];
    [self setupItems];
}

@end

