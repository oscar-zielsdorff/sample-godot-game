extends Node

export (PackedScene) var Mob
var score

func _ready():
	randomize()
#	new_game()


func game_over():
	$ScoreTimer.stop()
	$MobSpawnTimer.stop()
	$Music.stop()
	$DeathSound.play()
	$HUD.show_game_over()


func new_game():
	score = 0
	get_tree().call_group('mobs', 'queue_free')
	$Player.start($StartPosition.position)
	$HUD.update_score(score)
	$HUD.show_message('Get Ready')
	$Music.play()
	$StartDelayTimer.start()


func _on_MobSpawnTimer_timeout():
	# Choose a random location on Path2D
	$MobPath/MobSpawnLocation.offset = randi()
	
	# Create a Mob instance and add it to the scene
	var mob = Mob.instance()
	add_child(mob)
	
	# Set mob position relative to location on path
	mob.position = $MobPath/MobSpawnLocation.position
	
	# Set mob direction perpendicular to the path direction
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	
	# Randomize direction a bit
	direction += rand_range(-PI/4, PI/4)
	mob.rotation = direction
	
	# Set the velocity
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_StartDelayTimer_timeout():
	$MobSpawnTimer.start()
	$ScoreTimer.start()
