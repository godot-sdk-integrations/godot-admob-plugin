//
// © 2024-present https://github.com/cengiz-pz
//

#import "admob_config.h"

#import "gap_converter.h"


const String IS_REAL_PROPERTY = "is_real";
const String MAX_AD_CONTENT_RATING_PROPERTY = "max_ad_content_rating";
const String CHILD_DIRECTED_TREATMENT_PROPERTY = "tag_for_child_directed_treatment";
const String UNDER_AGE_OF_CONSENT_PROPERTY = "tag_for_under_age_of_consent";
const String FIRST_PARTY_ID_ENABLED_PROPERTY = "first_party_id_enabled";
const String PERSONALIZATION_STATE_PROPERTY = "personalization_state";
const String TEST_DEVICE_IDS_PROPERTY = "test_device_ids";


@implementation AdmobConfig

- (instancetype) initWithDictionary:(Dictionary) configData {
	if ((self = [super init])) {
		self.isReal = configData[IS_REAL_PROPERTY];
		self.maxContentRating = [GAPConverter toNsString:(String) configData[MAX_AD_CONTENT_RATING_PROPERTY]];
		self.childDirectedTreatment = [NSNumber numberWithInt: configData[CHILD_DIRECTED_TREATMENT_PROPERTY]];
		self.underAgeOfConsent = [NSNumber numberWithInt: configData[UNDER_AGE_OF_CONSENT_PROPERTY]];
		self.firstPartyIdEnabled = configData[FIRST_PARTY_ID_ENABLED_PROPERTY];
		self.personalizationState = [NSNumber numberWithInt: configData[PERSONALIZATION_STATE_PROPERTY]];
		
		self.testDeviceIds = [GAPConverter toNsStringArray:(Array) configData[TEST_DEVICE_IDS_PROPERTY]];
	}
	return self;
}

@end
