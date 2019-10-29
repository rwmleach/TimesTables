//
//  GameProperties.swift
//  TimesTables
//
//  Created by Ryan Leach on 10/28/19.
//  Copyright © 2019 Ryan Leach. All rights reserved.
//

import Foundation

enum GameStates {
	case Settings
	case Game
	case Result
}

class GameProperties: ObservableObject {
	@Published var tables = 1
	@Published var numQs = 0
	@Published var numQsThisRound = 0
	@Published var score = 0
	@Published var questionsThisRound = [String]()
	@Published var answerKey = [String: Int]()
	@Published var gameState = GameStates.Settings
}
