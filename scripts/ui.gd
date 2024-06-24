extends CanvasLayer

var TimeSinceLastShot = 0.0
var FireRate = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.animation_finished.connect(_on_AnimatedSprite2D_animation_finished)
	$AnimatedSprite2D.play(Global.CurrentWeapon + "_idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	TimeSinceLastShot += delta
	var CanShoot = TimeSinceLastShot >= (1.0 / FireRate)
	
	if Global.CurrentWeapon != "knife" and Global.ammo <= 0 :
		Global.CurrentWeapon = "knife"
		$AnimatedSprite2D.play("knife_idle")
		
	if Input.is_action_pressed("spacebar") and CanShoot:
		
		if Global.CurrentWeapon == "knife":
			$AnimatedSprite2D.play("stab")
		else:
			$AnimatedSprite2D.play("shoot_" + Global.CurrentWeapon)
		
		TimeSinceLastShot = 0.0
		
		if Global.CurrentWeapon != "knife":
			if Global.ammo > 0:
				Global.ammo -= 1
	
	match(Global.CurrentWeapon):
		"pistol":
			FireRate = 3.0
		"rifle":
			FireRate = 7.0
		"MachineGun":
			FireRate = 12.0
		"knife":
			FireRate = 2.0
		_:
			FireRate = 1.0
func _on_AnimatedSprite2D_animation_finished():
	$AnimatedSprite2D.play(Global.CurrentWeapon + "_idle")
	
