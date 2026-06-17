extends Control

var last_position: Vector2 = Vector2.ZERO
var wall_rects: Array[Rect2] = []

func _ready():
	last_position = get_viewport().get_mouse_position()
	for child in self.get_children():
		wall_rects.append(child.get_global_rect())

func _process(_delta: float) -> void:
	var current_position = get_viewport().get_mouse_position()
	var safe_position = find_safe_position(last_position, current_position)
	
	if safe_position != current_position:
		warp_mouse(safe_position)
		last_position = safe_position
	else:
		last_position = current_position

func find_safe_position(from: Vector2, to: Vector2) -> Vector2:
	for rect in wall_rects:
		if rect_intersection(rect, from, to) != null:
			var direction = (to - from).normalized()
			return rect_intersection(rect, from, to) - direction
	return to

func rect_intersection(rect: Rect2, from: Vector2, to: Vector2) -> Variant:
	if rect.has_point(from):
		return from

	var closest_t = INF
	var edges = [
		[rect.position, rect.position + Vector2(rect.size.x, 0)],
		[rect.position + Vector2(0, rect.size.y), rect.position + rect.size],
		[rect.position, rect.position + Vector2(0, rect.size.y)],
		[rect.position + Vector2(rect.size.x, 0), rect.position + rect.size],
	]

	for edge in edges:
		var t = segment_intersection_t(from, to, edge[0], edge[1])
		if t != null and t < closest_t:
			closest_t = t

	if closest_t == INF:
		return null

	return from + (to - from) * closest_t

func segment_intersection_t(a: Vector2, b: Vector2, c: Vector2, d: Vector2) -> Variant:
	var ab = b - a
	var cd = d - c
	var denom = ab.x * cd.y - ab.y * cd.x

	if abs(denom) < 0.0001:
		return null

	var t = ((c.x - a.x) * cd.y - (c.y - a.y) * cd.x) / denom
	var u = ((c.x - a.x) * ab.y - (c.y - a.y) * ab.x) / denom

	if t >= 0.0 and t <= 1.0 and u >= 0.0 and u <= 1.0:
		return t

	return null
