# this script will hold the overall game state

extends Node

signal victory

var Screens = {
	MAIN_MENU = 'res://screens/main_menu.tscn',
	GAME = 'res://game/game.tscn',
	GAME_OVER = 'res://gui/GameOverScreen.tscn',
}


enum GameState {
	SPLASH,
	MAIN_MENU,
	GAME,
	PAUSED,
	GAME_OVER
}

const BASE_LEVELS_PATH = 'res://game/'
var current_level = -1
var levels = ['tutorial/tutorial', 'game']

var _current_state: int = GameState.SPLASH setget _set_current_state
var _previous_state: int


func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	
	
func start_game():
	transition_to(GameState.GAME)	
	
	
func goto_next_level():
	current_level += 1
	
	if current_level < levels.size():
		# TODO: some kind of screen transition / animation
		SceneLoader.goto_scene(BASE_LEVELS_PATH + levels[current_level] + '.tscn')
	else:
		emit_signal('victory')
		
		# HACKKKK
		current_level -= 1
		
		_restart()
	
	
func game_over():
	transition_to(GameState.GAME_OVER)
	

# change the state to the next
func transition_to(new_state: int) -> void:
	match new_state:
		GameState.MAIN_MENU:
			_current_state = new_state
			SceneLoader.goto_scene(Screens.MAIN_MENU)
		
		GameState.GAME:
			if _current_state in {GameState.MAIN_MENU: true, GameState.SPLASH: true, GameState.GAME: true, GameState.GAME_OVER: true}:
				_current_state = new_state
				goto_next_level()
		
		GameState.GAME_OVER:
			if _current_state in {GameState.GAME: true}:
				_current_state = new_state
				SceneLoader.goto_scene(Screens.GAME_OVER)


# pause handler
func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed('restart'):
			_restart()
			
		elif event.is_action_pressed('pause'):
			match _current_state:
				GameState.GAME:
					transition_to(GameState.PAUSED)
			
				GameState.PAUSED:
					transition_to(GameState.GAME)


func _set_current_state(new_state:int) -> void:
	_previous_state = _current_state
	_current_state = new_state


func _restart() -> void:
	#hack so we restart the current level ^^
	current_level = clamp(current_level - 1, -1, levels.size())
			
	transition_to(GameState.GAME)
