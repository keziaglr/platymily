//
//  GameView.swift
//  GuessWord
//
//  Created by Nicholas Yvees on 23/04/23.
//

import SwiftUI

class GuessWord00: ObservableObject{
    @Published var startGame: Bool = false
    @Published var firstTap: Bool = false
    @Published var scorePlaty: Int = 0
    @Published var scorePuggle: Int = 0
    @Published var gameOver: Bool = false
    @Published var platyTurn: Bool = true
    @Published var showPopup: Bool = true
}

struct GameView: View {
    @StateObject var guessWord = GuessWord00()
    @State private var timeRemaining = 59 // set initial time remaining to 59 seconds
    @State private var guessChanceRemaining = 3
    @State private var points = 0
    @State private var guessText = ""
    @State private var wordIndex = 0
    @State private var guessedWordsCount = 0
    @ObservedObject var mc: MusicController
    
    let words = ["PLATYPUS", "PUGGLE", "SNAIL", "SNAKE", "CORAL", "Kak Octa", "SwiftUI"]
    
    var firstWord = ""
    
    var body: some View {
        if !guessWord.gameOver {
            ZStack{
                
                Image("GuessTheWord_Board")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 500, height: 500)
                    .rotationEffect(.degrees(270))
                
                VStack {
                    Text("0:\(timeRemaining)")
                        .font(.custom(AppFont.bold, size: 28))
                        .foregroundColor(.white)
                        .onAppear(){
                            startTimer()
                        }
                        .padding(.bottom, 280)
                }
                .rotationEffect(.degrees(270))
                
                VStack {
                    Text(guessText)
                        .foregroundColor(.white)
                        .font(.custom(AppFont.bold, size: 40))
                        .padding(.top, 150)
                    
                    HStack {
                        Button(action: {
                            guessIncorrect()
                        }) {
                            Text("Wrong")
                                .padding()
                                .foregroundColor(.white)
                                .background(AppColor.red)
                                .cornerRadius(10)
                        }
                        .padding(.trailing)
                        
                        Button(action: {
                            guessCorrect()
                        }) {
                            Text("Correct")
                                .padding()
                                .foregroundColor(.white)
                                .background(AppColor.green)
                                .cornerRadius(10)
                        }
                        .padding(.leading)
                    }
                    .padding(.top, 90)
                }
                .rotationEffect(.degrees(270))
                
                if guessWord.showPopup{
                    PopUpGameTurn(platyTurn: guessWord.platyTurn, potrait: false, showPopup: $guessWord.showPopup)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("Background")
                .resizable()
                .scaledToFill())
            .ignoresSafeArea()
            .onAppear(){
                newGuess()
            }
            .navigationBarBackButtonHidden(true)
        } else{
            GameResultView(scorePlaty: guessWord.scorePlaty, scorePuggle: guessWord.scorePuggle, playAgain: AnyView(GuessTheWord(mc: mc)), game: 1, mc: mc)
        }
        
    }
    
    private func newGuess() {
        guard !words.isEmpty else {
            guessText = "Game Over"
            return
        }
        guessText = words[wordIndex]
//        guessChanceRemaining = 3
        wordIndex = (wordIndex + 1) % words.count // increment the index and wrap around if needed
//        guessText = words.randomElement() ?? ""
    }
    
    private func guessCorrect() {
        if guessWord.platyTurn == true{
            guessWord.scorePlaty += 10
        } else{
            guessWord.scorePuggle += 10
        }
        guessedWordsCount += 1
        
        if guessedWordsCount == words.count{
            if guessWord.platyTurn == true{
                guessWord.platyTurn = false
                guessWord.showPopup = true
                guessChanceRemaining = 3
            } else{
                guessWord.gameOver = true
            }
        }else{
            newGuess()
            timeRemaining = 59 //restart timer
        }
        
    }
    
    private func guessIncorrect() {
        guessChanceRemaining -= 1
        if guessChanceRemaining == 0 {
            if guessWord.platyTurn == true{
                guessWord.platyTurn = false
                guessWord.showPopup = true
                guessChanceRemaining = 3
            } else{
                guessWord.gameOver = true
            }
        } else {
            guessText = "Wrong!"
            newGuess()
            timeRemaining = 59 //restart timer
        }
    }
    
    private func startTimer() {
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                if self.guessChanceRemaining > 1 && self.wordIndex < self.words.count {
                    self.guessIncorrect()
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [self] in
                        self.guessWord.gameOver = true
                    }
                    timer.invalidate()
                }
            }
        }
    }
}


//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView()
//    }
//}
