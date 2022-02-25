extends CanvasLayer

# Collectible variables
#Coins
export(float) onready var coins_collected = 0.0
onready var last_coin_value : float = 250.0
onready var player_1_coins : Label = $Margin/TopGUI/Player_1/Stats/CoinBox/Coins
onready var player_1_coin_icon : ColorRect = $Margin/TopGUI/Player_1/Stats/CoinBox/Icon
onready var player_2_coins : Label = $Margin/TopGUI/Player_2/Stats/CoinBox/Coins
onready var player_2_coin_icon : ColorRect = $Margin/TopGUI/Player_2/Stats/CoinBox/Icon

