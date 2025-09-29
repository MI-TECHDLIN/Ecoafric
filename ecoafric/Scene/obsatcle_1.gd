extends Area2D

@export var damage: int = 1

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	print("Hazard touched by:", body.name)  # DEBUG
	if body.has_method("hit_hazard"):
		body.hit_hazard()
