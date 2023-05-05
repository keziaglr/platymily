import UIKit
import SwiftUI

class ConnectFour00: ObservableObject{
    @Published var startGame: Bool = false
    @Published var firstTap: Bool = false
    @Published var scorePlaty: Int = 0
    @Published var scorePuggle: Int = 0
    @Published var gameOver: Bool = false
    @Published var platyTurn: Bool = true
    @Published var showPopup: Bool = true
}


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var turnImage: UIImageView!
    
	var redScore = 0
	var yellowScore = 0
    
//    @Published var startGame: Bool = false
//    @Published var firstTap: Bool = false
//    @Published var scorePlaty: Int = 0
//    @Published var scorePuggle: Int = 0
//    @Published var gameOver: Bool = false
//    @Published var platyTurn: Bool = true
//    @Published var showPopup: Bool = true
//    @ObservedObject var connectFour = ConnectFour00()
    private var connectFour = ConnectFour00()
    
    private var winner = ""
    private var gameEnded = false
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
        
        
        
        
        collectionView.backgroundColor = .clear
        
        let backgroundImage = UIImage(named: "Background")?.resizableImage(withCapInsets: .zero, resizingMode: .stretch)
        let backgroundColor = UIColor(patternImage: backgroundImage!)
        view.backgroundColor = backgroundColor
        
		resetBoard()
		setCellWidthHeight()
        
        
	}

	func setCellWidthHeight()
	{
		let width = collectionView.frame.size.width / 9
		let height = collectionView.frame.size.height / 9
		let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
		flowLayout.itemSize = CGSize(width: width, height: height)
	}
	func numberOfSections(in cv: UICollectionView) -> Int
	{
		return board.count
	}
	
	func collectionView(_ cv: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return board[section].count
	}

	func collectionView(_ cv: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		let cell = cv.dequeueReusableCell(withReuseIdentifier: "idCell", for: indexPath) as! BoardCell
		
		let boardItem = getBoardItem(indexPath)
        cell.image.image = boardItem.tileColor()
		return cell
	}
	
	
	func collectionView(_ cv: UICollectionView, didSelectItemAt indexPath: IndexPath)
	{
		let column = indexPath.item
		if var boardItem = getLowestEmptyBoardItem(column)
		{
			if let cell = collectionView.cellForItem(at: boardItem.indexPath) as? BoardCell
			{
				cell.image.image = currentTurnColor()
				boardItem.tile = currentTurnTile()
				updateBoardWithBoardItem(boardItem)
				
				if victoryAchieved()
				{
					if yellowTurn()
					{
                        connectFour.scorePuggle += 10
                        
//                        gameOver = true
                        
					}
					
					if redTurn()
					{
                        connectFour.scorePlaty += 10
//                        gameOver = true
                        
                       
					}
                    connectFour.gameOver = true
                    let nextView =  GameResultView(scorePlaty: connectFour.scorePlaty, scorePuggle: connectFour.scorePuggle, playAgain: AnyView(ConnectFourView(viewControllerModel: ConnectFour00(), mc: MusicController() )), game: 3, mc: MusicController())
                    let hostingController = UIHostingController(rootView: nextView)
                    self.navigationController?.pushViewController(hostingController, animated: true)
//                    self.present(hostingController, animated: true, completion: nil)
//                    addChild(hostingController)
//                    hostingController.view.translatesAutoresizingMaskIntoConstraints = false
//                    view.addSubview(hostingController.view)
//                    hostingController.didMove(toParent: self)
//                    NSLayoutConstraint.activate([
//                        hostingController.view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2),
//                        hostingController.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2),
//                        hostingController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                        hostingController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//                    ])
                    
//					resultAlert(currentTurnVictoryMessage())
                    print("red game over \(connectFour.gameOver)")
                    print("yellow game over \(connectFour.gameOver)")
				}
				
				if boardIsFull()
				{
					resultAlert("Draw")
				}
                
                
				
				toggleTurn(turnImage)
			}
		}
	}
	
	func resultAlert(_ title: String)
	{
        let message = "\nPlatypus: " + String(connectFour.scorePlaty) + "\n\nPuggle: " + String(connectFour.scorePuggle)
		let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
		ac.addAction(UIAlertAction(title: "Next Round", style: .default, handler: {
			[self] (_) in
//			resetBoard()
//			self.resetCells()
            
            let nextView =  GameResultView(scorePlaty: connectFour.scorePlaty, scorePuggle: connectFour.scorePuggle, playAgain: AnyView(ConnectFourView(viewControllerModel: ConnectFour00(), mc: MusicController() )), game: 3, mc: MusicController())
            let hostingController = UIHostingController(rootView: nextView)
            self.present(hostingController, animated: true, completion: nil)
		}))
		self.present(ac, animated: true)
	}
	
	func resetCells()
	{
		for cell in collectionView.visibleCells as! [BoardCell]
		{
			cell.image.image = UIImage(named: "Bubble")
		}
	}
}

