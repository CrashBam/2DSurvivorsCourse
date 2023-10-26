class_name WeightedTable

var items: Array[Dictionary] = []
var weight_sum = 0


func add_item(item, weight: int):
	items.append({"item": item, "weight": weight })
	weight_sum += weight


func remove_item(item_to_remove):
	items = items.filter(func (item): return item["item"] != item_to_remove)
	weight_sum = 0
	for item in items:
		weight_sum += item["weight"]


func pick_item(exclude: Array = []):
	# Meaning - You iterate over every element in the array
	# you keep track of the sum of the weights as you iterate
	# and then you see a random int you picked is less then or equal
	# to the sum - and that means you pick that item
	# (you keep a running total of all the weights you cal until
	# you meet or exceed the weight that is randomly chosen at the begin
	
	# if your array is large this will not work, good for below 300
	
	var adjusted_items: Array[Dictionary] = items
	var adjusted_weight_sum = weight_sum
	if exclude.size() > 0:
		adjusted_items = []
		adjusted_weight_sum = 0
		for item in items:
			if item["item"] in exclude:
				continue
			adjusted_items.append(item)
			adjusted_weight_sum += item["weight"]
	
	
	var chosen_weight = randf_range(1, adjusted_weight_sum)
	var iteration_sum = 0
	for item in adjusted_items:
		iteration_sum += item["weight"]
		if chosen_weight <= iteration_sum:
			return item["item"]
