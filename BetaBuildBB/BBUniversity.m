//
//  BBUniversity.m
//  BetaBuildBB
//
//  Created by Troy Barrett on 8/15/14.
//
//

#import "BBUniversity.h"

@implementation BBUniversity

- (instancetype)init
{
    return [self initWithName:@"" WithLocaiton:@""];
}

-(instancetype)initFromDictionary:(NSDictionary *)initDictionary {
    NSString *name = initDictionary[@"name"];
    NSString *location = initDictionary[@"location"];
    return [self initWithName:name WithLocaiton:location];
}

-(instancetype)initWithName:(NSString *)initName WithLocaiton:(NSString *)initLocation {
    self = [super init];
    if (self) {
        _name = initName;
        _location = initLocation;
    }
    return self;
}


@end
