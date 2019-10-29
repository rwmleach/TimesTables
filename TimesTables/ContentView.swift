//
//  ContentView.swift
//  TimesTables
//
//  Created by Ryan Leach on 10/28/19.
//  Copyright © 2019 Ryan Leach. All rights reserved.
//
// Color scheme: https://color.adobe.com/trends/Game-design

import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
//        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff


        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)

    }
}

// MARK:- Content View
struct ContentView: View {
	@EnvironmentObject var gameProperties: GameProperties
	
	let settingsView = SettingsView()
	let gameView = GameView()
	let resultView = ResultView()
		
    var body: some View {
//		Group {
			ZStack {
				LinearGradient(gradient: Gradient(colors: [Color(hex: "84d904"), Color(hex: "16dcf2")]), startPoint: .bottom, endPoint: .top)
					.edgesIgnoringSafeArea(.all)
				
				VStack {
					if self.gameProperties.gameState == GameStates.Game {
						gameView
					} else if self.gameProperties.gameState == GameStates.Result {
						resultView
					} else {
						settingsView
					}
				}
			}
//		}
    }
}


// MARK:- Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView().environmentObject(GameProperties())
    }
}

