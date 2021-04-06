//
//  ViewController.m
//  demo
//
//  Created by irons on 2021/3/26.
//

#import "ViewController.h"
#import "MediaViewController.h"
#import "PlayerViewController.h"
#import "MediaItem.h"
#import "MediaCell.h"
#import <IRHTTPCache/IRHTTPCache.h>

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray<MediaItem *> *items;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self setupHTTPCache];
    });
    [self setupItems];
}

- (void)setupHTTPCache
{
    [IRHTTPCache logSetConsoleLogEnable:YES];
    NSError *error = nil;
    [IRHTTPCache proxyStart:&error];
    if (error) {
        NSLog(@"Proxy Start Failure, %@", error);
    } else {
        NSLog(@"Proxy Start Success");
    }
    [IRHTTPCache encodeSetURLConverter:^NSURL *(NSURL *URL) {
        NSLog(@"URL Filter reviced URL : %@", URL);
        return URL;
    }];
    [IRHTTPCache downloadSetUnacceptableContentTypeDisposer:^BOOL(NSURL *URL, NSString *contentType) {
        NSLog(@"Unsupport Content-Type Filter reviced URL : %@, %@", URL, contentType);
        return NO;
    }];
}

- (void)setupItems
{
    MediaItem *item1 = [[MediaItem alloc] initWithTitle:@"Demo1 - AVPlayer"
                                              URLString:@"http://aliuwmp3.changba.com/userdata/video/45F6BD5E445E4C029C33DC5901307461.mp4"];
    MediaItem *item2 = [[MediaItem alloc] initWithTitle:@"Demo2 - AVPlayer"
                                              URLString:@"http://aliuwmp3.changba.com/userdata/video/3B1DDE764577E0529C33DC5901307461.mp4"];
    MediaItem *item3 = [[MediaItem alloc] initWithTitle:@"Demo3 - AVPlayer"
                                              URLString:@"http://qiniuuwmp3.changba.com/941946870.mp4"];
    MediaItem *item4 = [[MediaItem alloc] initWithTitle:@"Demo4 - AVPlayer"
                                              URLString:@"http://lzaiuw.changba.com/userdata/video/940071102.mp4"];
    MediaItem *item5 = [[MediaItem alloc] initWithTitle:@"Demo1 - IRPlayer"
                                              URLString:@"http://aliuwmp3.changba.com/userdata/video/45F6BD5E445E4C029C33DC5901307461.mp4"];
    MediaItem *item6 = [[MediaItem alloc] initWithTitle:@"Demo2 - IRPlayer"
                                              URLString:@"http://aliuwmp3.changba.com/userdata/video/3B1DDE764577E0529C33DC5901307461.mp4"];
    MediaItem *item7 = [[MediaItem alloc] initWithTitle:@"Demo3 - IRPlayer"
                                              URLString:@"http://qiniuuwmp3.changba.com/941946870.mp4"];
    MediaItem *item8 = [[MediaItem alloc] initWithTitle:@"Demo4 - IRPlayer"
                                              URLString:@"http://lzaiuw.changba.com/userdata/video/940071102.mp4"];
    self.items = @[item1, item2, item3, item4, item5, item6, item7, item8];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MediaItem *item = [self.items objectAtIndex:indexPath.row];
    MediaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MediaCell"];
    [cell configureWithTitle:item.title];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MediaItem *item = [self.items objectAtIndex:indexPath.row];
    NSString *URLString = [item.URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *URL = [IRHTTPCache proxyURLWithOriginalURL:[NSURL URLWithString:URLString]];
    UIViewController *vc = nil;
    if (indexPath.row < 4) {
        vc = [[MediaViewController alloc] initWithURLString:URL.absoluteString];
    } else {
        vc = [[PlayerViewController alloc] initWithURLString:URL.absoluteString];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        ((PlayerViewController *)vc).demoType = DemoType_FFmpeg_Normal_Hardware;
    }
    [self presentViewController:vc animated:YES completion:nil];
}


@end

