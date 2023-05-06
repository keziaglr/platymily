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
    private var connectFour = ConnectFour00()
    
    private var winner = ""
    private var gameEnded = false
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
        
        let imageView = UIImageView(image: UIImage(named: "ConnectFour_title"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)

        // Add constraints to position and size the image view
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 1),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        collectionView.backgroundColor = .clear
        
        let backgroundImage = UIImage(named: "Background")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(backgroundImageView, at: 0) // add the image view to the back of the view hierarchy

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor), // set the width to match the view
            backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor) // set the height to match the view
        ])
        
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
					}
					
					if redTurn()
					{
                        connectFour.scorePlaty += 10
					}
                    connectFour.gameOver = true
                    let nextView =  GameResultView(scorePlaty: connectFour.scorePlaty, scorePuggle: connectFour.scorePuggle, playAgain: AnyView(ConnectFourView(viewControllerModel: ConnectFour00(), mc: MusicController() )), game: 2, mc: MusicController())
                    let hostingController = UIHostingController(rootView: nextView)
                    self.navigationController?.pushViewController(hostingController, animated: true)
				}
				
				if boardIsFull()
				{
                    if yellowTurn()
                    {
                        connectFour.scorePuggle = 0
                    }
                    
                    if redTurn()
                    {
                        connectFour.scorePlaty = 0
                    }
                    let nextView =  GameResultView(scorePlaty: connectFour.scorePlaty, scorePuggle: connectFour.scorePuggle, playAgain: AnyView(ConnectFourView(viewControllerModel: ConnectFour00(), mc: MusicController() )), game: 2, mc: MusicController())
                    let hostingController = UIHostingController(rootView: nextView)
                    self.navigationController?.pushViewController(hostingController, animated: true)
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

