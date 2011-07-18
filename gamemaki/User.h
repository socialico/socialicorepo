//
//  User.h
//  gamemaki
//
//  Created by Socialico on 7/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * secretKey;
@property (nonatomic, retain) NSString * facebookId;

@end
