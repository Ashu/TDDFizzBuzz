//
//  Brain.swift
//  FizzBuzz
//
//  Created by Ashutosh Dave on 15/10/17.
//  Copyright © 2017 Ashutosh Dave. All rights reserved.
//

import Foundation

class Brain {
	
	func isDivisibleBy(divisor: Int, number: Int) -> Bool {
		return number % divisor == 0
	}
	
	func isDivisibleByThree(number: Int) -> Bool {
		return isDivisibleBy(divisor: 3, number: number)
	}
	
	func isDivisibleByFive(number: Int) -> Bool {
		return isDivisibleBy(divisor: 5, number: number)
	}
	
	func isDivisibleByFifteen(number: Int) -> Bool {
		return isDivisibleBy(divisor: 15, number: number)
	}
	
	func check(number: Int) -> Moves {
		switch (isDivisibleByThree(number: number),isDivisibleByFive(number: number)) {
			case (true,false):
				return .fizz
			case (false, true):
				return .buzz
			case (true, true):
				return .fizzBuzz
			case (false,false):
				return .number
		}
//		if isDivisibleByFifteen(number: number) {
//			return .fizzBuzz
//		}else if isDivisibleByFive(number: number) {
//			return .buzz
//		}else if isDivisibleByThree(number: number) {
//			return .fizz
//		}else {
//			return .number
//		}
		
	}
}
