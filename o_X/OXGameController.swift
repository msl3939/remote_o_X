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
    
}

