//
//  ViewController.swift
//  FizzBuzz
//
//  Created by Ashutosh Dave on 15/10/17.
//  Copyright © 2017 Ashutosh Dave. All rights reserved.
//

import UIKit

enum UIState {
	case ready
	case playing
	case lost
}

struct FizzBuzzColors {
	static let activeBackgroundColor = (UIColor(red: 0.369, green: 0.360, blue: 0.600, alpha: 1.0))
	static let timerBackgroundColor = (UIColor(red: 0.251, green: 0.208, blue: 0.435, alpha: 1.0))
	static let readyBackgroundColor = (UIColor(red: 0.600, green: 0.800, blue: 0.600, alpha: 1.0))
	static let lostBackgroundColor = (UIColor.orange)
}

class ViewController: UIViewController {

	var gameScore: Int? {
		didSet {
			guard let unwrappedScore = gameScore else {
				print("gameScore is nil")
				return
			}
			scoreButton.setTitle("\(unwrappedScore)", for: .normal)
		}
	}
	
	var game: Game?
	
	@IBOutlet weak var timerLabel: UILabel!
	@IBOutlet weak var scoreButton: UIButton!
	@IBOutlet weak var fizzButton: UIButton!
	@IBOutlet weak var buzzButton: UIButton!
	@IBOutlet weak var fizzBuzzButton: UIButton!
	
	@IBOutlet weak var highScoreLabel: UILabel!
	@IBOutlet weak var hsLabel: UILabel!
	@IBOutlet weak var multiplesButton: UIButton!
	@IBOutlet weak var settingsButton: UIButton!
	@IBOutlet weak var playButton: UIButton!
	
	 @IBOutlet weak var background: UIView!
	
	var gameTime = 30.0
	
	var gameTimer: Timer?
	var labelTimer: Timer?
	let viewModel = ViewModel()
	var state = UIState.ready {
		didSet {
			toggleState()
		}
	}
	
	var playButtons: [UIButton]!
	var fbButtons: [UIButton]!
	var settingsViews: [UIView]!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		viewModel.viewController = self
		playButtons = [scoreButton, fizzButton, buzzButton, fizzBuzzButton]
		fbButtons = [fizzButton, buzzButton, fizzBuzzButton]
		settingsViews = [highScoreLabel, hsLabel, multiplesButton, playButton]
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func buttonTapped(_ sender: UIButton) {
		if state != .playing {
			state = .playing
		}
		switch sender {
		case scoreButton:
			checkMove(.number)
		case fizzButton:
			checkMove(.fizz)
		case buzzButton:
			checkMove(.buzz)
		case fizzBuzzButton:
			checkMove(.fizzBuzz)
		default:
			break
		}
	}
	
	func checkMove(_ move: Moves) {
		viewModel.checkMove(move)
	}
	
	@IBAction func playAgain(_ sender: UIButton) {
		viewModel.resetGame()
		gameTime = 30.0
		timerLabel.text = "\(gameTime)"
	}
	
	
	// MARK: Output Actions
	
	func nextMovePrompt(_ score: String) {
		scoreButton.setTitle(score, for: UIControlState())
	}
	
	func gameLost() {
		self.state = .lost
		guard let timer = gameTimer else { return }
		timer.invalidate()
		
		guard let labelTimer = labelTimer else { return }
		labelTimer.invalidate()
	}
	
	func setBackgroundColorTo(_ color: UIColor) {
		self.background.backgroundColor = color
	}
	
	// MARK: State
	
	func toggleState() {
		switch state {
		case .ready:
			setBackgroundColorTo(FizzBuzzColors.readyBackgroundColor)
			enablePlayButtons()
			showSettingsButtons()
			showFizzBuzzButtons()
		case .playing:
//			setUpFluidLayer()
			startTimer()
			setBackgroundColorTo(FizzBuzzColors.activeBackgroundColor)
			enablePlayButtons()
			showFizzBuzzButtons()
			hideSettingsButtons()
		case .lost:
			setBackgroundColorTo(FizzBuzzColors.lostBackgroundColor)
			disablePlayButtons()
			showSettingsButtons()
//			removeFluidView()
			hideFizzBuzzButtons()
		}
	}
	
	func resetGame() {
		state = .ready
	}
	
	func disablePlayButtons() {
		for button in playButtons {
			button.isUserInteractionEnabled = false
		}
	}
	
	func enablePlayButtons() {
		for button in playButtons {
			button.isUserInteractionEnabled = true
		}
		timerLabel.text = "\(gameTime)"
	}
	
	func hideSettingsButtons() {
		for view in settingsViews {
			view.isHidden = true
		}
	}
	
	func showSettingsButtons() {
		for view in settingsViews {
			view.isHidden = false
		}
	}
	
	func hideFizzBuzzButtons() {
		for button in fbButtons {
			button.isHidden = true
		}
	}
	
	func showFizzBuzzButtons() {
		for button in fbButtons {
			button.isHidden = false
		}
	}
	
	func startTimer() {
		
		gameTimer = Timer(timeInterval: gameTime, target: self, selector:#selector(ViewController.timerFinished), userInfo: nil, repeats: false)
		labelTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true)
		RunLoop.current.add(gameTimer!, forMode: RunLoopMode.commonModes)
		RunLoop.current.add(labelTimer!, forMode: RunLoopMode.commonModes)
	}
	
	@objc func updateLabel() {
		gameTime -= 1
		print(gameTime)
		timerLabel.text = "\(gameTime)"
	}
	
	@objc func timerFinished() {
		viewModel.timerRunOut()
	}
	
	func stopTimer() {
		gameTimer?.invalidate()
		labelTimer?.invalidate()
	}
	
	// MARK: Segue
	
	@IBAction func unwindToHome2(_ sender: UIStoryboardSegue) {
	}
	
}

//extension ViewController {
//
//	// MARK: FLuidAnimation
//
//	func setUpFluidLayer() {
//		fluidView = BAFluidView(frame: self.background.frame, startElevation: 0.0)
//		fluidView.fillDuration = gameTime
//		fluidView.fill(to: 0.983)
//		fluidView.fillColor = FizzBuzzColors.timerBackgroundColor
//		fluidView.fillRepeatCount = 1
//		fluidView.fillAutoReverse = false
//		self.background.addSubview(fluidView)
//	}
//
//	func pauseFluidView() {
//		fluidView.keepStationary()
//		fluidView.stopAnimation()
//	}
//
//	func playFluidView() {
//		fluidView.startAnimation()
//	}
//
//	func removeFluidView() {
//		fluidView.removeFromSuperview()
//		fluidView = nil
//	}
//
//}


