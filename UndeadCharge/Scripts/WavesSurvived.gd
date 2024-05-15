class_name SurvivedWaves
extends Control

@onready var wave_manager = %WaveManager
@export var wavesText : Label

func ShowSurvivedWaves():
	show()
	wavesText.text = "Waves survived: " + str(wave_manager.currentWave)
