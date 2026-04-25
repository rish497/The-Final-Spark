extends TextEdit

var real_text: String = ""
var mask_char: String = "●"

func _ready():
	# Connect the signal via code if not already done in the editor
	text_changed.connect(_on_text_changed)

func _on_text_changed():
	var current_display = text
	
	# Simple logic for appending characters (handles basic typing)
	if current_display.length() > real_text.length():
		var new_char = current_display.right(1) 
		real_text += new_char
	elif current_display.length() < real_text.length():
		real_text = real_text.left(current_display.length())
	
	# Block signals to prevent infinite loops while updating the display
	set_block_signals(true)
	text = mask_char.repeat(real_text.length())
	set_caret_column(text.length()) # Keep caret at the end
	set_block_signals(false)
