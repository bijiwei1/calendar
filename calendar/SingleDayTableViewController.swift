//
//  SingleDayTableViewController.swift
//  calendar
//
//  Created by D.O. on 3/6/16.
//  Copyright © 2016 D.O. All rights reserved.
//

import Foundation
import UIKit

class SingleDayTableViewController : UITableViewController{
    
    var monthNum = 0
    var dayNum = 0
    var events: [AnyObject] = Array()
    
    // adding
    @IBAction func addEvent(sender : UIBarButtonItem) {
        let new = "Test Event \(events.count + 1)"
        let content = "Empty"
        let defaultsKey = "\(monthNum)- \(dayNum)"
        let ce = CalendarEvent(withTitle: new, andDateString: defaultsKey, withDetail: content)
        let encodedCE = NSKeyedArchiver.archivedDataWithRootObject(ce)
        
        events.append(encodedCE)
        
        //For a certain day, every events would be saved as NSUserDefaults
        NSUserDefaults.standardUserDefaults().setObject(events, forKey: defaultsKey)
        
        tableView.reloadData()
    }
    
    // deleting
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // deleting
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete){
            events.removeAtIndex(indexPath.row)
            
            let defaultsKey = "\(monthNum)- \(dayNum)"
            
            NSUserDefaults.standardUserDefaults().setObject(events,forKey: defaultsKey)
            
            NSUserDefaults.standardUserDefaults().synchronize()
            
            let sections = NSIndexSet(index:0)
            tableView.reloadSections(sections, withRowAnimation: .Fade)
            
        }
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //load number of rows
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let defaultsKey = "\(monthNum)- \(dayNum)"
        let currEvents = NSUserDefaults.standardUserDefaults().arrayForKey(defaultsKey)
        
        // check if this is nil
        if let currEvents = currEvents{
            events = currEvents
        }
        return events.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("basic")!
        if let eventObject  = events[indexPath.row] as? NSData{
            let ce = NSKeyedUnarchiver.unarchiveObjectWithData(eventObject) as! CalendarEvent
            cell.textLabel?.text = ce.title
        }
        return cell
    }

    override func prepareForSegue(segue:UIStoryboardSegue, sender:AnyObject?){
        let selectedRow = (tableView.indexPathForSelectedRow?.row)!
        if let dest = segue.destinationViewController as?EventTableViewController{
            if let eventObject = events[selectedRow]as? NSData{
                let ce = NSKeyedUnarchiver.unarchiveObjectWithData(eventObject) as! CalendarEvent
                dest.calendarEvent = ce
            }
        
        }
    }
    
    
    
    
    
}