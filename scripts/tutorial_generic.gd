class_name TutorialGeneric
extends Node2D
#FAZER UMA LAMPADA PARA SINALIZAR A DICA
#TIRAR O LABEL DA DICA E FALAR O NOME DO OBJETO NO PROPRIO TEXT
#IMPLEMENTAR O RECT PARA COBRIR O FUNDO DA FASE
#ATIVAR ADICA QUANDO USAR O BOTÃO DE CONTROL

@export var text:String = "lore ipsum"
@onready var panel_container: PanelContainer = $CanvasLayer/PanelContainer
@onready var label: Label = $CanvasLayer/PanelContainer/Label

var already_showing:bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	panel_container.visible = false
	label.visible = false
	label.text = text

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is not Human:return
	if !already_showing:
		#label.text = ""
		self.visible = true
		panel_container.visible = true
		already_showing = true
		var tween = create_tween()
		
		tween.tween_property(label,"visible",true,0.5)
		#tween.tween_property(label,"text",text,0.01*text.length())
		tween.tween_interval(0.065*text.length())
		#tween.tween_property(label,"text","",0.001*text.length())
		
		

func fadeout():	
	#label.visible = false
	already_showing = false


func _on_area_2d_body_exited(body: Node2D) -> void:
	var tween = create_tween()
	tween.tween_property(label,"visible",false,0.5)
	tween.tween_property(panel_container,"visible",false,0)
	tween.tween_callback(fadeout)
