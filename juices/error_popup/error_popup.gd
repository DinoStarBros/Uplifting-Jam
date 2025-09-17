extends Control
class_name ErrorPopup

var possible_txt : Array[String] = [
	"This drawing looks horrible.",
	"You'll never make it as an artist, give up now.",
	"This is all just a waste of time.",
	"You're talentless, worthless, and incompetent.",
	"Others can do way better than this.",
	"Why even try?",
	"What's the point?",
	"Everyhting you create is garbage",
	"You're falling behind.",
	"You're not a real artist.",
	"It's not perfect, it's worthless"
]
var txt_idx : int

func _ready() -> void:
	txt_idx = randi_range(0, possible_txt.size()-1)
	%error_msg.text = str(possible_txt[txt_idx])
