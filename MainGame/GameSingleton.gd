extends Node


onready var miniManager

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func SetManager(var thing) : 
	miniManager = thing

func LoseGame():
	miniManager.LoseGame()
	
func WinGame():
	miniManager.WinGame()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
