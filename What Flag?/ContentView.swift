//
//  ContentView.swift
//  What Flag?
// based on Project 2 of the the Hacking with SwiftUI
// series (Guess the Flag)
//
//  Created by Barry Barron on 7/29/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var totalQuestions = 0
    @State private var gameOver = false
    
    var body: some View {
        ZStack {
            
            LinearGradient(gradient:Gradient(colors:[.indigo, .purple]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack (spacing:30){
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .font(.subheadline.weight(.semibold))
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle.weight(.semibold))
                }
                
                ForEach(0..<3) {number in
                    Button {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .shadow(color: .black, radius: 5)
                    }
                   
                    }
                    Button(" Restart ")  {
                        gameOver = true
                    }
                    .background(Color.white)
                    .foregroundColor(Color.red)
                VStack (spacing: 10) {  // Add section to show score at bottom of screen
                                   Text("Your Score is:")
                                   .foregroundColor(.white)
                                       .padding(.top, 20)
                                   Text("\(score)")
                                       .foregroundColor(.white)
                                       .fontWeight(.black)
                                       .font(.largeTitle)
                                    Text("Total questions played: \(totalQuestions)")
                                        .foregroundColor(.white)
                }

            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Restarting...", isPresented: $gameOver) {
            Button("Restart", action: reset)
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Your final score was \(score) correct out of \(totalQuestions) questions")
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
        } else {
            scoreTitle = "Sorry, that is incorrect. That's the flag of \(countries[number])"
        }
            totalQuestions += 1
            showingScore = true
        }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
func reset () {
    countries.shuffle()
    score = 0
    correctAnswer = Int.random(in: 0...2)
    totalQuestions = 0
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

}
