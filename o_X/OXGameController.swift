//
//  OXGameController.swift
//  o_X
//
//  Created by Michelle Lee on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation

class OXGameS {
    static let sharedInstance = OXGameS()
    private var currentGame:OXGame = OXGame()
    
    func getCurrentGame() -> OXGame {
        return currentGame
    }
    func restartGame() {
        currentGame.reset()
    }
    func playMove(tag: Int) {
        currentGame.playMove(tag)
    }
}
