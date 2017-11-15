//
//  Move.swift
//  FizzBuzz
//
//  Created by Ashutosh Dave on 30/10/17.
//  Copyright © 2017 Ashutosh Dave. All rights reserved.
//

import Foundation

enum Moves {
	case number
	case fizz
	case buzz
	case fizzBuzz
	case endGame
}

struct MoveResponse {
	let rightMove: Bool
	let score: Int
}
