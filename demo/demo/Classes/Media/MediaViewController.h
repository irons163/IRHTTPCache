//
//  MediaViewController.h
//  demo
//
//  Created by irons on 2021/3/30.
//

#import <AVKit/AVKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MediaViewController : AVPlayerViewController

- (instancetype)initWithURLString:(NSString *)URLString;

@end

NS_ASSUME_NONNULL_END
