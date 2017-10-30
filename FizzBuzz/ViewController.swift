//
//  ViewController.swift
//  FizzBuzz
//
//  Created by Ashutosh Dave on 15/10/17.
//  Copyright © 2017 Ashutosh Dave. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	var gameScore: Int? {
		didSet {
			guard let unwrappedScore = gameScore else {
				print("gameScore is nil")
				return
			}
			numberButton.setTitle("\(unwrappedScore)", for: .normal)
		}
	}
	
	var game: Game?
	
	@IBOutlet weak var numberButton: UIButton!
	@IBOutlet weak var fizzButton: UIButton!
	@IBOutlet weak var buzzButton: UIButton!
	@IBOutlet weak var fizzBuzzButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		game = Game()
		
		guard let checkedGame = game else {
			print("Game is nil")
			return
		}
		
		gameScore = checkedGame.score
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func play(move: Move) {
		guard let unwrappedGame = game else {
			print("Game is nil!")
			return
		}
		
		let response = unwrappedGame.play(move: move)
		gameScore = response.score
	}

	@IBAction func buttonTapped(_ sender: UIButton) {
		if sender == numberButton {
			play(move: .number)
		}else if sender == fizzButton {
			play(move: .fizz)
		}else if sender == buzzButton {
			play(move: .buzz)
		}else {
			play(move: .fizzBuzz)
		}
	}
}

