extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

func start() -> void:
	show()
	$LevelUp.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_1_pressed() -> void:
	GlobalVariables.extra_bullet_count+=1
	finish()


func _on_button_2_pressed() -> void:
	GlobalVariables.attack_speed_factor+=0.2
	finish()


func _on_button_3_pressed() -> void:
	GlobalVariables.bullet_size_factor+=0.2
	finish()
	
func _on_button_4_pressed() -> void:
	GlobalVariables.bullet_frequency_factor+=0.2
	finish()

func finish() -> void:
	$ChooseSound.play()
	hide()
	get_tree().paused = false
