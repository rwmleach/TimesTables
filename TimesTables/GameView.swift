//
//  GameView.swift
//  TimesTables
//
//  Created by Ryan Leach on 10/29/19.
//  Copyright © 2019 Ryan Leach. All rights reserved.
//

import SwiftUI

// MARK:- Game View
struct GameView: View {
	@EnvironmentObject var gameProperties: GameProperties
	@State private var count = 0
	@State private var answer = ""
	@State private var correctAnswer = ""
	@State private var currentQuestion = ""
	@State private var showResult = false
	@State private var gotItRight = false
	@ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
	
	var body: some View {
		VStack {
			
			HStack {
				Button(action: {
					self.gameProperties.gameState = GameStates.Settings
				}) {
					Text("<- Back")
						.foregroundColor(.white)
						.padding()
				}
				Spacer()
			}
			
			
			Spacer()
			
			Text(gotItRight ? "That's correct! ✓" : "That's not right ≠")
			.font(.largeTitle)
				.opacity(self.showResult ? 1.0 : 0.0)
				.animation(.default)
				.padding()
						
			Text("\(self.currentQuestion)")
				.font(.largeTitle)
				.padding()
			
						
			TextField("Enter your answer", text: self.$answer)
				.keyboardType(.decimalPad)
				.textFieldStyle(RoundedBorderTextFieldStyle())
				.padding()
				.textFieldStyle(RoundedBorderTextFieldStyle())
								
			
			Button(action: {
				self.assessAnswer()
			}) {
				Text("Submit")
					.font(.title)
					.fontWeight(.bold)
					.foregroundColor(Color.black)
				.padding()
			}.clipShape(Capsule())
				.background(Color(hex: "f285c1"))
			
			Text("Score: \(gameProperties.score)")
				.font(.headline)
				.padding()
			
			Spacer()
			Spacer()
			
		}
		.onAppear(perform: showQuestion)
//		.offset(y: kGuardian.slide).animation(.easeInOut)
		
	}
	
	// MARK:- Game Methods
	func showQuestion() {
		let cq = gameProperties.questionsThisRound[count]
		self.correctAnswer = "\(gameProperties.answerKey[cq] ?? 0)"
		self.currentQuestion = cq
		self.count += 1
	}
	
	func nextQuestion() {
		showResult.toggle()
		self.answer = ""
//		gotItRight = false
		
		if self.count < self.gameProperties.numQsThisRound {
			self.showQuestion()
		} else {
			self.gameProperties.gameState = GameStates.Result
		}
	}
	
	func assessAnswer() {
		if self.answer == self.correctAnswer {
			self.gotItRight = true
			self.gameProperties.score += 1
		} else {
			self.gotItRight = false
		}
		self.showResult.toggle()
		
		let delay = 1
		DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay), execute: {
			self.nextQuestion()
		})
	}
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
