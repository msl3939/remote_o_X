//
//  BoardViewController.swift
//  o_X
//

import UIKit

class BoardViewController: UIViewController {

    @IBOutlet weak var newGameButton: UIButton!
    // Create additional IBOutlets here.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func newGameButtonPressed(sender: UIButton) {
        print("New game button pressed.")
    }
    
    // Create additional IBActions here.

    @IBAction func pushButton(sender: AnyObject) {
        let intButton: Int = sender.tag
        print("You pressed button number \(intButton)")
    }
    
    @IBAction func logOutUser(sender: AnyObject) {
        print("You have logged out")
    }
}

