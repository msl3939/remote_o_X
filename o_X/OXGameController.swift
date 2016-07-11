//
//  OXGameController.swift
//  o_X
//
//  Created by Michelle Lee on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation
import SwiftyJSON

class OXGameS: WebService {
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
    
    func getGames(onCompletion: ([OXGame]?, String?) -> Void) {
        
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games"), method: "GET", parameters: nil)
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            print(json)
            
            if (responseCode == 200)   {
                var oxgamelist = [OXGame]()
                for (index,subJson) in json {
                    var newOxGame = OXGame()
                    newOxGame.ID = subJson["id"].intValue
                    newOxGame.host = subJson["host_user"]["uid"].stringValue
                    oxgamelist.append(newOxGame)
                }
                onCompletion(oxgamelist, nil)
            }
            
            else {
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                onCompletion(nil, errorMessage)
            }
        })
    }

    func joinGame (gameId: Int, onCompletion: (OXGame?, String?) -> Void) {
        
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(gameId)/join"), method: "GET", parameters: nil)
        self.executeRequest(request, requestCompletionFunction: { (responseCode, json) in
            if (responseCode == 200) {
                let newGame:OXGame = OXGame()
                newGame.ID = json["id"].intValue
                newGame.host = json["host_user"]["uid"].stringValue
                self.currentGame = newGame
                onCompletion(newGame, nil)
            }
            else {
                onCompletion(nil, "error")
            }
        })
    }
    
    func createNewGame(onCompletion: (OXGame?, String?) -> Void) {
        
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/"), method: "POST", parameters: nil)
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            if (responseCode == 200) {
                let newGame: OXGame = OXGame()
                newGame.ID = json["id"].intValue
                newGame.host = json["host_user"]["uid"].stringValue
                self.currentGame = newGame
                onCompletion(newGame,nil)
            }
            else {
                onCompletion(nil,"error")
            }
        })
    }
   
    
    func makeMove (gameId: Int, onCompletion: (String?) -> Void) {
        
        var board = self.getCurrentGame().serialiseBoard()
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(gameId)"), method: "PUT", parameters: ["board": board])
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            if (responseCode == 200) {
                onCompletion (nil)
            }
            else {
                onCompletion("error")
            }
        })
    }
    
    func refreshGame (gameId: Int, onCompletion:(String?) -> Void) {
        
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(gameId)"), method: "GET", parameters: nil)
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
    
            if (responseCode == 200) {
                var theBoard = json["board"].stringValue
                OXGameS.sharedInstance.getCurrentGame().board = self.getCurrentGame().deserialiseBoard(theBoard)
                
                onCompletion (nil)
    
            }
        })
    
    }
}
