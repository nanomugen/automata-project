extends Node2D

const FILE_PATH: String = "user://data_system.json"

var DATA_OBJECT: Dictionary = {
	"test_value" : 0,
	"test_value 2": 0,
	"version": 0.1,
	"debug_mode": false,
	"tutorial_mode": true,
	"show_tutorial": true,
	"player_abillities":{
		"dash":true,
		"double_jump":false,
		"wall_jump":false
	},
	"phases":{
		"phase_01":{
			"name":"Fase 01",
			"path": "res://scenes/phases/phase_01.tscn",
			"unlocked":true,
			"completed":false,
			"secret_completed":false
		},
		"phase_02":{
			"name":"Fase 02",
			"path":null,
			"unlocked":false,
			"completed":false,
			"secret_completed":false
		},
	}
}


func _ready() -> void:
	_load()

func _save() -> void:
	var file:FileAccess = FileAccess.open(FILE_PATH,FileAccess.WRITE)
	file.store_var(DATA_OBJECT)
	file.close()
	
func _load() -> void:
	if FileAccess.file_exists(FILE_PATH):
		var file: FileAccess = FileAccess.open(FILE_PATH,FileAccess.READ)
		var data:Dictionary = file.get_var()
		for i in data:
			if DATA_OBJECT.has(i):
				DATA_OBJECT[i] = data[i]
		file.close()
