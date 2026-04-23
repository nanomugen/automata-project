class_name TutorialGeneric
extends Node2D
#FAZER UMA LAMPADA PARA SINALIZAR A DICA
#TIRAR O LABEL DA DICA E FALAR O NOME DO OBJETO NO PROPRIO TEXT
#IMPLEMENTAR O RECT PARA COBRIR O FUNDO DA FASE
#ATIVAR ADICA QUANDO USAR O BOTÃO DE CONTROL
@export var tip_text:String = "tip"
@export var text:String = "lore ipsum"
@onready var label: Label = $Label
@onready var timer: Timer = $Timer
@onready var tip: Label = $tip
#@onready var color_rect: ColorRect = $ColorRect

var already_showing:bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tip.text = tip_text
	if !DataSystem.DATA_OBJECT["tutorial_mode"]:
		self.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if !already_showing and DataSystem.DATA_OBJECT["tutorial_mode"]:
		print("entrou no tutorial")
		self.visible = true
		label.text = ""
		label.visible = true
		#color_rect.visible = true
		already_showing = true
		var tween = create_tween()
		tween.tween_property(label,"text",text,0.006*text.length())
		tween.tween_interval(0.065*text.length())
		tween.tween_property(label,"text","",0.001*text.length())
		tween.tween_callback(fadeout)
		

func fadeout():	
	label.visible = false
	#color_rect.visible = false
	already_showing = false
