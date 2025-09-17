extends Control
class_name ErrorPopup

var txt : String = "This looks horrible."

func _ready() -> void:
	%error_msg.text = txt
