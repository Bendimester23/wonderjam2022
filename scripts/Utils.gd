extends Node

func _ready():
	# Set a random seed for the pseudo random algorithm
	randomize()

func delete_children(node: Node):
	for c in node.get_children():
		c.queue_free()

func instance_node(node: PackedScene, parent: Node) -> Node:
	var i = node.instance()
	parent.add_child(i)
	return i

func instance_node_at_position(node: PackedScene, parent: Spatial, pos: Vector3) -> Spatial:
	var i = instance_node(node, parent) as Spatial
	i.translation = pos
	return i

func get_child_by_name(node: Node, name: String) -> Node:
	for c in node.get_children():
		if c.name == name:
			return c
	
	return null
