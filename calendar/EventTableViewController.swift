//
//  EventTableViewController.swift
//  calendar
//
//  Created by D.O. on 3/6/16.
//  Copyright © 2016 D.O. All rights reserved.
//

import Foundation
import UIKit

class EventTableViewController : UIViewController{
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var titleChange: UITextField!
    
    @IBOutlet weak var DetailChange: UITextField!
    
    @IBOutlet weak var save1: UIButton!
    
    @IBOutlet weak var save2: UIButton!
    var calendarEvent : CalendarEvent?
    
    override func viewDidLoad() {
        titleLabel.text = calendarEvent?.title
        dayLabel.text = calendarEvent?.dateString
        detailLabel.text = calendarEvent?.detail
    }
    
    
    @IBAction func changingTitle(sender: AnyObject) {
        titleLabel.text = titleChange.text
        calendarEvent?.setValue(titleChange.text, forKey: "title")
    }
    
    
    @IBAction func changingDetail(sender: AnyObject) {
        detailLabel.text = DetailChange.text
        calendarEvent?.setValue(titleChange.text, forKey: "detail")
       
    }
    
}