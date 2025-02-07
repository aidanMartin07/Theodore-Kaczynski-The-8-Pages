extends Node3D

@onready var debris: GPUParticles3D = $Debris
@onready var fire: GPUParticles3D = $Fire
@onready var smoke: GPUParticles3D = $Smoke
@onready var explosion_sound: AudioStreamPlayer3D = $ExplosionSound
@onready var timer: Timer = $Timer

func _ready() -> void:
	debris.emitting = true
	fire.emitting = true
	smoke.emitting = true



func _on_timer_timeout() -> void:
	self.queue_free()
