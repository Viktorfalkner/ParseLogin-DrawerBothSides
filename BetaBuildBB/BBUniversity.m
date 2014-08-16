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
    return [self initWithObjectId:@"" WithName:@"" WithLocaiton:@""];
}

-(instancetype)initFromPFObject:(PFObject *)initDictionary {
    NSString *objectId = initDictionary.objectId;
    NSString *name = initDictionary[@"name"];
    NSString *location = initDictionary[@"location"];
    return [self initWithObjectId:objectId WithName:name WithLocaiton:location];
}

-(instancetype)initWithObjectId:(NSString *)initObjectId WithName:(NSString *)initName WithLocaiton:(NSString *)initLocation {
    self = [super init];
    if (self) {
        _name = initName;
        _location = initLocation;
    }
    return self;
}


@end
