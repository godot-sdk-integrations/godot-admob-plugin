//
// © 2024-present https://github.com/cengiz-pz
//

#ifndef admob_config_h
#define admob_config_h

#import <Foundation/Foundation.h>

#include "core/object/class_db.h"


extern const String IS_REAL_PROPERTY;
extern const String MAX_AD_CONTENT_RATING_PROPERTY;
extern const String CHILD_DIRECTED_TREATMENT_PROPERTY;
extern const String UNDER_AGE_OF_CONSENT_PROPERTY;
extern const String FIRST_PARTY_ID_ENABLED_PROPERTY;
extern const String PERSONALIZATION_STATE_PROPERTY;
extern const String TEST_DEVICE_IDS_PROPERTY;


@interface AdmobConfig : NSObject

@property (nonatomic) BOOL isReal;
@property (nonatomic, strong) NSString* maxContentRating;
@property (nonatomic, strong) NSNumber* childDirectedTreatment;
@property (nonatomic, strong) NSNumber* underAgeOfConsent;
@property (nonatomic) BOOL firstPartyIdEnabled;
@property (nonatomic, strong) NSNumber* personalizationState;
@property (nonatomic, strong) NSArray* testDeviceIds;

- (instancetype) initWithDictionary:(Dictionary) configData;

@end

#endif /* admob_config_h */
