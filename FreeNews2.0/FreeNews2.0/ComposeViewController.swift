//
//  ComposeViewController.swift
//  FreeNews2.0
//
//  Created by Yue Zhao on 4/14/15.
//  Copyright (c) 2015 Yue Zhao. All rights reserved.
//

import UIKit
import Parse

class ComposeViewController: UIViewController {

   
    @IBOutlet var charRemainingLabel: UILabel!
   
    @IBOutlet var sweetTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sweetTextView.layer.borderColor = UIColor.blackColor().CGColor
        sweetTextView.layer.borderWidth = 0.5
        sweetTextView.layer.cornerRadius = 5
        sweetTextView.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func sweetSend(sender: AnyObject) {
        
        var sweet:PFObject =  PFObject(className: "Sweets")
        sweet["content"] = sweetTextView.text
        sweet["sweeter"] = PFUser.currentUser()
        
        sweet.saveInBackground()
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
        
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
