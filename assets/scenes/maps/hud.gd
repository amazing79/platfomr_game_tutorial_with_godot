extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Coins.text = String.num_uint64(Globals.coins)

func _physics_process(_delta: float) -> void:
	$Coins.text = String.num_uint64(Globals.coins)
