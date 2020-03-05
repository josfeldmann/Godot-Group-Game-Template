extends Node2D


onready var HealthBar = $TimerLoadingBar
onready var HPFlash = $FlashHP
onready var HPFlashText = $FlashHP/HPText
onready var Prompt = $Prompt
onready var gameSpot = $AttachGameHere
onready var timeInBetweenPrompts: float = 3
onready var timeForTransition : float = 3
onready var currentTimer: float = 0;
onready var currentTimeLimit :  float  = 0
onready var hp: int = 20;



onready var currentPromptString;
onready var currentScenePath
onready var currentGameNode
onready var gameList  =  []


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



enum GameState { PROMPT,MINIGAME,TRANSITION }

var state = GameState.TRANSITION


# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	GameSingleton.SetManager(self)
	gameList = [ ["Press 1 prompt","res://ExampleGame1/ExampleScene1.tscn"] ]
	GetNewGame()
	
	
	
	pass # Replace with function body.
	


func GetNewGame():
	
	
	currentPromptString = gameList[0][0]
	currentScenePath = gameList[0][1]
	HPFlash.hide()
	Prompt.show()
	Prompt.text = currentPromptString
	state = GameState.PROMPT
	currentTimer = timeInBetweenPrompts
	
	
	pass
	


func StartNewGame():
	
	state = GameState.MINIGAME
	Prompt.hide()
	currentTimeLimit = 5
	currentTimer = 5
	HealthBar.value = 100;
	var scene = load(gameList[0][1])
	currentGameNode = scene.instance()
	gameSpot.add_child(currentGameNode)
	
	
	pass
	
func WinGame():

	currentGameNode.free()
	state = GameState.TRANSITION
	currentTimer = timeForTransition


	pass
	
func LoseGame():
	
	currentGameNode.free()
	hp -= 1
	HPFlash.show()
	state = GameState.TRANSITION
	currentTimer = timeForTransition
	
	
	
	pass


func _process(delta):
	
	
	if state == GameState.PROMPT:
		print("Prompt " + str(currentTimer))
		currentTimer -= delta;
		if currentTimer <= 0:
			StartNewGame() 
	elif state == GameState.MINIGAME :
		print("MiniGame " + str(currentTimer))
		currentTimer -= delta
		HealthBar.value = currentTimer/currentTimeLimit * 100
		if (currentTimer <= 0):
			LoseGame()
	elif state == GameState.TRANSITION:
		print("Transition " + str(currentTimer))
		currentTimer -= delta
		if (currentTimer <= 0):
			GetNewGame()
		
		
	
	
	
	pass
