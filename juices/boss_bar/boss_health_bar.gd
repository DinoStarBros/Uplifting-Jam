extends ProgressBar

var fb_desiredVal : float
func _process(delta: float) -> void:
	fb_desiredVal = %BossHealthBar.value
	%fake_bar.value = lerp(%fake_bar.value, fb_desiredVal, 5 * delta)
	%fake_bar.max_value = %BossHealthBar.max_value
