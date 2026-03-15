extends TextureRect
const NEW_PISKEL_7_PNG__5_ = preload("uid://2nw7qveertjq")
const p1 = preload("uid://cpirb8mcjwss5")
const p2 = preload("uid://b8j22woui0ctp")
const p3 = preload("uid://bwre7vu8d2g16")
const p4 = preload("uid://bgvl0got04m38")
const p5 = preload("uid://dt4ain24db2p4")
const p6 = preload("uid://dpu7s4jdwbd0a")

func _process(delta: float) -> void:
	if GameManager.p1:
		self.texture = p1
	if GameManager.p2:
		self.texture = p2
	if GameManager.p3:
		self.texture = p3
	if GameManager.p4:
		self.texture = p4
	if GameManager.p5:
		self.texture = p5
	if GameManager.p6:
		self.texture = p6
	
