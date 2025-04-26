#
# © 2024-present https://github.com/cengiz-pz
#

class_name AdapterStatus extends RefCounted

const LATENCY_PROPERTY: String = "latency"
const INITIALIZATION_STATE_PROPERTY: String = "initializationState"
const DESCRIPTION_PROPERTY: String = "description"

var _data: Dictionary


func _init(a_data: Dictionary):
	_data = a_data


func get_latency() -> int:
	return _data[LATENCY_PROPERTY]


func get_initialization_state() -> int:
	return _data[INITIALIZATION_STATE_PROPERTY]


func get_description() -> int:
	return _data[DESCRIPTION_PROPERTY]
