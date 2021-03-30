//
//  MediaItem.m
//  demo
//
//  Created by irons on 2021/3/30.
//

#import "MediaItem.h"

@implementation MediaItem

- (instancetype)initWithTitle:(NSString *)title URLString:(NSString *)URLString
{
    if (self = [super init]) {
        self.title = title;
        self.URLString = URLString;
    }
    return self;
}

@end
