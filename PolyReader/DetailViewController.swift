//
//  ViewController.swift
//  PolyReader
//
//  Created by Rean on 4/21/15.
//  Copyright (c) 2015 Rean. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AFNetworking
import AVFoundation

class DetailViewController: UIViewController {
    var recJson: JSON = nil
    var recImage: UIImage = UIImage()

    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var newImage: UIImageView!
    @IBOutlet weak var bodyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        topicLabel.text = recJson["title"].string!
//        bodyTextView.text = recJson["body"].string!
        let replaceString = changeStr(recJson["body"].string!, oldChrs: "\r\n", newChrs: "MYOWNCHGLINE")
        let decodedreplaceStr = replaceString.htmlToString
        let decodedString = changeStr(decodedreplaceStr, oldChrs: "MYOWNCHGLINE", newChrs: "\r\n\r\n")
        println(decodedString)
        bodyTextView.text = decodedString
        
        let img = recJson["image"].string ?? ""
        let imgURL = NSURL(string: img)
        
        newImage.contentMode = UIViewContentMode.ScaleAspectFit
        newImage.setImageWithURL(imgURL)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeStr(originStr: String, oldChrs: String, newChrs: String) -> String {
        let newString = originStr.stringByReplacingOccurrencesOfString(oldChrs, withString: newChrs, options: NSStringCompareOptions.LiteralSearch, range: nil)
//        let newString11 = aString.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
        return newString
        
    }


}

