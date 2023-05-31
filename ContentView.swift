//
//  ContentView.swift
//  guessTheFlagProject
//
//  Created by User on 27/05/2023.
//

//SwiftUI has a dedicated Image type for handling pictures in your apps, and there are three main ways you will create them:

import SwiftUI

struct ContentView: View {
    
    func resetGame() {
        scoreCount = 0
        numbersTapped = 0
    }
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreCount = 0
    @State private var numbersTapped = 0
    @State private var showEndGameAlert = false
    @State private var showMenu = true
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        
        NavigationView {
            
            if showMenu {
                ZStack {
                    RadialGradient(stops: [
                        .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                        .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
                    ], center: .top, startRadius: 150, endRadius: 750)
                    .ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        Text("Let's play guess the flag!")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                        
                        Button(action: {
                            showMenu = false
                        }) {
                            Text("Play")
                                .font(.title)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                }
            } else {
                
                ZStack {
                    RadialGradient(stops: [
                        .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                        .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
                    ], center: .top, startRadius: 150, endRadius: 750)
                    .ignoresSafeArea()
                    
                    VStack {
                        Spacer()
                        
                        Text("Guess the Flag")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                        
                        
                        VStack(spacing: 30) {
                            VStack {
                                Text("Tap the flag of")
                                    .foregroundStyle(.secondary)
                                    .font(.subheadline.weight(.heavy))
                                Text(countries[correctAnswer])
                                    .foregroundStyle(.primary)
                                    .font(.largeTitle.weight(.semibold))
                            }
                            
                            ForEach(0..<3) { number in
                                Button {
                                    
                                    flagTapped(number)
                                    
                                    // number parameter set in the closure for ForEach.
                                    
                                    //number parameter set in the function represents the index of tapped button, they could be named differently.
                                    
                                } label: {
                                    Image(countries[number])
                                        .renderingMode(.original)
                                        .clipShape(Capsule())
                                        .shadow(color: .white, radius: 5)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(.linearGradient(Gradient(colors: [.red, .blue]), startPoint: .top, endPoint: .bottom))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                        Spacer()
                        Spacer()
                        
                        Text("Score: \(scoreCount)")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                        
                        
                        Spacer()
                    }
                    .padding()
                }
                .alert(scoreTitle, isPresented: $showingScore) {
                    Button("Continue", action: askQuestion)
                } message: {
                    Text("Your score is \(scoreCount)")
                }
                
                .alert(scoreTitle, isPresented: $showEndGameAlert) {
                    Button("End game") {
                        resetGame()
                        backToMenu()
                    }
                }
            }
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreCount += 1
        } else {
            scoreTitle = "Wrong, that was the flag of \(countries[number]) score was \(scoreCount)"
            scoreCount = 0
        }
        
        showingScore = true
        
        numbersTapped += 1
        endGame()
    }
    
    func endGame() {
        if numbersTapped == 8 {
            scoreTitle = "End of the game, final score: \(scoreCount)"
            showEndGameAlert = true
        }
    }
    
    func backToMenu() {
        showMenu = true
        showEndGameAlert = false
    }
}
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
            
        }
    }
