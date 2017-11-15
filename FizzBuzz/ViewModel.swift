//
//  ViewModel.swift
//  FizzBuzz
//
//  Created by Ashutosh Dave on 12/11/17.
//  Copyright © 2017 Ashutosh Dave. All rights reserved.
//

import UIKit

class ViewModel {
	let game: Game!
	var viewController: ViewController! {
		didSet {
			updateHighScore()
		}
	}
	
	init() {
		self.game = Game.sharedInstance
	}
	
	func checkMove(_ move: Moves) {
		let response = game.play(move)
		if response.rightMove {
			viewController.nextMovePrompt("\(response.score)")
		}else {
			viewController.gameLost()
			updateHighScore()
		}
	}
	
	func resetGame() {
		let resetScore = game.reset()
		viewController.nextMovePrompt("\(resetScore)")
		viewController.resetGame()
	}
	
	func updateHighScore() {
		let highScore = game.getHighScore()
		viewController.highScoreLabel.text = "\(highScore)"
	}
	
	func timerRunOut() {
		checkMove(.endGame)
	}
}
