extends CanvasLayer

# Add vignette effect (a.k.a. dark edges) to the portrait. Enable if the scene happens inside a dark area.
export var add_vignette = false

onready var expressions = $Expressions
onready var vignette = $Vignette

func _ready():
	ExpressionManager.connect("show", self, "show_expression")
	ExpressionManager.connect("hide", self, "hide_expression")

	vignette.visible = add_vignette
	self.visible = false

func show_expression(expression):
	visible = true
	expressions.play(expression)

func hide_expression():
	visible = false
