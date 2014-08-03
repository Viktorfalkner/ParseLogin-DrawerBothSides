//
//  BBMeetupLocationDataStore.m
//  BetaBuildBB
//
//  Created by Viktor Falkner on 7/26/14.
//
//

#import "BBMeetupLocationDataStore.h"
#import "User.h"
#import "Course.h"
#import "MeetUp.h"

@implementation BBMeetupLocationDataStore
//Synthesize managedObjectContext 
@synthesize managedObjectContext = _managedObjectContext;

+ (instancetype)sharedDataStore {
    static BBMeetupLocationDataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[BBMeetupLocationDataStore alloc]init];
    });
    
    return _sharedDataStore;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _meetUpsArray = [[NSMutableArray alloc]init];
        _leftDrawerArray = [[NSMutableArray alloc]init];
        _rightDrawerArray = [[NSMutableArray alloc]init];
        _allMeetingsArray = [[NSMutableArray alloc]init];
    }
    return self;
}

#pragma mark - Core Data stack

//Don't forget to synthesize managedObjectContext fam
- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"BetaBuildBB.sqlite"];
    
    NSError *error = nil;
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"userModel" withExtension:@"momd"];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}


#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(void)fetchAllMeetUpsFromParse
{
    PFQuery *queryMeetings = [PFQuery queryWithClassName:@"BBMeetup"];
    self.allMeetingsArray = [NSMutableArray new];
    self.leftDrawerArray = [NSMutableArray new];
    self.rightDrawerArray = [NSMutableArray new];
    
    [queryMeetings findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            for (PFObject *meetUpParseObject in objects)
            {
                //Add all meetups to fetched array
                MeetUp *tempMeetUp = [MeetUp makePFObjectintoMeetup:meetUpParseObject withManagedObjectContext:self.managedObjectContext];
                           [self.allMeetingsArray addObject:tempMeetUp];
                
                if ([[[PFUser currentUser] objectId] isEqualToString:tempMeetUp.userId])
                {
                    [self.leftDrawerArray addObject:tempMeetUp];
                }
       
            }
            self.rightDrawerArray = self.allMeetingsArray;
            
        }
        else
        {
            NSLog(@"Parse error in datastore: %@", error.localizedDescription);
        }
    }];
}

#pragma mark - Make managed objects

-(User *)makeUserObject
{
    return [User userWithContext:self.managedObjectContext];
}

-(Course *)makeCourseObject
{
    return [Course courseWithContext:self.managedObjectContext];
}

-(MeetUp *)makeMeetUpObject
{
    return [MeetUp meetUpWithContext:self.managedObjectContext]; 
}

@end
