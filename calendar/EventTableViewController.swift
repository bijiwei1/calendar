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
    
    var calendarEvent : CalendarEvent?
    
    override func viewDidLoad() {
        titleLabel.text = calendarEvent?.title
        dayLabel.text = calendarEvent?.dateString
        detailLabel.text = calendarEvent?.detail
    }
    
    
}