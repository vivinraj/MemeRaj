//
//  ViewController.swift
//  MemeRaj
//
//  Created by Vivin Raj on 21/06/16.
//  Copyright © 2016 Vivin Raj. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topLabel: UITextField!
    @IBOutlet weak var bottomLabel: UITextField!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    
    
    
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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        print("subscribeToKeyNotifications")
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    func keyboardWillShow(notification: NSNotification) {
        
        if bottomLabel.isFirstResponder() {
        
        view.frame.origin.y -= getKeyboardHeight(notification)
        print("keyboard showing")
        }
        
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
        var text2: String
        var image: UIImage?
        var memedImage: UIImage
    }
    
    func save() {
        //Create the meme
        let meme = Meme( text: topLabel.text!, text2: bottomLabel.text!, image: imagePickerView.image, memedImage: generateMemedImage() )
        
        //(UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
        
       // (UIApplication.sharedApplication().delegate as AppDelegate).memes.append(meme)
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topLabel.delegate = self
        bottomLabel.delegate = self
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        print("View Appearing")
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        setupTextField(topLabel, defaultText: "TOP")
        setupTextField(bottomLabel, defaultText: "BOTTOM")
        topLabel.returnKeyType = UIReturnKeyType.Done
        bottomLabel.returnKeyType = UIReturnKeyType.Done
        
        subscribeToKeyboardNotifications()
        
        //shareButton.enabled = false
        
        }
    
    
    func setupTextField(textfield: UITextField, defaultText: String) {
        textfield.delegate = self
        textfield.defaultTextAttributes = memeTextAttributes
        textfield.returnKeyType = UIReturnKeyType.Done
        textfield.text = defaultText
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        
    }
    
    func pickAnImage(chosenSource: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = chosenSource
        presentViewController(imagePicker, animated: true, completion: nil)
    }

 
    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
       pickAnImage(UIImagePickerControllerSourceType.PhotoLibrary)
        
    }
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        pickAnImage(UIImagePickerControllerSourceType.Camera)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("success")
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //ImagePickerView = UIImageView(frame:CGRect(x: 0,y: 0,width: 100,height: 70))
            print("success1")
            imagePickerView.image = image
            print("success2")
            imagePickerView.contentMode = UIViewContentMode.ScaleAspectFit
            shareButton.enabled = true
            print("share Button enabled")
            
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func shareButton(sender: AnyObject) {
        let image = generateMemedImage()
        let nextController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        
      //  typealias UIActivityViewControllerCompletionHandler = (String?, Bool) -> Void
        
        self.presentViewController(nextController, animated: true, completion: nil)
        
        nextController.completionWithItemsHandler = {activity, completed, items, error in
            if completed {
                self.save()
                self.dismissViewControllerAnimated(true, completion: nil)
            }

        }
      
            
        
        
        
        
        
    }
    
    
        
    

    
   func textFieldDidBeginEditing(textField: UITextField) {
    
    if textField.text == "TOP" || textField.text == "BOTTOM" {
        textField.text = ""
        print("text field did begin editing")
    }
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        textField.delegate = self
        print("text Field should return")
        return true;
    }
    
    
    
}



