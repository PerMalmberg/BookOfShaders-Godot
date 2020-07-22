tool
extends TextureRect


func _input(event):
	if event is InputEventMouseMotion:
		var m : InputEventMouseMotion = event
		material.set_shader_param("mouse", m.position)
