extends Node

signal levelUp

var time = 0
var level = 1
var xp = 0
var kills = 0
var wave = 1

# Configurações de progressão de nível
var XP_BASE = 20           # XP inicial para o primeiro nível
var GROWTH_FACTOR = 1.1    # Fator de crescimento por nível

# Função para calcular o XP necessário para um nível específico
func get_xp_for_next_level(level: int) -> int:
	return int(XP_BASE * pow(GROWTH_FACTOR, level))


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.start($StartPosition.position)
	$StageTimer.start()
	$BulletTimer.start()
	$HUD.start()
	$BGM.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_xp_for_next_level(level) < xp:
		level+=1
		xp=0
		levelUp.emit()
		$HUD.set_level_text(level)
		
	$HUD.set_experience_progress(xp, get_xp_for_next_level(level))

func _on_stage_timer_timeout() -> void:
	time+=1
	$HUD.set_timer_text(time)
	add_enemies()
	
	

func _on_bullet_timer_timeout() -> void:
	$BulletTimer.wait_time = 1 / GlobalVariables.bullet_frequency_factor
	$Player.start_shoot()
	

func _on_enemy_kill(xp) -> void:
	kills+=1
	self.xp+=xp
	$HUD.set_kills_text(kills)


func add_enemies():
	if time <= 1800 and time % 5 == 0:
		for i in range(5 * pow(1.1, wave)):
			var mob = load('res://scenes/enemies/enemy_small.tscn').instantiate()
			mob.kill.connect(_on_enemy_kill)
			var mob_spawn_location = $MobPath/MobSpawnLocation
			mob_spawn_location.progress_ratio = randf()
			mob.position = mob_spawn_location.position
			# Adiciona o inimigo à cena
			add_child(mob)
		wave+=1
		
	if time > 1800:
		game_over()

func _on_level_up() -> void:
	get_tree().paused = true
	$LevelUpgrade.start()
	
func game_over():
	self.get_parent().game_over()
