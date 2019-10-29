//
//  ResultView.swift
//  TimesTables
//
//  Created by Ryan Leach on 10/29/19.
//  Copyright © 2019 Ryan Leach. All rights reserved.
//

import SwiftUI

struct ResultView: View {
	@EnvironmentObject var gameProperties: GameProperties
	
	var body: some View {
		VStack {
			
			Spacer()
			
			Text("You scored \(gameProperties.score) " + "\(gameProperties.score == 1 ? "point" : "points")")
				.font(.largeTitle)
				.fontWeight(.bold)
				.padding()
					.background(Color(hex: "7756bf"))
					.foregroundColor(.white)
					.clipShape(Capsule())
			
			Spacer()
			
			Button(action: {
				self.newGame()
			}) {
				Text("Play Again").font(.title)
						.fontWeight(.bold)
						.foregroundColor(Color.black)
					.padding()
				}.background(Color(hex: "f285c1"))
					.clipShape(Capsule())
			
			Spacer()
		}
		
	}
	
	func newGame() {
		gameProperties.score = 0
		gameProperties.gameState = GameStates.Settings
	}
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView()
    }
}
