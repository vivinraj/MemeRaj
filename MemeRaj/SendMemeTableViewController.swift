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
    }
    
    
}