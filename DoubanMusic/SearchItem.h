
#import <Foundation/Foundation.h>

@interface SearchItem : NSObject
@property (nonatomic,copy) NSString *gid;
@property (nonatomic,copy) NSString *name;

@end

@interface SearchTagItem : NSObject
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *size;

@end
