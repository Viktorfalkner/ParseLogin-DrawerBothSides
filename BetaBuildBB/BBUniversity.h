//
//  BBUniversity.h
//  BetaBuildBB
//
//  Created by Troy Barrett on 8/15/14.
//
//

#import <Foundation/Foundation.h>

@interface BBUniversity : NSObject

@property (strong, nonatomic) NSString *objectId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *location;

-(instancetype)initWithName:(NSString *)initName WithLocaiton:(NSString *)initLocation;
-(instancetype)initFromDictionary:(NSDictionary *)initDictionary;

@end
