
extends Resource

# 6 point for a hexagon
const hexagon_size = HexCell.size - 1
const hexagon_data = [
	Vector2(hexagon_size/2, -hexagon_size/2 * HexCell.root_3),
	Vector2(-hexagon_size/2, -hexagon_size/2 * HexCell.root_3),
	Vector2(-hexagon_size, 0),
	Vector2(-hexagon_size/2, hexagon_size/2 * HexCell.root_3),
	Vector2(hexagon_size/2, hexagon_size/2 * HexCell.root_3),
	Vector2(hexagon_size, 0)
]

var parent_node

# type: `Array<Polygon2D>`
var cells = []

# type: `Array<Vector2D>`
# value in hex coords
var pos_datas = null setget set_pos_datas

var cell_color = Color.white

func _init(parent_node_):
	parent_node = parent_node_


func set_color(color_):
	cell_color = color_
	for cell in cells:
		cell.color = cell_color

func set_pos_datas(pos_datas_):
	pos_datas = pos_datas_
	recompute()

func release_regions():
	cells = []

func recompute():
	release_regions()
	if !pos_datas:
		return
	cells = []

	print("test", parent_node.transform)

	for pos in pos_datas:
		var tmp = Polygon2D.new()
		tmp.color = cell_color
		tmp.set_polygon(PoolVector2Array(hexagon_data))
		tmp.transform = Transform2D(
			Vector2(1,0),
			Vector2(0,1),
			HexCell.hex_to_real(pos)
		)
		parent_node.add_child(tmp)

