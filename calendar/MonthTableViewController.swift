//
//  MonthTableViewController.swift
//  calendar
//
//  Created by D.O. on 3/6/16.
//  Copyright © 2016 D.O. All rights reserved.
//

import Foundation
import UIKit

class MonthTableViewController : UITableViewController{

    let MonthList = ["January", "Febrary","March", "April", "May", "June", "July", "August",
    "September", "Octobor", "November", "December"]
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MonthList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("basic")!
        cell.textLabel?.text = MonthList[indexPath.row]
        
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "MonthSegue"){
            let selectedRow = self.tableView.indexPathForSelectedRow?.row
            
            if let dest = segue.destinationViewController as? DaysTableViewController{
                dest.title = MonthList[selectedRow!]
                dest.month = selectedRow! + 1
            }
        }
    }
}