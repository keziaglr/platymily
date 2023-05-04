import Foundation
import UIKit

enum Turn
{
	case Red
	case Yellow
}

var currentTurn = Turn.Yellow

func toggleTurn(_ turnImage: UIImageView)
{
	if yellowTurn()
	{
		currentTurn = Turn.Red
		turnImage.image = UIImage(named: "Gacha")
	}
	else
	{
		currentTurn = Turn.Yellow
		turnImage.image = UIImage(named: "Gacha-Puggle")
	}
}

func yellowTurn() -> Bool
{
	return currentTurn == Turn.Yellow
}

func redTurn() -> Bool
{
	return currentTurn == Turn.Red
}

func currentTurnTile() -> Tile
{
	return yellowTurn() ? Tile.Yellow : Tile.Red
}

func currentTurnColor() -> UIImage
{
    if yellowTurn()
    {
        return UIImage(named: "Gacha-Puggle")!
    }
    else
    {
        return UIImage(named: "Gacha")!
    }
}

func currentTurnVictoryMessage() -> String
{
	return yellowTurn() ? "Puggle Wins!" : "Platypus Wins!"
}
