extends NinePatchRect
@onready var price: Label = $PanelContainer/HBoxContainer/Label
@onready var ds: Label = $Label2
@onready var title: Label = $Label
@export var itemname: String
@export var itemprice: String
@export var description: String
func _ready() -> void:
	title.text = itemname
	price.text = itemprice
	ds.text = description
