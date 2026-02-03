extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Coins.text = String.num_uint64(Globals.coins)
	Globals.hud = self
	self.update_hearts()

func _physics_process(_delta: float) -> void:
	$Coins.text = String.num_uint64(Globals.coins)

func update_hearts() -> void:
	$FullHeart.size.x = Globals.lives * 53 


func _on_button_button_pressed() -> void:
	pass # Replace with function body.
