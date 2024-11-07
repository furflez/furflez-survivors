extends Area2D


var speed = 250
var direction = Vector2.ZERO  # Variável para armazenar a direção
var damage = 0

func start(new_direction: Vector2, bullet_damage: int) -> void: 
	direction = new_direction.normalized()  # Define e normaliza a direção
	damage = bullet_damage
	$AnimatedSprite2D.animation = "default"
	$AnimatedSprite2D.play()

# Chamado quando o nó entra na cena pela primeira vez.
func _ready() -> void:
	self.scale *= GlobalVariables.bullet_size_factor
	pass

# Chamado a cada frame. 'delta' é o tempo decorrido desde o frame anterior.
func _process(delta: float) -> void:
	position += direction * speed * delta * GlobalVariables.attack_speed_factor # Movimento com base na direção
		# Rotaciona o sprite para a direção do movimento
	if direction.length() > 0:  # Garante que a rotação só acontece se houver direção
		$AnimatedSprite2D.rotation = direction.angle()  # Ajusta a rotação


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()  # Remove o projétil da cena


#func _on_body_entered(body: Node2D) -> void:
	#pass # Replace with function body.




func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):  # Assegura que o "body" é um inimigo
		hide()
		queue_free()
		area.receive_damage(damage)  # Remove o projétil da cena


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):  # Assegura que o "body" é um inimigo
		hide()
		queue_free()
		body.receive_damage(damage)  # Remove o projétil da cena
