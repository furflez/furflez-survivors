extends Node


@export var Bullet: PackedScene

var bullet_count: int = 1
var bullet_damage: int = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func start_shoot(facing_direction: Vector2, position) -> void:
	$Timer.start()
	shoot(facing_direction, position)
	
func shoot(direction: Vector2, position) -> void:
	bullet_count = GlobalVariables.extra_bullet_count
	$CastSound.play()
	# Calcula o ângulo base da direção que o jogador está de frente
	var base_angle = direction.angle()
		
	for i in range(bullet_count):
		var new_bullet = Bullet.instantiate()
		new_bullet.position = position
		new_bullet.position.y += 30

		# Calcula o ângulo de cada bala em relação ao ângulo base
		var angle = base_angle + i * (TAU / bullet_count)

		# Define a direção da bala usando o ângulo calculado
		var bullet_direction = Vector2.RIGHT.rotated(angle)

		# Inicia a bala na direção ajustada
		new_bullet.start(bullet_direction, bullet_damage)

		# Adiciona a bala à cena
		get_parent().get_parent().add_child(new_bullet)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
