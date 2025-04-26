//
// © 2024-present https://github.com/cengiz-pz
//

#import "load_ad_request.h"

#import "gap_converter.h"

const String AD_UNIT_ID_PROPERTY = "ad_unit_id";
const String REQUEST_AGENT_PROPERTY = "request_agent";
const String AD_SIZE_PROPERTY = "ad_size";
const String AD_POSITION_PROPERTY = "ad_position";
const String KEYWORDS_PROPERTY = "keywords";
const String USER_ID_PROPERTY = "user_id";
const String CUSTOM_DATA_PROPERTY = "custom_data";


@implementation LoadAdRequest

- (instancetype) initWithDictionary:(Dictionary) adData {
	if ((self = [super init])) {
		self.adUnitId = [GAPConverter toNsString:(String) adData[AD_UNIT_ID_PROPERTY]];
		self.requestAgent = [GAPConverter toNsString:(String) adData[REQUEST_AGENT_PROPERTY]];
		if (adData.has(AD_SIZE_PROPERTY)) {
			self.adSize = [GAPConverter toNsString:(String) adData[AD_SIZE_PROPERTY]];
		}
		if (adData.has(AD_POSITION_PROPERTY)) {
			self.adPosition = [GAPConverter toNsString:(String) adData[AD_POSITION_PROPERTY]];
		}
		if (adData.has(KEYWORDS_PROPERTY)) {
			self.keywords = [GAPConverter toNsStringArray: adData[KEYWORDS_PROPERTY]];
		}
		if (adData.has(USER_ID_PROPERTY)) {
			self.userId = [GAPConverter toNsString:(String) adData[USER_ID_PROPERTY]];
		}
		if (adData.has(CUSTOM_DATA_PROPERTY)) {
			self.customData = [GAPConverter toNsString:(String) adData[CUSTOM_DATA_PROPERTY]];
		}
	}
	return self;
}

@end
