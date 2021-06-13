extends Control


signal finished


## order of showing is the order of the children (so it's easily tweakable)

var current_step = 0 #we skip the first, since that's the shade ^^


enum { INPUT, INPUT_SPECIAL, SELECTED, SELECTED2, MATCHED }


var conditions = [
	INPUT,
	INPUT,
	INPUT,
	INPUT,
	INPUT,
	INPUT,
	INPUT,
	INPUT,
	SELECTED,
	INPUT,
	SELECTED2,
	INPUT,
	INPUT_SPECIAL,
	INPUT,
	INPUT,
	MATCHED,
	INPUT,
	INPUT,
	INPUT,
	INPUT,
	INPUT,
	INPUT,
	INPUT,
	INPUT,
	INPUT,
]

# store the current configuration for demonstration purposes
var _current_configuration:Configuration


func _ready() -> void:
	var index = 0
	for c in get_children():
		
		# skip the shade and the first dialog
		if index > 1:
			c.hide()
			
		index += 1

	set_process_input(false)
	
	# kickstart
	_next_step()
	

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() or event is InputEventMouseButton and event.is_pressed() and not event.is_echo():
		_next_step()
		
		
func _next_step() -> void:
	set_process_input(false)
	$shade.hide()
	
	current_step += 1
	
	# hide the previous
	if (current_step > 1):
		get_child(current_step - 1).hide()
	
	
	if current_step >= conditions.size():
		emit_signal('finished')
		return
	
	if _get_current_condition() == INPUT:
		set_process_input(true)
		_show_step()
	
	
		
	if _get_current_condition() == INPUT_SPECIAL:
		set_process_input(true)
		_show_step_special()
	
	# else we wait for selected and then we will continue the flow


func _show_step() -> void:
	$shade.show()
	get_child(current_step).show()


func _show_step_special() -> void:
	# add some text to the current dialog-text-box
	var current_step_dialog = get_child(current_step)
	current_step_dialog.text += _make_text_from_configuration_differences()
	
			
	_show_step()

func _get_current_condition() -> int:
	return conditions[current_step - 1]


func _make_text_from_configuration_differences() -> String:
	var output = ""
	
	for part in PersonParts.keys():
		if _current_configuration[part] == -1:
			output += "\n 2 different types of " + part
		else:
			output += "\n the same " + part

	return output
		
	
func selected(combined_configuration: Configuration, selected_count: int) -> void:
	if _get_current_condition() != SELECTED and _get_current_condition() != SELECTED2:
		return
	
	if _get_current_condition() == SELECTED and selected_count != 1:
		return
	
	if _get_current_condition() == SELECTED2 and selected_count != 2:
		return
	
	_current_configuration = combined_configuration
	
	set_process_input(true)
	_show_step()
	
func matched() -> void:
	if _get_current_condition() != MATCHED:
		return
	
	set_process_input(true)
	_show_step()
