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
        
        newGameButton.hidden = true
        
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
    
    @IBAction func newgamebuttonpressed (sender: UIButton) {
        print("New game button pressed.")
        restartGame()
        newGameButton.hidden = true
    }
    

    @IBAction func pushButton(sender: UIButton) {
        var intButton: Int = sender.tag
        print("You pressed button number \(intButton)")
        OXGameS.sharedInstance.playMove(sender.tag)
        let buttontitle = OXGameS.sharedInstance.getCurrentGame().whoseTurn().rawValue
        sender.setTitle(buttontitle, forState: .Normal)
        sender.enabled = false
        
        
        let gamestate = OXGameS.sharedInstance.getCurrentGame().state()
        if (gamestate == OXGameState.Won)
        {
            print ("hey you won")
            
            let alert = UIAlertController(title: "Game Over", message: "\(buttontitle) Won", preferredStyle: UIAlertControllerStyle.Alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: { action in
                self.newGameButton.hidden = false
            })
            
            alert.addAction(dismissAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        else if (gamestate == OXGameState.Tie)
        {
            print ("hey you tied")
            
            let alert = UIAlertController(title: "Game Over", message: "You Tied", preferredStyle: UIAlertControllerStyle.Alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: { action in
                self.newGameButton.hidden = false
            })
            
            alert.addAction(dismissAction)
            
            self.presentViewController(alert, animated: true, completion: nil)

            
        }
       
        

        
        
        
    }
    
    @IBAction func logOutUser(sender: AnyObject) {
        print("You have logged out")
        let storyboard = UIStoryboard(name: "OnboardingStoryboard", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()
        let application = UIApplication.sharedApplication()
        let window = application.keyWindow
        window?.rootViewController = viewController
    }
}

var gameObject:OXGame = OXGame()


