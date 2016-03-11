//
//  CalendarEvent.swift
//  calendar
//
//  Created by D.O. on 3/6/16.
//  Copyright © 2016 D.O. All rights reserved.
//

import Foundation

class CalendarEvent : NSObject{

    var title : String
    var dateString: String
    var detail : String

    
    init(withTitle t : String, andDateString ds : String, withDetail dd : String){
        title = t
        dateString = ds
        detail = dd
        
    }
    
    init(withCoder coder: NSCoder) {
        dateString = coder.decodeObjectForKey("dateString") as! String
        title = coder.decodeObjectForKey("title") as! String
        detail = coder.decodeObjectForKey("detail") as! String
    }
    
    func encodeWithCoder (coder: NSCoder){
        coder.encodeObject(dateString,forKey:  "dateString")
        coder.encodeObject(title, forKey: "title")
        coder.encodeObject(detail, forKey:"detail")
    }
 
}