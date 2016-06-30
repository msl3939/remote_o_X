//
//  BoardViewController.swift
//  o_X
//

import UIKit

class BoardViewController: UIViewController {

    @IBOutlet weak var boardview: UIView!
    @IBOutlet weak var newGameButton: UIButton!
    // Create additional IBOutlets here.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // Create additional IBActions here.
    func restartGame () {
        for subview in boardview.subviews {
            if let button = subview as? UIButton {
                button.setTitle("", forState: .Normal)
                button.enabled = true;
            }
        }
        OXGameS.sharedInstance.restartGame()
    }
    
    @IBAction func newgamebuttonpressed(sender: UIButton) {
        print("New game button pressed.")
        restartGame()
    }

    @IBAction func pushButton(sender: UIButton) {
        var intButton: Int = sender.tag
        print("You pressed button number \(intButton)")
        OXGameS.sharedInstance.playMove(sender.tag)
        var buttontitle = String(OXGameS.sharedInstance.getCurrentGame().whoseTurn())
        sender.setTitle(buttontitle, forState: .Normal)
        sender.enabled = false
        
        var gamestate = OXGameS.sharedInstance.getCurrentGame().state1()
        if (gamestate == OXGameState.Won)
        {
            print ("hey you won")
            restartGame()
        }
        else if (gamestate == OXGameState.Tie)
        {
            print ("hey you tied")
            restartGame()
        }
        
        
        
        
        
    }
    
    @IBAction func logOutUser(sender: AnyObject) {
        print("You have logged out")
    }
}

var gameObject:OXGame = OXGame()


