//
//  ViewController.swift
//  MemeRaj
//
//  Created by Vivin Raj on 21/06/16.
//  Copyright © 2016 Vivin Raj. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var topLabel: UITextField!
    @IBOutlet weak var bottomLabel: UITextField!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var topToolbar: UIToolbar!
    
    
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        //NSStrokeWidthAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!
        NSStrokeWidthAttributeName : NSNumber(float: -4.0)
    ]
    
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        print("subscribeToKeyNotifications")
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func subscribeToKeyboardNotifications1() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        print("subscribeToKeyNotifications")
    }
    
    func unsubscribeToKeyboardNotifications1() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    func keyboardWillShow(notification: NSNotification) {
        view.frame.origin.y -= getKeyboardHeight(notification)
        print("keyboard showing")
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        print("get height")
        return keyboardSize.CGRectValue().height
        
    }

    func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
        print("keyboard hiding")
    }
    
    
    func generateMemedImage() -> UIImage
    {
        // Render view to an image
        topToolbar.hidden = true
        bottomToolbar.hidden = true
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame,
                                     afterScreenUpdates: true)
        let memedImage : UIImage =
            UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        topToolbar.hidden = false
        bottomToolbar.hidden = false
        
        //TODO : Hide toolbar & Navigation Bar
        return memedImage
    }
    
    struct Meme {
        var text: String
        var image: UIImage?
        var memedImage: UIImage
    }
    
   /* func save() {
        //Create the meme
        let meme = Meme( text: topLabel.text!, image: imagePickerView.image, memedImage: generateMemedImage())
    }  */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        print("View Appearing")
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        topLabel.defaultTextAttributes = memeTextAttributes
        bottomLabel.defaultTextAttributes = memeTextAttributes
        subscribeToKeyboardNotifications()
        subscribeToKeyboardNotifications1()
        
        }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        unsubscribeToKeyboardNotifications1()
    }
    

 
    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("success")
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //ImagePickerView = UIImageView(frame:CGRect(x: 0,y: 0,width: 100,height: 70))
            print("success1")
            imagePickerView.image = image
            print("success2")
            imagePickerView.contentMode = UIViewContentMode.ScaleAspectFit
            
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func shareButton(sender: AnyObject) {
        //save()
        generateMemedImage()
        let image = generateMemedImage()
        //let image =
        let nextController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.presentViewController(nextController, animated: true, completion: nil)
    }
    



}

