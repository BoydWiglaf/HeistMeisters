extends Node
### AutoLoad ###


# Returns an arry of ints with size of given parameter: length
func get_combination(length:int):
	return _generate_combination(length)
	
	
func _generate_combination(length : int):
	var combination = []
	for index in length:
		combination.append(randi() %10)
	return combination
