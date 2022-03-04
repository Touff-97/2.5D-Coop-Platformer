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
onready var progress_coins : ProgressBar = $Margin/CollectibleUI/ProgressCoins
# Tokens
export(float) onready var tokens_collected = 0.0
onready var total_amount_tokens : float = 0.0
# Paper Boats
export(float) onready var boats_collected = 0.0
onready var total_amount_boats : float = 0.0


func load_total_colectibles() -> void:
	progress_coins.max_value = total_amount_coins


func collect_collectible(player: String, collectible: String, value: float, color: Color) -> void:
	match collectible:
		"Coin":
			coins_collected += 1
			progress_coins.value += 1
			
			if player == "PlayerController1":
				player_1_coins.text = str(int(player_1_coins.text) + value) + "c"
				player_1_coin_icon.color = color
			elif player == "PlayerController2":
				player_2_coins.text = str(int(player_2_coins.text) + value) + "c"
				player_2_coin_icon.color = color
			
			print("Coins collected: " + str(coins_collected) + "/" + str(total_amount_coins) + "\n")
		
		"Token":
			tokens_collected += 1
			
			if player == "PlayerController1":
				player_1_coins.text = str(int(player_1_coins.text) + value) + "c"
			elif player == "PlayerController2":
				player_2_coins.text = str(int(player_2_coins.text) + value) + "c"
			
			print("Tokens collected: " + str(tokens_collected) + "/" + str(total_amount_tokens) + "\n")
		
		"PaperBoat":
			boats_collected += 1
			
			if player == "PlayerController1":
				player_1_coins.text = str(int(player_1_coins.text) + value) + "c"
			elif player == "PlayerController2":
				player_2_coins.text = str(int(player_2_coins.text) + value) + "c"
			
			print("Paper Boats collected: " + str(boats_collected) + "/" + str(total_amount_boats) + "\n")
		
		"MonumentPiece":
			pass
