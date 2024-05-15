class_name WaveManager
extends Node2D

@onready var point_one = $SpawnPoints/PointOne
@onready var point_two = $SpawnPoints/PointTwo
@onready var point_three = $SpawnPoints/PointThree
@onready var point_four = $SpawnPoints/PointFour

@onready var wave_completed_sound = $WaveCompletedSound
@onready var game_manager = %GameManager
@onready var timer = $Timer

@export var currentWaveText : Label

@export var startingWaitTime : float
@export var minimumWaitTime : float
@export var decrementTimeBy : float

var ghost = preload("res://Scenes/Enemies/ghost.tscn")
var zombie = preload("res://Scenes/Enemies/zombie.tscn")
var skeleton = preload("res://Scenes/Enemies/skeleton.tscn")

var currentWave : int = 0

func _ready():
	UpdateWave()
	timer.wait_time = startingWaitTime
	timer.start()

func _on_timer_timeout():
	SpawnEnemy()

func SpawnEnemy():
	var spawn_rng = randi_range(0, 2)
	var position_rng = randi_range(0, 3)
	
	var point = position_rng
	
	match spawn_rng:
		0:
			var g = ghost.instantiate()
			g.game_manager = game_manager
			g.wave_manager = self
			g.SetSpeed()
			match point:
				0:
					g.position = point_one.position
					g.isFacingRight = true
				1:
					g.position = point_two.position
					g.isFacingDown = true
				2:
					g.position = point_three.position
					g.isFacingLeft = true
				3:
					g.position = point_four.position
					g.isFacingUp = true

			add_child(g)
		1:
			var z = zombie.instantiate()
			z.game_manager = game_manager
			z.wave_manager = self
			z.SetSpeed()
			match point:
				0:
					z.position = point_one.position
					z.isFacingRight = true
				1:
					z.position = point_two.position
					z.isFacingDown = true
				2:
					z.position = point_three.position
					z.isFacingLeft = true
				3:
					z.position = point_four.position
					z.isFacingUp = true

			add_child(z)
		2:
			var s = skeleton.instantiate()
			s.game_manager = game_manager
			s.wave_manager = self
			s.SetSpeed()
			match point:
				0:
					s.position = point_one.position
					s.isFacingRight = true
				1:
					s.position = point_two.position
					s.isFacingDown = true
				2:
					s.position = point_three.position
					s.isFacingLeft = true
				3:
					s.position = point_four.position
					s.isFacingUp = true

			add_child(s)

func CheckCurrentWave():
	if game_manager.currentEnemyCount <= 0:
		UpdateWave()
		DecrementTimer()
		PlayWaveCompletedSound()
		game_manager.IncrementEnemyCount()

func UpdateWave():
	currentWave += 1
	currentWaveText.text = "Wave: " + str(currentWave)

func DecrementTimer():
	if(timer.wait_time > minimumWaitTime):
		timer.wait_time -= decrementTimeBy

func PlayWaveCompletedSound():
	wave_completed_sound.play()
