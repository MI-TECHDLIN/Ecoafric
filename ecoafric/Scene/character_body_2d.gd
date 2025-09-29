extends CharacterBody2D

# --- Player Stats ---
var speed: float = 250
var jump_velocity: float = -400
var gravity: float = 1200
var health: int = 3
var respawn_position: Vector2 = Vector2(100, 100)

# --- Node References ---
@onready var health_label = get_parent().get_node_or_null("UI/HealthBar")

func _ready() -> void:
	add_to_group("player")  # lets hazards/gates detect this

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Movement
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * speed

	# Jump
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_velocity

	move_and_slide()

	update_health_label()

# --- Called by hazards when touched ---
func hit_hazard() -> void:
	health -= 1
	print("Player hit! Health = %d" % health)

	if health <= 0:
		die()
	else:
		update_health_label()

# --- Player death/respawn ---
func die() -> void:
	print("Player died! Respawning...")
	health = 3
	global_position = respawn_position
	velocity = Vector2.ZERO
	update_health_label()

# --- Update UI ---
func update_health_label() -> void:
	if health_label:
		health_label.text = "Health: %d" % health
