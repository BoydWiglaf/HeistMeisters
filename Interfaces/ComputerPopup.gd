extends Popup

func set_text(combination):
	$NinePatchRect/CenterContainer/NinePatchRect/Display.text = (
		"The new door code is: " + PoolStringArray(combination).join("")
	)
