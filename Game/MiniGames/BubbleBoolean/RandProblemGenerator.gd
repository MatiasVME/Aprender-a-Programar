extends Object

const HAS_NOT_PROB = 3 # 1 de 3
const IS_NUMERIC_PROB = 1.8
const NUMERIC_DISTANCE = 2

var has_not = false
var is_numeric = false

var nums = [0, 0] 
var booleans = [false, false]
# Operador relacional
var oprel

var expresion = []

func _init():
	randomize()
	
func gen_rand_boolean_problem(mini = true):
	if mini:
		reset_values()
		return gen_rand_mini_boolean_problem()

func reset_values():
	has_not = false
	is_numeric = false
	
	nums = [0, 0] 
	booleans = [false, false]
	# Operador relacional
	
	expresion = []

func gen_rand_mini_boolean_problem():
	# Tiene not??
	if 1 == int(round(rand_range(1, HAS_NOT_PROB))):
		has_not = true
	
	# Es numerica ??
	if 1 == int(round(rand_range(1, IS_NUMERIC_PROB))):
		is_numeric = true
	
	# Generamos los números si es numerica, sino generamos los boleanos
	if is_numeric:
		nums[0] = int(round(rand_range(-NUMERIC_DISTANCE, NUMERIC_DISTANCE)))
		nums[1] = int(round(rand_range(-NUMERIC_DISTANCE, NUMERIC_DISTANCE)))
	else:
		if 1 == int(round(rand_range(0,1.45))):
			booleans[0] = true
		if 1 == int(round(rand_range(0,1.45))):
			booleans[1] = true
	
	# Generar el operador relacional al azar
	if is_numeric:
		var rand_num = int(round(rand_range(0, 5.45)))
		
		match rand_num:
			0: oprel = "== "
			1: oprel = "!= "
			2: oprel = "<= "
			3: oprel = ">= "
			4: oprel = "< "
			5: oprel = "> "
	else:
		var rand_num = int(round(rand_range(0, 1.45)))
		
		match rand_num:
			0: oprel = "== "
			1: oprel = "!= "
			
	return build_expresion()
	
func build_expresion():
	if has_not:
		expresion.append("not (")
	
	if is_numeric:
		expresion.append(str(nums[0], " ", oprel, nums[1]))
	else:
		expresion.append(str(booleans[0], " ", oprel, booleans[1]))
	
	if has_not:
		expresion.append(")")
	
	var result = (str(expresion)).replace(", ", "")
	result = result.replace("[", "")
	result = result.replace("]", "")
	
	if not is_numeric:
		result = result.to_lower()
	
	return result
	
static func eval(input):
	var script = GDScript.new()
	script.set_source_code("func eval():\n\treturn " + input)
	script.reload()

	var obj = Reference.new()
	obj.set_script(script)

#	var result = obj.eval()
#	print("result: ", result)

	return obj.eval()
