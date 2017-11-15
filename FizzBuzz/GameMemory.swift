//
//  GameMemory.swift
//  FizzBuzz
//
//  Created by Ashutosh Dave on 12/11/17.
//  Copyright © 2017 Ashutosh Dave. All rights reserved.
//

import Foundation

class GameMemory: NSObject {
	lazy var scoreStore: ScoreStore = {
		let filename = GameMemory.getDocumentsDirectory().stringByAppendingPathComponent("fizzbuzz")
		if let deCodedScoreStore = NSKeyedUnarchiver.unarchiveObject(withFile: filename) as? ScoreStore {
			print("using stored store")
			return deCodedScoreStore
		} else {
			print("creating new store")
			return ScoreStore(scores: [], highScore: 0)
		}
	}()
	
	override init() {
		super.init()
	}
	
	func storeScore(_ score: Int) {
		scoreStore.storeScore(score)
	}
	
	func getHighScore() -> Int {
		return scoreStore.highScore
	}
	
	func saveScores() {
		let data = NSKeyedArchiver.archivedData(withRootObject: scoreStore)
		let filenamme = GameMemory.getDocumentsDirectory().stringByAppendingPathComponent("fizzbuzz")
		let result = (try? data.write(to: URL(fileURLWithPath: filenamme), options: [.atomic])) != nil
		print("result of save: \(result)")
	}
	
	static func getDocumentsDirectory() -> String {
		let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
		let documentsDirectory = paths[0]
		return documentsDirectory
	}
}

extension String {
	
	func stringByAppendingPathComponent(_ path: String) -> String {
		
		let nsSt = self as NSString
		
		return nsSt.appendingPathComponent(path)
	}
}

class ScoreStore: NSObject, NSCoding {
	var scores: [Int]
	var highScore: Int
	
	init(scores: [Int], highScore: Int) {
		self.scores = scores
		self.highScore = highScore
	}
	
	func storeScore(_ score: Int) {
		scores.append(score)
		updateHighScore()
	}
	
	func updateHighScore() {
		let sortedScores = scores.sorted { return $0 < $1 }
		highScore = sortedScores.last!
	}
	
	required convenience init?(coder decoder: NSCoder) {
		guard
			let scores = decoder.decodeObject(forKey: "scores") as? [Int]
			else {
				print("Failed to decode score store")
				return nil
			}
		
		let highScore = decoder.decodeCInt(forKey: "highScore")
		let scoreInt = (Int)(highScore)
		
		self.init(scores:scores, highScore: scoreInt)
	}
	
	func encode(with coder: NSCoder) {
		coder.encode(self.scores, forKey: "score")
		coder.encode(self.highScore, forKey: "highScore")
	}
}
