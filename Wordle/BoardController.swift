//
//  BoardController.swift
//  Wordle
//
//  Created by Mari Batilando on 2/20/23.
//

import Foundation
import UIKit

class BoardController: NSObject,
                       UICollectionViewDataSource,
                       UICollectionViewDelegate,
                       UICollectionViewDelegateFlowLayout {

  // MARK: - Properties
  var numItemsPerRow = 5
  var numRows = 6
  let collectionView: UICollectionView
  var goalWord: [String]

  var numTimesGuessed = 0
  var isAlienWordle = false
  var currRow: Int {
    return numTimesGuessed / numItemsPerRow
  }

  init(collectionView: UICollectionView) {
    self.collectionView = collectionView
    let rawTheme = SettingsManager.shared.settingsDictionary[kWordThemeKey] as! String
    let theme = WordTheme(rawValue: rawTheme)!
    self.goalWord = WordGenerator.generateGoalWord(with: theme)
    super.init()
    collectionView.delegate = self
    collectionView.dataSource = self
  }

  // MARK: - Public Methods
  func resetBoard(with settings: [String: Any]) {
    applyNumLettersSettings(with: settings)
    applyNumGuessesSettings(with: settings)
    applyThemeSettings(with: settings)
    applyIsAlienWordleSettings(with: settings)
    numTimesGuessed = 0
    collectionView.reloadData()
  }

  // Exercise 5 Pt. 2 (optional): Reset board with current settings but without changing the goalWord
  func resetBoardWithCurrentSettings() {
    // START YOUR CODE HERE
    // ...
    // END YOUR CODE HERE
  }

  // Exercise 1: Change number of letters
  private func applyNumLettersSettings(with settings: [String: Any]) {
    if let numLetters = settings[kNumLettersKey] as? Int {
      numItemsPerRow = numLetters
    }
  }

  // Exercise 2: Change number of guesses (rows)
  private func applyNumGuessesSettings(with settings: [String: Any]) {
    if let guesses = settings[kNumGuessesKey] as? Int {
      numRows = guesses
    }
  }

  // Exercise 3: Change word theme
  private func applyThemeSettings(with settings: [String: Any]) {
    if let rawTheme = settings[kWordThemeKey] as? String,
       let theme = WordTheme(rawValue: rawTheme) {
      goalWord = WordGenerator.generateGoalWord(with: theme)
    }
  }

  // Exercise 4: Enable Alien Wordle mode
  private func applyIsAlienWordleSettings(with settings: [String: Any]) {
    if let alienMode = settings[kIsAlienWordleKey] as? Bool {
      isAlienWordle = alienMode
    }
  }
}


