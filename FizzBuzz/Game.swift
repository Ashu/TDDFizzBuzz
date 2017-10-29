//
//  Game.swift
//  FizzBuzz
//
//  Created by Ashutosh Dave on 15/10/17.
//  Copyright © 2017 Ashutosh Dave. All rights reserved.
//

import Foundation

class Game {
	var score: Int
	var brain: Brain
	
	init() {
		score = 0
		brain = Brain()
	}
	
	func play(move: String) -> (right: Bool, score: Int) {
		
		let result = brain.check(number: score + 1)
		
		if result == move {
			score += 1
			return (true, score)
		} else {
			return (false, score)
		}
		
	}
}
