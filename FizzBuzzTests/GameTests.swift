//
//  GameTests.swift
//  FizzBuzzTests
//
//  Created by Ashutosh Dave on 15/10/17.
//  Copyright © 2017 Ashutosh Dave. All rights reserved.
//

import XCTest
@testable import FizzBuzz

class GameTests: XCTestCase {
	
	let game = Game()
	
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	func testGameStartsAtZero() {
		XCTAssertTrue(game.score == 0)
	}
	
	func testOnPlayScoreIncremented() {
		let _ = game.play(move: "1")
		XCTAssertTrue(game.score == 1)
	}
	
	func testOnPlayTwiceScoreIncremented() {
		game.score = 1
		let _ = game.play(move: "2")
		XCTAssertTrue(game.score == 2)
	}
	
	func testIfMoveIsRight() {
		game.score = 2
		let result = game.play(move: "Fizz")
		XCTAssertEqual(result, true)
	}
	
	func testIfMoveIsWrong() {
		game.score = 1
		let result = game.play(move: "Fizz")
		XCTAssertEqual(result, false)
	}
	
	func testIfBuzzMoveIsRight() {
		game.score = 4
		let result = game.play(move: "Buzz")
		XCTAssertEqual(result, true)
	}
	
	func testIfBuzzMoveIsWrong() {
		game.score = 1
		let result = game.play(move: "Buzz")
		XCTAssertEqual(result, false)
	}
	
	func testIfFizzBuzzMoveIsRight() {
		game.score = 14
		let result = game.play(move: "FizzBuzz")
		XCTAssertEqual(result, true)
	}
	
	func testIfFizzBuzzMoveIsWrong() {
		game.score = 1
		let result = game.play(move: "FizzBuzz")
		XCTAssertEqual(result, false)
	}
	
	func testIfNumberMoveIsRight() {
		game.score = 1
		let result = game.play(move: "2")
		XCTAssertEqual(result, true)
	}
	
	func testIfNumberMoveIsWrong() {
		game.score = 2
		let result = game.play(move: "3")
		XCTAssertEqual(result, false)
	}

}
