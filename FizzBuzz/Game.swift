//
//  Game.swift
//  FizzBuzz
//
//  Created by Ashutosh Dave on 15/10/17.
//  Copyright © 2017 Ashutosh Dave. All rights reserved.
//

import Foundation

class Game: NSObject {
	
	static let sharedInstance = Game()
	
	var score: Int
	let brain: Brain!
	let memory: GameMemory!
	
	
	override init() {
		score = 0
		brain = Brain()
		memory = GameMemory()
		super.init()
	}
	
	func play(_ move: Moves) -> MoveResponse {
		let newScore = score + 1
		
		if move == brain.check(number: newScore) {
			score = newScore
			return MoveResponse(rightMove: true, score: score)
		} else {
			memory.storeScore(score)
			return MoveResponse(rightMove: false, score: score)
		}
	}
	
	func reset() -> Int {
		score = 0
		return score
	}
	
	func getHighScore() -> Int {
		return memory.getHighScore()
	}
	
	func saveScore() {
		memory.saveScores()
	}
}
