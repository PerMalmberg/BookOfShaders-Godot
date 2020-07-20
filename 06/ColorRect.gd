tool
extends ColorRect

func _ready():
	material.set_shader_param("dimension", get_viewport().get_visible_rect().size);
	

func _input(event):
	if event is InputEventMouseMotion:
		material.set_shader_param("mouse", event.position)
