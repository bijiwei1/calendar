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
    var new :String = ""
    var content: String = ""
    // adding
    @IBAction func addEvent(sender : UIBarButtonItem) {
        createAlert()
        }
    func createAlert() {
    
        let alert = UIAlertController(title:"Create New Event", message: "Enter title", preferredStyle: UIAlertControllerStyle.Alert)
        
        // create cancel action
        let cancel = UIAlertAction(title:"Cancel", style: UIAlertActionStyle.Cancel, handler:nil)
        alert.addAction(cancel)
        
        // Create OK action
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){(action: UIAlertAction) -> Void in
            print("OK")
            let textField = alert.textFields?[0]
            let textField2 = alert.textFields?[1]
            self.new = (textField?.text)!
            self.content = (textField2?.text)!
            let defaultsKey = "\(self.monthNum)- \(self.dayNum)"
            let ce = CalendarEvent(withTitle: self.new, andDateString: defaultsKey, withDetail: self.content)
            let encodedCE = NSKeyedArchiver.archivedDataWithRootObject(ce)
            
            self.events.append(encodedCE)
            
            //For a certain day, every events would be saved as NSUserDefaults
            NSUserDefaults.standardUserDefaults().setObject(self.events, forKey: defaultsKey)
            
            self.tableView.reloadData()

        }
        
        alert.addAction(ok)
        // add text field
        alert.addTextFieldWithConfigurationHandler{(textField: UITextField) -> Void in
            textField.placeholder = "Event Name"
        }
        alert.addTextFieldWithConfigurationHandler{(textField2: UITextField) -> Void in
            textField2.placeholder = "Event Detail"
        }
        
        self.presentViewController(alert, animated: true, completion: nil)
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