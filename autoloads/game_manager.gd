## Singleton encargado del flujo global del juego.
##
## Maneja la persistencia de datos (High Score), el control de vidas,
## la puntuación actual y la carga de niveles.
extends Node

const MAIN = preload("res://scenes/ui/main.tscn")     
const END_SCREEN = preload("res://scenes/ui/end_screen.tscn")

const LEVELS = {
	1: preload("res://scenes/levels/level_1.tscn"),
	2: preload("res://scenes/levels/level_2.tscn"),
}

const SAVE_FILE_PATH = "user://savefile.save"
var current_level = 0
var lives = 3
var score = 0
var high_score = 0

func _ready() -> void:
	load_high_score()

## Guarda el puntaje actual en disco si supera el récord histórico.
## Utiliza [FileAccess] para escritura binaria/texto en user://.
func save_high_score():
	if score > high_score:
		high_score = score
		var save_file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
		save_file.store_32(high_score)

## Carga el High Score desde el sistema de archivos local.
func load_high_score():
	if FileAccess.file_exists(SAVE_FILE_PATH):
		var save_file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
		high_score = save_file.get_32()

## Incrementa el puntaje actual y actualiza la UI a través de señales.
## [param points]: Cantidad de puntos a sumar.
func update_score(points):
	score += points

## Gestiona la transición al siguiente nivel o a la pantalla final.
func load_next_level():
	current_level += 1
	
	if current_level > LEVELS.size():
		save_high_score()
		get_tree().change_scene_to_packed.call_deferred(END_SCREEN)
	else:
		get_tree().change_scene_to_packed.call_deferred(LEVELS[current_level])

func restart_level():
	lives -= 1
	if lives <= 0:
		save_high_score()
		get_tree().change_scene_to_packed.call_deferred(END_SCREEN)
		return 
	
	get_tree().change_scene_to_packed(LEVELS[current_level])

func restart_game():
	score = 0
	current_level = 0
	lives = 3
	get_tree().change_scene_to_packed(MAIN)
