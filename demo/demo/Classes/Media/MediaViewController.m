//
//  MediaViewController.m
//  demo
//
//  Created by irons on 2021/3/30.
//

#import "MediaViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface MediaViewController ()

@property (nonatomic, strong) NSString *URLString;

@end

@implementation MediaViewController

- (instancetype)initWithURLString:(NSString *)URLString
{
    if (self = [super init]) {
        self.URLString = URLString;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.player = [AVPlayer playerWithURL:[NSURL URLWithString:self.URLString]];
    [self.player play];
}

- (void)dealloc
{
    [self.player.currentItem.asset cancelLoading];
    [self.player.currentItem cancelPendingSeeks];
    [self.player cancelPendingPrerolls];
}

@end
