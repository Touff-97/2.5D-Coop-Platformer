extends CanvasLayer

# Collectible variables
# Coins
export(float) onready var coins_collected = 0.0
onready var total_amount_coins : float = 0.0
onready var last_coin_color : Color = Color.red
onready var player_1_coins : Label = $Margin/TopGUI/Player_1/Stats/CoinBox/Coins
onready var player_1_coin_icon : ColorRect = $Margin/TopGUI/Player_1/Stats/CoinBox/Icon
onready var player_2_coins : Label = $Margin/TopGUI/Player_2/Stats/CoinBox/Coins
onready var player_2_coin_icon : ColorRect = $Margin/TopGUI/Player_2/Stats/CoinBox/Icon

onready var progress_coins : ProgressBar = $Margin/TopGUI/ProgressCoins


func load_total_coins() -> void:
	progress_coins.max_value = total_amount_coins


func collect_coin(value: float, color: Color, owner_: String) -> void:
	coins_collected += value
	progress_coins.value += 1
	
	match owner_:
		"Player_1":
			player_1_coins.text = str(int(player_1_coins.text) + value) + "c"
			player_1_coin_icon.color = color
		
		"Player_2":
			player_2_coins.text = str(int(player_2_coins.text) + value) + "c"
			player_2_coin_icon.color = color
