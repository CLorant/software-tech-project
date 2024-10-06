extends Node

var config = ConfigFile.new()
const SETTINGS_FILE_PATH = "user://settings.ini"

func _ready() -> void:
	if !FileAccess.file_exists(SETTINGS_FILE_PATH):
		config.set_value("audio", "master_volume", 1.0)
		config.set_value("audio", "sfx_volume", 1.0)
		
		config.set_value("skill", "has_dash", false)
		config.set_value("skill", "has_double_jump", false)
		config.set_value("skill", "has_combo_attack", false)
		
		config.save(SETTINGS_FILE_PATH)
	else:
		config.load(SETTINGS_FILE_PATH)

func save_audio_setting(key: String, value):
	config.set_value("audio", key, value)
	config.save(SETTINGS_FILE_PATH)

func load_audio_settings():
	var audio_settings = {}
	
	for key in config.get_section_keys("audio"):
		audio_settings[key] = config.get_value("audio", key)
		
	return audio_settings

func save_skill_setting(key: String, value):
	config.set_value("skill", key, value)
	config.save(SETTINGS_FILE_PATH)

func load_skill_settings():
	var skill_settings = {}
	
	for key in config.get_section_keys("skill"):
		skill_settings[key] = config.get_value("skill", key)
		
	return skill_settings
