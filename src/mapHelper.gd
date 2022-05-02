extends TileMap

const hex_size = 32

const map_canvas_width = 1240
const map_canvas_height = 680

var used_cells
var walkable = []
var flyable = []

var cell_now = Vector2(0, 0)

func _init():
	Events.connect("on_cell_hover_change", self, "test_jb")

func _ready():
	# get all used cells
	used_cells = self.get_used_cells()

	# compute walkable
	for cell in used_cells:
		var name = offset_to_name(cell)
		if name && name != "water" && name != "mountain":
			print("push! ", name)
			walkable.push_back(HexCell.offset_to_hex(cell))
		else:
			print("deny! ", name)

	# compute flyable
	flyable = used_cells

func _unhandled_input(event):
	if "position" in event:
		var relative_position = (-self.position) + event.position
		var cell_tmp = HexCell.real_to_hex(relative_position)
		
		if relative_position.x > 0 - hex_size && relative_position.x < map_canvas_width - hex_size && relative_position.y > 0 - hex_size && relative_position.y < map_canvas_height - hex_size:
			if cell_now != cell_tmp:
				Events.emit_signal("on_cell_hover_change", cell_now, cell_tmp)
				cell_now = cell_tmp

			if event.is_action_pressed("mouse_left"):
				test_vec(cell_tmp)
				Events.emit_signal("on_left_click_hex", cell_tmp)
			elif event.is_action_pressed("mouse_right"):
				print("right mouse, relative position: ", relative_position)

func offset_to_name(offset):
	return self.tile_set.tile_get_name(self.get_cellv(offset))

func hex_to_name(hex):
	return offset_to_name(HexCell.hex_to_offset(hex))

func all_tileset_names():
	var tmp = self.tile_set.get_tiles_ids()
	var res = []
	for x in tmp:
		res.push_back(self.tile_set.tile_get_name(x))
	return res


func test_vec(x):
	# print("vector: ", x)
	var name = hex_to_name(x)
	print("name: ", name if name else "VOID")
	print("walkable: ", "true" if x in walkable else "false")

func test_jb(x, y):
	print("jb: ", x, y)
