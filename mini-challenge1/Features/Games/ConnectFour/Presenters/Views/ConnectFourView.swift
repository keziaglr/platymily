//
//  ConnectFourView.swift
//  mini-challenge1
//
//  Created by Nicholas Yvees on 04/05/23.
//

import SwiftUI

struct ConnectFourViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let storyboard = UIStoryboard(name: "ConnectFour", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ConnectFourViewController")
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct ConnectFourView: View {
    
    @ObservedObject var ViewControllerModel: ViewController
    
    var body: some View {
        if !ViewControllerModel.gameOver{
            NavigationView{
                ConnectFourViewController()
            }
            .navigationBarBackButtonHidden(true)
        } else{
//            GameResultView(scorePlaty: ViewControllerModel.scorePlaty, scorePuggle: ViewControllerModel.scorePuggle, playAgain: AnyView(ConnectFourView(ViewControllerModel: ViewController())), game: 3)
        }
        
    }
}

struct ConnectFourView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectFourView(ViewControllerModel: ViewController())
    }
}
