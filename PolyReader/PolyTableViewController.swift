//
//  PolyTableViewController.swift
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

class PolyTableViewController: UITableViewController {
    
    var json:JSON = []
    var sendJson:JSON = nil
    var sendImage: UIImage = UIImage()
    
    
    var imageCache = [String:UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var nib = UINib(nibName: "TableCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "customCell")
        
        let url = NSURL(string: "http://engineering.nyu.edu/poly_pages/api/news")
        Alamofire.request(.GET, url!, parameters: ["limit": 100])
            .responseJSON { (request, response, data, error) in
                self.json = JSON(data!)
                
                println("json count \(self.json.count)")
                self.tableView.reloadData()
                
        }
        
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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return json.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:PolyTableViewCell = tableView.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath) as! PolyTableViewCell
        
        let title = json[indexPath.row]["title"].string! //?? ""
        let img = json[indexPath.row]["image"].string ?? ""
        let time = json[indexPath.row]["created"].string! // ?? ""
        let timeChanged = time.stringByReplacingOccurrencesOfString("T", withString: " ", options: NSStringCompareOptions.LiteralSearch, range: nil)
        let imgURL = NSURL(string: img )

        
        cell.newTitle.text = title
        cell.newsTime.text =  timeChanged
        
//        cell.imageView?.image = UIImage(named: "logo-poly")
//        if let img = imageCache[img] {
//            var tempHeight = img.size.height
//            var tempWidth = img.size.width
//            let rect = CGRectMake(0, 0, 100, tempHeight*100/tempWidth)
//            cell.imageView?.frame = rect
//            cell.imageView?.image = img
//        }
//        else {
//            // The image isn't cached, download the img data
//            let request: NSURLRequest = NSURLRequest(URL: imgURL!)
//            let mainQueue = NSOperationQueue.mainQueue()
//            NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
//                if error == nil {
//                    // Convert the downloaded data in to a UIImage object
//                    let image = UIImage(data: data)
//                    // Store the image in to our cache
//                    self.imageCache[img] = image
//                    var tempHeight = image!.size.height
//                    var tempWidth = image!.size.width
//                    // Update the cell
//                    dispatch_async(dispatch_get_main_queue(), {
//                        if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath) {
////                            cellToUpdate.imageView?.image = image
////                            let rect = AVMakeRectWithAspectRatioInsideRect(image!.size, cellToUpdate.imageView!.bounds)
//                            
//                            cellToUpdate.imageView?.frame = CGRectMake(0, 0, 100, tempHeight*100/tempWidth)
//                            cellToUpdate.imageView?.image = image
//                        }
//                    })
//                }
//                else {
//                    println("Error: \(error.localizedDescription)")
//                }
//            })
//        }
        
        

        cell.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        cell.imageView?.setImageWithURL(imgURL, placeholderImage: UIImage(named: "logo-poly"))
//        let rect = AVMakeRectWithAspectRatioInsideRect(cell.imageView!.image!.size, cell.imageView!.bounds)
//        cell.imageView?.frame = rect

        
        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell:PolyTableViewCell = tableView.cellForRowAtIndexPath(indexPath) as! PolyTableViewCell
        sendJson = json[indexPath.row]

        self.performSegueWithIdentifier("DetailSegue", sender: self)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailSegue" {
            if let destinationVC = segue.destinationViewController as? DetailViewController {
                destinationVC.recImage = sendImage
                destinationVC.recJson = sendJson
//                destinationVC.testText = prize.simpleDescription()
//                destinationVC.prize = prize
            }
        }
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }


}
