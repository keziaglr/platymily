//
//  GameView.swift
//  GuessWord
//
//  Created by Nicholas Yvees on 23/04/23.
//

import SwiftUI

struct GameView: View {
    
    @State private var timeRemaining = 59 // set initial time remaining to 59 seconds
    @State private var guessChanceRemaining = 3
    @State private var points = 0
    @State private var guessText = ""
    @State private var wordIndex = 0
    @State private var guessedWordsCount = 0
    
    let words = ["PLATYPUS", "PUGGLE", "SNAIL", "SNAKE", "CORAL", "Kak Octa", "SwiftUI"]
    
    var firstWord = ""
    
    var body: some View {
        ZStack{
            Image("GuessTheWord_Board")
                .resizable()
                .scaledToFit()
                .frame(width: 500, height: 500)
            
            VStack {
                Text("0:\(timeRemaining)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .onAppear(){
                        startTimer()
                    }
                    .padding(.bottom, 280)
            }
            
            VStack {
                Text(guessText)
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.leading, 210)
                    .padding(.trailing, 210)
                    .padding(.top, 150)
                
                HStack {
                    Button(action: {
                        guessIncorrect()
                    }) {
                        Text("Wrong (x)")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    .padding(.trailing)
                    
                    Button(action: {
                        guessCorrect()
                    }) {
                        Text("Correct (v)")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .padding(.leading)
                }
                .padding(.top, 90)
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
    }
    
    private func newGuess() {
        guard !words.isEmpty else {
            guessText = "Game Over"
            return
        }
        guessText = words[wordIndex]
        guessChanceRemaining = 3
        wordIndex = (wordIndex + 1) % words.count // increment the index and wrap around if needed
//        guessText = words.randomElement() ?? ""
    }
    
    private func guessCorrect() {
        points += 10
        guessedWordsCount += 1
        
        if guessedWordsCount == words.count{
            guessText = "Perfect Score" //move to winner screen
        }else{
            newGuess()
            timeRemaining = 59 //restart timer
        }
        
    }
    
    private func guessIncorrect() {
        guessChanceRemaining -= 1
        if guessChanceRemaining == 0 {
            guessText = "Game Over" //move to game over screen
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
                timer.invalidate()
                guessIncorrect()
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
