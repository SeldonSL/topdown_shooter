
extends Area2D

export var Speed = 1
var angle = Vector2(0,0)
var viewport_size = Vector2(0,0)
export var Damage = 1

# TODO: check si es area o body la que se gatilla
func on_area_enter(area):

	if (area.has_method("get_damage")):
         area.get_damage(Damage)
	
	if(!area.is_in_group("bullets")):
		self.queue_free()
		
		
func on_body_enter(body):

	if (body.has_method("get_damage")):
         body.get_damage(Damage)
	
	if(!body.is_in_group("bullets")):		
		self.queue_free()

func _ready():
	set_fixed_process(true)
	self.connect("area_enter", self, "on_area_enter")
	self.connect("body_enter", self, "on_body_enter")
	viewport_size = get_viewport_rect().size
	add_to_group("bullets")

	
func _fixed_process(delta):
	
	var pos = self.get_pos()	
	if (pos.x > (viewport_size.x - 32) or pos.x < 32):
		self.queue_free()
	if (pos.y > (viewport_size.y - 32) or pos.y < 96):
		self.queue_free()		

	pos += Vector2(cos(angle) * Speed * delta, sin(angle) * Speed * delta)	
	self.set_pos(pos)

		
func set_angle(angle_in):	
	angle = angle_in


func _on_Timer_timeout():
	self.queue_free()
	