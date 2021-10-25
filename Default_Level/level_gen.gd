var finished_map = []
const TILE_SIZE = 16


func _init(inp: Array):
	self.inp = inp
	for i in range(len(inp)):
		if typeof(i) == TYPE_STRING:
			pass
		elif typeof(i) == TYPE_ARRAY:
			pass
		else:
			push_error("ERROR IN ")
