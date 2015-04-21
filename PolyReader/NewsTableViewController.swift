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

class NewsTableViewController: UITableViewController {
    
    var json:JSON = []
    var count: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "http://engineering.nyu.edu/poly_pages/api/news")
        Alamofire.request(.GET, url!, parameters: ["limit": 100])
            .responseJSON { (request, response, data, error) in
                self.json = JSON(data!)
                self.count = self.json.count

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
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell

        let title = json[indexPath.row]["title"].string! //?? ""
        let img = json[indexPath.row]["image"].string ?? ""
        let teaser = json[indexPath.row]["teaser"].string! // ?? ""
        let imgURL = NSURL(string: img)

        cell.textLabel?.text = title
        cell.detailTextLabel?.text = teaser
        
//        cell.imageView?.contentMode = UIViewContentMode.ScaleToFill

        cell.imageView?.setImageWithURL(imgURL, placeholderImage: UIImage(named: "logo-poly"))
        cell.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        
//        let label = cell.viewWithTag(1000) as? UILabel
//        label?.text = title
        // Configure the cell...

        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
