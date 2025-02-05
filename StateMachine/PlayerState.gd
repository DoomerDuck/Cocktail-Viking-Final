extends Node

class_name PlayerState

var player

func enter_state(player_node):
	player = player_node
	
func exit_state():
	pass
	
func handle_input(_delta):
	pass
