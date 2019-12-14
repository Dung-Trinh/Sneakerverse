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
            return
        }
            }
        }
        showText(message: "Der Release ist in deinem Kalender vermerkt!")

                   
    }
    
}

extension SneakerDetailViewController{
    func showText(message: String) {
        let textLabel = UILabel(frame: CGRect(x: 0, y: self.view.frame.height-90, width: self.view.frame.width, height: 60))
        textLabel.font = UIFont.systemFont(ofSize: 15)
        textLabel.textAlignment = .center
        textLabel.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        textLabel.textColor = UIColor.red
        textLabel.layer.cornerRadius = 5
        textLabel.clipsToBounds = true
        textLabel.text = message
        self.view.addSubview(textLabel)
        
        UIView.animate(withDuration: 0.6,delay: 0,options: .curveEaseInOut, animations: {
            textLabel.frame = CGRect(x: 0, y: self.view.frame.height - 130, width: self.view.frame.width, height: 60)
        })
        
    
        UIView.animate(withDuration: 0.8, delay: 1.0, options: .curveEaseInOut, animations: {
            textLabel.alpha = 0.0
        }) {(isCompleted) in
            textLabel.removeFromSuperview()
            
        }
      
    }
    
}
