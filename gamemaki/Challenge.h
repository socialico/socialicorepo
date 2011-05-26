//
//  Challenge.h
//  GameMaki
//
//  Created by Alexey Titlyanov on 23.05.11.
//  Copyright 2011 Socialico. All rights reserved.
//
#import <Three20/Three20.h>

@interface Challenge : NSObject {
    
    NSNumber* _challengeId;
    NSString* _challengeTitle;
    NSNumber* _placeId;
    NSNumber* _claimNo;
    NSNumber* _commentNo;
    NSNumber* _likeNo;
    NSNumber* _dislikeNo;
    NSDate* _updatedAt;
    NSDate* _createdAt;
    NSString* _repeat;
    NSString* _hide;
    
    NSNumber* _userId;
    NSString* _userName;
    NSString* _photoSmall;
    NSString* _photoLarge;
    
    NSNumber* _categoryId;
    NSString* _categoryIcon;
    NSString* _categoryName;
    
    NSString* _accepted;
    NSString* _claimed;
    NSString* _claimedWithPhoto;
    NSString* _claimPhoto;
    NSNumber* _repeatNo;
}

@property (nonatomic, retain) NSDate* updatedAt;
@property (nonatomic, retain) NSDate* createdAt;

@property (nonatomic, retain) NSNumber* challengeId;
@property (nonatomic, retain) NSNumber* placeId;
@property (nonatomic, retain) NSNumber* claimNo;
@property (nonatomic, retain) NSNumber* commentNo;
@property (nonatomic, retain) NSNumber* likeNo;
@property (nonatomic, retain) NSNumber* dislikeNo;
@property (nonatomic, retain) NSNumber* userId;
@property (nonatomic, retain) NSNumber* categoryId;
@property (nonatomic, retain) NSNumber* repeatNo;

@property (nonatomic, copy)   NSString* challengeTitle;
@property (nonatomic, copy)   NSString* repeat;
@property (nonatomic, copy)   NSString* hide;
@property (nonatomic, copy)   NSString* userName;
@property (nonatomic, copy)   NSString* photoSmall;
@property (nonatomic, copy)   NSString* photoLarge;
@property (nonatomic, copy)   NSString* categoryIcon;
@property (nonatomic, copy)   NSString* categoryName;
@property (nonatomic, copy)   NSString* accepted;
@property (nonatomic, copy)   NSString* claimed;
@property (nonatomic, copy)   NSString* claimedWithPhoto;
@property (nonatomic, copy)   NSString* claimPhoto;

@end

