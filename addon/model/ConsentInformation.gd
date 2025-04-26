#
# © 2024-present https://github.com/cengiz-pz
#

class_name ConsentInformation extends RefCounted

enum ConsentStatus {
	UNKNOWN = 0,
	REQUIRED = 1,
	NOT_REQUIRED = 2,
	OBTAINED = 3
}
