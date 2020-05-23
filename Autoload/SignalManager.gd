extends Node

#player
signal weapon_changed()
signal ability_changed()

#scenes
signal scene_changed()
signal scene_loaded()

#enemies
signal player_found()
signal player_lost()
signal attack_player()
signal dead()

#boss
signal take_damage()