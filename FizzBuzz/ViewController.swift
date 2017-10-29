//
//  ViewController.swift
//  FizzBuzz
//
//  Created by Ashutosh Dave on 15/10/17.
//  Copyright © 2017 Ashutosh Dave. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	var gameScore: Int?
	var game: Game?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		gameScore = 0
		game = Game()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func play(move: String) {
		guard let unwrappedGame = game else {
			print("Game is nil!")
			return
		}
		
		let response = unwrappedGame.play(move: move)
		gameScore = response.score
	}

}

