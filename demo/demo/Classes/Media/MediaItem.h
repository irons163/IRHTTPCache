//
//  MediaItem.h
//  demo
//
//  Created by irons on 2021/3/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MediaItem : NSObject

- (instancetype)initWithTitle:(NSString *)title URLString:(NSString *)URLString;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *URLString;

@end

NS_ASSUME_NONNULL_END
