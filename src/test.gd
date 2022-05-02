extends Node2D

var a setget set_a

var b = [1, 2, 3] setget set_b

const datas = [
	Vector2(1,0),
	Vector2(0,1),
	Vector2(-1,1),
	Vector2(-1,0),
	Vector2(1,-1)
]


const MapRegion = preload("res://src/mapRegion.gd")
onready var map_helper = get_node("hexagonMap")

func _init():
	pass

func _ready():

	print("world ready")
	self.a = 1
	self.a = 2
	self.a = 3
	self.a = self.a
	print("b")
	self.b.push_back(4)
	print("b ", b)

	b_inter([3, 4.5, 0, -1, 2, 1])

	print("b ", b)

	Events.connect("on_left_click_hex", self, "b_create")

	
	
func set_a(a_):
	# self.a = a_
	a = a_
	print("new a is ", a_)

func set_b(b_):
	b = b_
	print("b changed")

func b_inter(another):
	for x in b:
		print("x: ", x)
		if x in another:
			b.erase(x)
			print("remove: ", x)

func b_create(hex):
	print("called: ", hex)
	var tmp = MapRegion.new(map_helper)
	var tmp_datas = []

	for data in datas:
		tmp_datas.push_back(data + hex)

	tmp.pos_datas = SetOperation.intersect(map_helper.walkable, tmp_datas)

