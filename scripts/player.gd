extends CharacterBody2D
signal hit

@export var speed = 150 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

var weapons= []

var maxHp = 100
var hp = 100

var facing_direction = Vector2(1, 0)  # Inicializa para cima, por exemplo

func start(pos):
	position = pos
	$LifeBar.max_value = maxHp
	$LifeBar.value = hp
	show()
	$CollisionShape2D.disabled = false
	add_weapon('res://scenes/weapons/fire_wand.tscn')

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	add_to_group("player")
	$AnimatedSprite2D.modulate = Color(1, 1, 1, 1)  # Garante que a cor inicial seja a padrão
	hide()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	movement(delta)

func movement(delta: float) -> void:
	$AnimatedSprite2D.play()
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		facing_direction = velocity.normalized()
		$AnimatedSprite2D.animation = "walk"
	else:
		$AnimatedSprite2D.animation = "idle"
		
	if velocity.x != 0:
		$AnimatedSprite2D.flip_v = false
		# See the note below about the following boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0

		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
func add_weapon(weapon_path: String):
	# Carrega a cena da nova arma e a instancia
	var new_weapon = load(weapon_path).instantiate()
	add_child(new_weapon)
	weapons.append(new_weapon)

func start_shoot():
	weapons[0].start_shoot( facing_direction, self.global_position)

func receive_damage(damage: int):
	flash_red()
	hp-=damage
	$LifeBar.value = hp
	
	if hp < 0 :
		self.get_parent().game_over()
		

func flash_red():
	$AnimatedSprite2D.modulate = Color(1, 0, 0, 1)  # Deixa o sprite totalmente vermelho
	await get_tree().create_timer(0.25).timeout # Espera 0.5 segundos
	$AnimatedSprite2D.modulate = Color(1, 1, 1, 1)  # Volta para a cor original (branco)
