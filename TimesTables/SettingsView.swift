//
//  SettingsView.swift
//  TimesTables
//
//  Created by Ryan Leach on 10/29/19.
//  Copyright © 2019 Ryan Leach. All rights reserved.
//

import SwiftUI

// MARK:- Settings View
struct SettingsView: View {
	@EnvironmentObject var gameProperties: GameProperties
	@State private var counter = 0
	let numQsArray = ["5", "10", "20", "All"]

	var body: some View {
		VStack {
			Spacer()
			
			Text("TIMES TABLES!")
			.font(.largeTitle)
			.fontWeight(.bold)
			.padding()
				.background(Color(hex: "7756bf"))
				.foregroundColor(.white)
				.clipShape(Capsule())

			Section(header: Text("How many questions?")
				.font(.title)
				.fontWeight(.semibold)
				.foregroundColor(Color.white)) {
				Picker("numQs", selection: $gameProperties.numQs) {
					ForEach(0 ..< numQsArray.count) {
						Text("\(self.numQsArray[$0])")
					}
				}.pickerStyle(SegmentedPickerStyle())
			}

			Stepper(value: $gameProperties.tables, in: 1...12) {
				Text("Up to...")
					.font(.title)
					.foregroundColor(Color.white)
				Text("\(gameProperties.tables) x \(gameProperties.tables)")
					.font(.title)
					.fontWeight(.bold)
					.foregroundColor(Color.white)
			}
			.padding()

			Button(action: {
				self.playGame()
			}) {
				Text("Let's Go!")
					.font(.title)
					.fontWeight(.bold)
					.foregroundColor(Color.black)
					.padding()
			}.background(Color(hex: "f285c1"))
				.clipShape(Capsule())

			Spacer()
		}.foregroundColor(Color(hex: "020e26"))
	}
	
// MARK:- Settings Methods
	
	func playGame() {
		let allQuestions = generateAllQuestions()
		gameProperties.questionsThisRound = chooseQuestions(allQuestions: allQuestions)
		
		gameProperties.gameState = GameStates.Game
		
	}
	
	func generateAllQuestions() -> [String] {
		var allQuestions = [String]()
		
		for q1 in 1...gameProperties.tables {
			for q2 in 1...gameProperties.tables {
				allQuestions.append("What is \(q1) x \(q2)?")
				gameProperties.answerKey["What is \(q1) x \(q2)?"] = q1 * q2
			}
		}
		return allQuestions
	}
	
	func chooseQuestions(allQuestions: [String]) -> [String] {
		var questionsThisRound = [String]()
		var questionSet = allQuestions
		var numQuestions = questionSet.count
		
		var counter: Int
		switch numQsArray[gameProperties.numQs] {
		case "5":
			counter = 5
		case "10":
			counter = 10
		case "20":
			counter = 20
		default:
			counter = questionSet.count
		}
		
		if counter > numQuestions {
			counter = numQuestions
		}
		
		gameProperties.numQsThisRound = counter
		
		while counter > 0 {
			let randomChoice = Int.random(in: 0 ..< numQuestions)
			let addMe = questionSet.remove(at: randomChoice)
			questionsThisRound.append(addMe)
			counter -= 1
			numQuestions -= 1
		}
		
		return questionsThisRound
	}
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
