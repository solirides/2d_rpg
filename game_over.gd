extends Control


@export var player:Node = null

func _on_revive_button_pressed() -> void:
	player.revive()

func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://world.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
