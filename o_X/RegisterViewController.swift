//
//  RegisterViewController.swift
//  o_X
//
//  Created by Michelle Lee on 7/1/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit



class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func registerButtonPressed(sender: AnyObject) {
        UserController.sharedInstance.register(emailTextField.text!, password: passwordTextField.text!, onCompletion: {
            username, string in
    
            if username == nil {
                
                let alert = UIAlertController(title: "Registration Failed", message: string!, preferredStyle: UIAlertControllerStyle.Alert)
               
                
                let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler:
                     nil
                )
                
                alert.addAction(alertAction)
                
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateInitialViewController()
                let application = UIApplication.sharedApplication()
                let window = application.keyWindow
                window?.rootViewController = viewController
            }
            
        }
    )}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}