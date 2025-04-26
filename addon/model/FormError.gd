#
# © 2024-present https://github.com/cengiz-pz
#

class_name FormError extends RefCounted

const CODE_PROPERTY: String = "code"
const MESSAGE_PROPERTY: String = "message"

var _data: Dictionary


func _init(a_data: Dictionary):
	_data = a_data


func get_code() -> int:
	return _data[CODE_PROPERTY]


func get_message() -> String:
	return _data[MESSAGE_PROPERTY]
