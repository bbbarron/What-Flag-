//
//  ContentView.swift
//  What Flag?
// based on Project 2 of the the Hacking with SwiftUI
// series (Guess the Flag)
//
//  Created by Barry Barron on 7/29/22.
//  Modified 8/21/2022
//

import SwiftUI

struct FlagImage: View {
    let name: String
    
    var body: some View {
        Image( name)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(color: .black, radius: 5)
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Canada", "Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var totalQuestions = 0
    @State private var gameOver = false
    @State private var selectedFlag = -1
    
    var body: some View {
        ZStack {
            
            LinearGradient(gradient:Gradient(colors:[.indigo, .purple]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack (spacing:15){
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.semibold))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) {number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(name: countries[number])
                        }
                        .rotation3DEffect(.degrees(selectedFlag == number ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(selectedFlag == -1 || selectedFlag == number ? 1.0 : 0.25)
                        .scaleEffect(selectedFlag == -1 || selectedFlag == number ? 1.0 : 0.25)
                        
                        .animation(.default, value: selectedFlag)
                        
                    }
                    Button(" Restart ")  {
                        gameOver = true
                    }
                    .background(Color.white)
                    .foregroundColor(Color.red)
                    VStack (spacing: 10) {  // Add section to show score at bottom of screen
                        Text("Your Score is:")
                            .foregroundColor(.black)
                            .padding(.top, 20)
                        Text("\(score)")
                            .foregroundColor(.black)
                            .fontWeight(.black)
                            .font(.largeTitle)
                        Text("Total questions played: \(totalQuestions)")
                        .foregroundColor(.black)                }
                    
                }
                
                
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
                
                Spacer()
                Spacer()
                
                
            }
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
            Spacer()
            
        }
        .alert("Restarting...", isPresented: $gameOver) {
            Button("Restart", action: reset)
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Your final score was \(score) correct out of \(totalQuestions) questions")
        }
        
    }
    func flagTapped(_ number: Int) {
        selectedFlag = number
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
        selectedFlag = -1
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
