extends Node

const screen_scenes : Dictionary = {
	"title": "res://screens/title_screen/title_screen.tscn",
	"main": "res://screens/main/main.tscn",
	
}

const projectiles : Dictionary = {
	"fist": preload("res://projectiles/fist/fist_projectile.tscn"),
	"drone": preload("res://projectiles/droneSummon/drone_summon.tscn"),
	"bullet": preload("res://projectiles/bullet/bullet.tscn"),
	"pistol": preload("res://projectiles/pistol/pistol.tscn"),
	"minigun": preload("res://projectiles/minigun/minigun.tscn")
}

const juices : Dictionary = {
	"splash_txt": preload("res://juices/splash_txt/splash_txt.tscn"),
	
}

const statRes : Dictionary = {
	"pencil": preload("res://Resources/Stats/pencil.tres"),
	"fist": preload("res://Resources/Stats/fist.tres"),
	"drone": preload("res://Resources/Stats/drone.tres"),
	"pistol": preload("res://Resources/Stats/pistol.tres"),
	"minigun": preload("res://Resources/Stats/minigun.tres")
}
