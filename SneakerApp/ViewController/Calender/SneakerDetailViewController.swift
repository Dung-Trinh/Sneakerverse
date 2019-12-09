//
//  SneakerDetailViewController.swift
//  SneakerApp
//
//  Created by Dung  on 01.12.19.
//  Copyright © 2019 Dung. All rights reserved.
//

import UIKit
import EventKit
class SneakerDetailViewController: UIViewController {
    @IBOutlet weak var img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func addCalenderReminder(_ sender: Any) {
        let eventStore:EKEventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event) { (granted,error) in
            if(granted) && (error == nil)
            {
                print("\n granted: \(granted)\n")
                print("\n error: \(error)\n")

           
        
        let event:EKEvent = EKEvent(eventStore:eventStore)
        event.title = "Jordan 1 Calender Notification"
        event.startDate = Date()
        event.endDate = Date()
        event.notes = "this is a note"
        event.calendar = eventStore.defaultCalendarForNewEvents
        do{
            try eventStore.save(event, span: .thisEvent)
        }catch let error as NSError{
            print("Fehler1 NSERROR: \(error)")
        }
        print("save Event")
        
            }else{
                print("Fehler2: \(error)")
            }
        }
                   
    }
    
}
