class_name GameManager
extends Node2D

@onready var wave_manager = %WaveManager

@export var options : Options
@export var survivedWaves : SurvivedWaves
@export var enemyCountText : Label

var startingEnemyCount = 10
var currentEnemyCount
var gameEnded = false

func _ready():
	currentEnemyCount = startingEnemyCount
	UpdateEnemyCount()

func _process(_delta):
	if !gameEnded:
		if Input.is_action_just_pressed("GameOptions"):
			if !get_tree().paused:
				options.ToggleMenu(true)
				get_tree().paused = true
			else:
				get_tree().paused = false
				options.ToggleMenu(false)

func DecrementEnemyCount():
	currentEnemyCount -= 1
	UpdateEnemyCount()
	wave_manager.CheckCurrentWave()

func IncrementEnemyCount():
	currentEnemyCount = startingEnemyCount + (wave_manager.currentWave - 1)
	UpdateEnemyCount()

func GameOver():
	survivedWaves.ShowSurvivedWaves()
	gameEnded = true
	get_tree().paused = true

func UpdateEnemyCount():
	enemyCountText.text = "Undead: " + str(currentEnemyCount)
