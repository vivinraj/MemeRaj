//
//  SendMemeTableViewController.swift
//  MemeRaj
//
//  Created by Vivin Raj on 11/07/16.
//  Copyright © 2016 Vivin Raj. All rights reserved.
//

import Foundation


import UIKit

class SendMemeTableViewController: UITableViewController {
    
   // var mememes[]: Meme
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    
    override func viewDidLoad() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (
            title: "Add Meme",
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "addMeme")
    }
    
    func addMeme() {
        print("pop view controller")
        if let navigationController = self.navigationController {
            var Controller: ViewController
            Controller = self.storyboard?.instantiateViewControllerWithIdentifier("MemeViewController") as! ViewController
            print("add meme called")
            //  navigationController.presentViewController(self.ViewController, animated: true, completion: nil)
            navigationController.presentViewController(Controller, animated: true, completion: nil)
            
        }
        
       func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            var cell = tableView.dequeueReusableCellWithIdentifier("SendMeme")! as UITableViewCell
            let myMemes = self.memes[indexPath.row]
        
        
         
        // cell.Top.text = myMemes.topTextField
      //   cell.Bottom.text = myMemes.bottomTextField
         cell.Image = myMemes.memedImage
        
            return cell
        }
    }
    
    
    
    
}