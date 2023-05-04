import Foundation
import UIKit

enum Tile{
	case Red
	case Yellow
	case Empty
}

struct BoardItem
{
	var indexPath: IndexPath!
	var tile: Tile!
	
	func yellowTile() -> Bool
	{
		return tile == Tile.Yellow
	}
	
	func redTile() -> Bool
	{
		return tile == Tile.Red
	}
	
	func emptyTile() -> Bool
	{
		return tile == Tile.Empty
	}
	
	func tileColor() -> UIImage
	{
		if redTile()
		{
            return UIImage(named: "Gacha")!
		}
		if yellowTile()
		{
            return UIImage(named: "Gacha-Puggle")!
		}
        
        return UIImage(named: "Bubble")!
		
        // Create a white circle image programmatically
//        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 20, height: 20))
//        let image = renderer.image { context in
//            let rectangle = CGRect(x: 0, y: 0, width: 20, height: 20)
//            context.cgContext.setFillColor(UIColor.white.cgColor)
//            context.cgContext.fillEllipse(in: rectangle)
//        }
//        return image
	}
}
