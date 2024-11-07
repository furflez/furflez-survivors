extends CharacterBody2D
signal kill

var hp = 10
var xp = 10

var player = null
var player_colliding = false
var speed = 35

var original_color = Color(1, 1, 1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent().get_node("Player")
	add_to_group("enemies")
	original_color = $Sprite2D.modulate  # Salva a cor original
	$DamageCooldown.start()
	show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player:
		# Calcula a direção para o jogador
		var direction = (player.position - position).normalized()
		# Atualiza a posição do inimigo em direção ao jogador
		# Movimenta o inimigo em direção ao jogador, respeitando colisões
		velocity = direction * speed
		move_and_slide()
		
		if direction.x != 0: 
			$Sprite2D.flip_h = direction.x < 0
	
	if player_colliding:
		deal_damage()
	
func receive_damage(damage:int) -> void:
	hp-=damage
	if hp <= 0:
		kill.emit(xp)
		queue_free()
	else:
		$Sprite2D.modulate = Color(1, 1, 0).darkened(1)  # Branco
		# Espera por 0.1 segundos e volta à cor original
		await get_tree().create_timer(0.25).timeout
		$Sprite2D.modulate = original_color  # Volta à cor original
		
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body.get_groups())
	if body.is_in_group("player"):
		player_colliding = true
		

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_colliding = false
		

	
	
func deal_damage() -> void:
	if $DamageCooldown.is_stopped():
		player.receive_damage(5)
		print('dano')
		$DamageCooldown.start()
	else:
		print('cooldown')
	
	
