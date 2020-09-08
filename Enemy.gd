extends KinematicBody

const MOVE_SPEED = 10
 
onready var raycast = $RayCast
onready var anim_player = $AnimationPlayer
onready var walk = $walk
onready var die = $die
 
var player = null
var dead = false
 
func _ready():
	walk.show()
	die.hide()
	anim_player.play("WALK")
	add_to_group("zombies")
 
func _physics_process(delta):
	if dead:
		return
	if player == null:
		return
 
	var vec_to_player = player.translation - translation
	vec_to_player = vec_to_player.normalized()
	raycast.cast_to = vec_to_player * 1.5
 
	move_and_collide(vec_to_player * MOVE_SPEED * delta)
 
	if raycast.is_colliding():
		var coll = raycast.get_collider()
		if coll != null and coll.name == "Player":
			coll.kill()
 
 
func kill():
	dead = true
	$CollisionShape.disabled = true
	walk.hide()
	die.show()
	anim_player.play("DIE")
 
func set_player(p):
	player = p
