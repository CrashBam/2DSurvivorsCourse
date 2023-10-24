class_name WeightedTable

var items: Array[Dictionary] = []
var weight_sum = 0


func add_item(item, weight: int):
	items.append({"item": item, "weight": weight })
	weight_sum += weight


func pick_item():
	# Meaning - You iterate over every element in the array
	# you keep track of the sum of the weights as you iterate
	# and then you see a random int you picked is less then or equal
	# to the sum - and that means you pick that item
	# (you keep a running total of all the weights you cal until
	# you meet or exceed the weight that is randomly chosen at the begin
	
	var chosen_weight = randf_range(1, weight_sum)
	var iteration_sum = 0
	for item in items:
		iteration_sum += item["weight"]
		if chosen_weight <= iteration_sum:
			return item["item"]
