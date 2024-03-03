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
  
  // This function should reset the board with the current settings without changing the goalWord
    
    func resetBoardWithCurrentSettings() {
        
        numTimesGuessed = 0
        collectionView.reloadData()
        
    }
  
  /* Implement applyNumLettersSettings to change the number of letters in the goal word
      - Use a breakpoint to inspect or print the `settings` argument
      - There is a constant `kNumLettersKey` in Constants.swift that you can use as the key to grab the value in the dictionary
      - Assign the correct value of the setting to the `numItemsPerRow` property.
      - You will need to cast the value to the correct type
   */

    private func applyNumLettersSettings(with settings: [String: Any]) {
        
        if let numLetter = settings[kNumLettersKey] as? Int {
            numItemsPerRow = numLetter
            print("# of letters:",numLetter)
        }
        
    }
  
  /* Implement applyNumGuessesSettings to change the number of rows in the board
      - Use a breakpoint to inspect or print the `settings` argument
      - There is a constant `kNumGuessesKey` in Constants.swift that you can use as the key to grab the value in the dictionary
      - Assign the correct value of the setting to the `numRows` property.
      - You will need to cast the value to the correct type
   */
    
    private func applyNumGuessesSettings(with settings: [String: Any]) {
        
        if let numGuess = settings[kNumGuessesKey] as? Int {
            numRows = numGuess
            print("# of Guesses:",numGuess)
        }
        
    }
  
  /* Implement applyThemeSettings to change the goal word according to the theme
        - There is a constant `kWordThemeKey` in Constants.swift that you can use as the key to grab the theme as a String in the dictionary
        - Pass-in the theme to `WordGenerator.generateGoalWord` (see WordGenerator.swift) and assign its result to the `goalWord` defined above
            - The value stored in the settings dictionary is a String, but `WordGenerator.generateGoalWord` expects a WordTheme type.
            - Use the `WordTheme(rawValue:)` initializer to pass-in the string from the dictionary to get the correct type
  */
  
    private func applyThemeSettings(with settings: [String: Any]) {
        
        if let rawTh = settings[kWordThemeKey] as? String,
           let theme = WordTheme(rawValue: rawTh) {
            goalWord = WordGenerator.generateGoalWord(with: theme)
        }
        
    }
  
  /* Implement applyIsAlienWordleSettings to change the goal word after each guess
        - There is a constant `kIsAlienWordleKey` in Constants.swift that you can use as the key to grab the value in the dictionary
        - There is a corresponding property located in this file that you should assign the value of the setting to (look at the "Properties" section above).
  */
  
    private func applyIsAlienWordleSettings(with settings: [String: Any]) {
        
        if let afterGuess = settings[kIsAlienWordleKey] as? Bool{
            isAlienWordle = afterGuess
            print("Is the game level > beginner?:",afterGuess)
        }
        
    }
}
