extends CanvasLayer

# Called when the node enters the scene tree for the first time.

func start() -> void:
	$ExperienceBar.value = 0
	set_level_text(1)
	set_kills_text(0)

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func set_timer_text(time: int) -> void:
	var minutes = time / 60
	var time_left = time % 60
	$TimeText.text = str(minutes).pad_zeros(2) + ':' + str(time_left).pad_zeros(2)

func set_level_text(level: int) -> void:
	$LevelText.text = 'Level: ' + str(level)
	
func set_kills_text(kills: int) -> void:
	$KillsText.text = 'Kills: ' + str(kills)
	
func set_experience_progress(progress: int, max_progress: int) -> void:
	$ExperienceBar.value = progress
	$ExperienceBar.max_value = max_progress
