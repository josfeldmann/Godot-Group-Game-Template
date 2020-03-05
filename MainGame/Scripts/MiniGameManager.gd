extends Node2D


onready var timerBar = $TimerLoadingBar
onready var HPFlash = $FlashHP
onready var HPFlashText = $FlashHP/HPText
onready var prompt = $Prompt
onready var gameSpot = $AttachGameHere
onready var pointsHolder = $Points
onready var pointsText = $Points/PointsText
 

onready var timeInBetweenPrompts: float = 3
onready var timeForTransition : float = 3
onready var currentTimer: float = 0;
onready var currentTimeLimit :  float  = 0
onready var hp: int = 10;
onready var points: int = 0;



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
	gameList = [ ["Press the spacebar","res://ExampleGame1/ExampleScene1.tscn"] ]
	GetNewGame()
	
	
	
	pass # Replace with function body.
	


func GetNewGame():
	
	
	currentPromptString = gameList[0][0]
	currentScenePath = gameList[0][1]
	HPFlash.hide()
	pointsHolder.hide()
	prompt.show()
	prompt.text = currentPromptString
	state = GameState.PROMPT
	currentTimer = timeInBetweenPrompts
	
	
	pass
	


func StartNewGame():
	
	state = GameState.MINIGAME
	prompt.hide()
	currentTimeLimit = 5
	currentTimer = 5
	timerBar.value = 0
	var scene = load(gameList[0][1])
	currentGameNode = scene.instance()
	gameSpot.add_child(currentGameNode)
	
	
	pass
	
func WinGame(var pts):

	currentGameNode.free()
	state = GameState.TRANSITION
	currentTimer = timeForTransition
	timerBar.value = 0
	points += pts
	pointsHolder.show()
	pointsText.set_text("Points: " + str(points))


	pass
	
func LoseGame():
	
	currentGameNode.free()
	hp -= 1
	HPFlash.show()
	HPFlashText.set_text("HP: " + str(hp))
	state = GameState.TRANSITION
	currentTimer = timeForTransition
	timerBar.value = 0
	
	
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
		timerBar.value = currentTimer/currentTimeLimit * 100
		if (currentTimer <= 0):
			LoseGame()
	elif state == GameState.TRANSITION:
		print("Transition " + str(currentTimer))
		currentTimer -= delta
		if (currentTimer <= 0):
			GetNewGame()
		
		
	
	
	
	pass
