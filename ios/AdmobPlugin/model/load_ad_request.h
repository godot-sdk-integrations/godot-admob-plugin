//
// © 2024-present https://github.com/cengiz-pz
//

#ifndef load_ad_request_h
#define load_ad_request_h

#import <Foundation/Foundation.h>

#include "core/object/class_db.h"


extern const String AD_UNIT_ID_PROPERTY;
extern const String REQUEST_AGENT_PROPERTY;
extern const String AD_SIZE_PROPERTY;
extern const String AD_POSITION_PROPERTY;
extern const String KEYWORDS_PROPERTY;
extern const String USER_ID_PROPERTY;
extern const String CUSTOM_DATA_PROPERTY;


@interface LoadAdRequest : NSObject

@property (nonatomic, strong) NSString* adUnitId;
@property (nonatomic, strong) NSString* requestAgent;
@property (nonatomic, strong) NSString* adSize;
@property (nonatomic, strong) NSString* adPosition;
@property (nonatomic, strong) NSArray* keywords;
@property (nonatomic, strong) NSString* userId;
@property (nonatomic, strong) NSString* customData;

- (instancetype) initWithDictionary:(Dictionary) adData;

@end

#endif /* load_ad_request_h */
