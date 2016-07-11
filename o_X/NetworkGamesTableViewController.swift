//
//  NetworkGamesTableViewController.swift
//  o_X
//
//  Created by Michelle Lee on 7/4/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class NetworkGamesTableViewController: UITableViewController {

    @IBAction func backbutton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {});//This is intended to dismiss the Info sceen.
            print("pressed")
    }
    
    @IBAction func newGameButton(sender: AnyObject) {
        OXGameS.sharedInstance.createNewGame { game, message in if (message == nil) {
            self.performSegueWithIdentifier("networkSegue", sender: nil)
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OXGameS.sharedInstance.getGames({games, error in
            if let availGames:[OXGame] = games {
                self.games = availGames
                self.tableView.reloadData()
            } else {
                print("Error Message")
            }
        })

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    private var games: [OXGame] = []

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return games.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellIdentifier", forIndexPath: indexPath)
        cell.textLabel?.text = String(games[indexPath.row].host) + " (" + String(games[indexPath.row].ID) + ")"
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        OXGameS.sharedInstance.joinGame(games[indexPath.row].ID) {game, message in
            if message == nil {
                self.performSegueWithIdentifier("networkSegue", sender: indexPath)
            }
            else {
                print("didn't work")
            }
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationVC = segue.destinationViewController as? BoardViewController {
            destinationVC.networkMode = true
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
