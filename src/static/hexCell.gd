extends Node


# func real_pos_to_offset(real: Vector2)->OffsetCoord:
# 	pass



const size = 34.0
const width = 51.0

const root_3 = sqrt(3)
const root_3_div_2 = root_3/2

const height = size * sqrt(3)
const height_reciprocal = 1.0/height
const size_reciprocal = 1.0/size

#	directions
#       4
#    ______
# 3 /      \ 5
#  /        \
#  \        /
# 2 \______/ 0
#       1

const dirs = [
	Vector2(1,0),
	Vector2(0,1),
	Vector2(-1,1),
	Vector2(-1,0),
	Vector2(0,-1),
	Vector2(1,-1)
]


#  cube coords
#    ______
#   /      \
#  /        \
#  \        /
#   \______/ x
#      y


# hex: (2, -1)
# offset: (2, 0)
# real: ($%#$.$%%$, %$#$.$3#$)

static func real_to_hex(real: Vector2)-> Vector2:
	var near_x = real.x*2/3*size_reciprocal
	var near_y = -real.x/3*size_reciprocal + real.y*height_reciprocal
	return Vector2(floor(near_x + 0.5), floor(near_y + 0.5))

# return the center position of hexagon
static func hex_to_real(hex: Vector2) -> Vector2:
	return Vector2(size * hex.x * 3/2, hex.x * height/2 + hex.y * size * root_3)

static func hex_to_offset(hex: Vector2) -> Vector2:
	return Vector2(hex.x, hex.y+ (hex.x - ((hex.x as int) & 1)) / 2)

static func offset_to_hex(offset: Vector2) -> Vector2:
	return Vector2(offset.x, offset.y - (offset.x - ((offset.x as int) & 1))/2)
