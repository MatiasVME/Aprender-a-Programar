extends Node

onready var laser = $Laser
onready var hit_1 = $Hit1
onready var hit_2 = $Hit2
onready var ship_hit = $ShipHit
onready var logo_sound = $LogoSound
onready var menu_sound = $MenuSound
onready var enemy_bullet = $EnemyBullet
onready var good_ship_dead = $GoodShipDead
onready var rebound = $Rebound
onready var explosion = $Explosion
onready var consume_life = $ConsumeLife
onready var drop = $Drop
onready var nope = $Nope

enum Sound {
	LASER,
	HIT_1,
	HIT_2,
	SHIP_HIT,
	LOGO_SOUND,
	MENU_SOUND,
	ENEMY_BULLET,
	GOOD_SHIP_DEAD,
	REBOUND,
	EXPLOSION,
	CONSUME_LIFE,
	DROP,
	NOPE
}
var current_sound = null

func select_sound(sound):
	if not Main.sound_enable:
		return
	
	match sound:
		Sound.LASER:
			current_sound = laser
		Sound.HIT_1:
			current_sound = hit_1
		Sound.HIT_2:
			current_sound = hit_2
		Sound.SHIP_HIT:
			current_sound = ship_hit
		Sound.LOGO_SOUND:
			current_sound = logo_sound
		Sound.MENU_SOUND:
			current_sound = menu_sound
		Sound.ENEMY_BULLET:
			current_sound = enemy_bullet
		Sound.GOOD_SHIP_DEAD:
			current_sound = good_ship_dead
		Sound.REBOUND:
			current_sound = rebound
		Sound.EXPLOSION:
			current_sound = explosion
		Sound.CONSUME_LIFE:
			current_sound = consume_life
		Sound.DROP:
			current_sound = drop
		Sound.NOPE:
			current_sound = nope
		
func play_sound():
	if not Main.sound_enable:
		return
	
	if current_sound != null:
		current_sound.play()
		
func stop_sound():
	if not Main.sound_enable:
		return
	
	if current_sound != null:
		current_sound.stop()