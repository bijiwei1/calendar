//
//  DaysTableViewController.swift
//  calendar
//
//  Created by D.O. on 3/6/16.
//  Copyright © 2016 D.O. All rights reserved.
//
import Foundation
import UIKit

class DaysTableViewController : UITableViewController{
    
    var month = 0;
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 31
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("basic")!
        cell.textLabel?.text = "\(indexPath.row+1)"
        
        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "DaysSegue"){
            let selectedRow = tableView.indexPathForSelectedRow?.row
            
            if let dest1 = segue.destinationViewController as? SingleDayTableViewController{
                dest1.title = "\(month)- \(selectedRow!+1)"
                dest1.monthNum = month
                dest1.dayNum = selectedRow! + 1
            }
        }
    }

    
}