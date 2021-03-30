//
//  CacheItemView.h
//  demo
//
//  Created by irons on 2021/3/30.
//

#import <UIKit/UIKit.h>

@class CacheItemView;

NS_ASSUME_NONNULL_BEGIN

@protocol  CacheItemViewDelegate <NSObject>

- (void)cacheItemView:(CacheItemView *)view deleteButtonDidClick:(NSString *)URLString;

@end

@interface CacheItemView : UIView

- (instancetype)initWithURLString:(NSString *)URLString totalLength:(long long)totalLength cacheLength:(long long)cacheLength;

@property (nonatomic, weak) id<CacheItemViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
