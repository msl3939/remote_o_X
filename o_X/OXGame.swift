//
//  OXGame.swift
//  o_X
//
//  Created by Michelle Lee on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation


enum CellType : String {
    
    case O = "O"
    case X = "X"
    case Empty = ""
}

enum OXGameState {
    case Open
    case Abandoned
    case inProgress
    case Tie
    case Won
}



class OXGame {
    
    var board = [CellType](count:9,repeatedValue:CellType.Empty)
    var startType:CellType = CellType.X
    var startTurn:Int = 0
    var ID: Int = 0
    var host: String = ""
    
    func deserialiseBoard(boardString:String) -> [CellType] {
        var theBoard = [CellType]()
        for char in boardString.characters {
            if (char == "x") {
                theBoard.append(CellType.X)
            }
            else if (char == "o") {
                theBoard.append(CellType.O)
            }
            else {
                theBoard.append(CellType.Empty)
            }
        }
        
        print(String(theBoard))
        return theBoard
    }
    
    func serialiseBoard() -> String {
        var boardString:String = ""
        for cell in board {
            if (cell == CellType.X) {
                boardString += "x"
            }
            else if (cell == CellType.O) {
                boardString += "o"
            }
            else {
                boardString += "_"
            }
        }
        print(boardString)
        return boardString
    }
    
    //this function returns how many turns have happened in the game
    func turnCount() -> Int {
        return startTurn
    }
    
    func whoseTurn() -> CellType {
        
        if (self.startType == CellType.X) {
            self.startType = CellType.O
            return CellType.X
        }
        else {
            self.startType = CellType.X
            return CellType.O
        }
    }
    
    func playMove(tag: Int) -> CellType {
        board[tag] = startType
        self.startTurn = self.startTurn+1
        return startType
    }
    
    func gameWon() -> Bool {
        if  (board[0] == board[4] && board[4] == board[8] && board[8] != .Empty) ||
            (board[2] == board[4] && board[4] == board[6] && board[6] != .Empty) ||
            (board[0] == board[1] && board[1] == board[2] && board[0] != .Empty) ||
            (board[3] == board[4] && board[4] == board[5] && board[3] != .Empty) ||
            (board[6] == board[7] && board[7] == board[8] && board[6] != .Empty) ||
            (board[0] == board[3] && board[3] == board[6] && board[6] != .Empty) ||
            (board[1] == board[4] && board[4] == board[7] && board[7] != .Empty) ||
            (board[2] == board[5] && board[5] == board[8] && board[8] != .Empty) {
            return true
        }
        else {
            return false
        }
    }
    
    
    func state() -> OXGameState {
        if (gameWon() == true) {
            return OXGameState.Won
        }
        else if (turnCount() == 9)
        {
            return OXGameState.Tie
        }
        else {
            return OXGameState.inProgress
        }
    }
    
    func reset() {
        startTurn = 0
        board = [CellType](count:9,repeatedValue:CellType.Empty)
    }
}

