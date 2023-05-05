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
    
    @StateObject var viewControllerModel = ConnectFour00()
    @ObservedObject var mc : MusicController
    
    var body: some View {
        if !viewControllerModel.gameOver{
            NavigationView{
                ConnectFourViewController()
                    .environmentObject(viewControllerModel)

            }
            .navigationBarBackButtonHidden(true)
        } else{
            GameResultView(scorePlaty: viewControllerModel.scorePlaty, scorePuggle: viewControllerModel.scorePuggle, playAgain: AnyView(ConnectFourView(viewControllerModel: ConnectFour00(), mc: mc)), game: 3, mc: mc)
        }
        
    }
}

struct ConnectFourView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectFourView(viewControllerModel: ConnectFour00(), mc: MusicController())
    }
}
