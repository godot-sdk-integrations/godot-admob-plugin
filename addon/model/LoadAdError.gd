#
# © 2024-present https://github.com/cengiz-pz
#

class_name LoadAdError extends AdError

const RESPONSE_INFO_PROPERTY: String = "response_info"


func _init(a_data: Dictionary):
	super(a_data)


func get_response_info() -> String:
	return _data[RESPONSE_INFO_PROPERTY]
