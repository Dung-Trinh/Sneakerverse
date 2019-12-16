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
    var background = BackgroundColor()
    
    @IBAction func turnOnNotification(_ sender: Any) {
        var popUpMessage = ToastMessage(message: "Benachrichtigung wurden angeschaltet👟✅ ", view: self.view)
        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = "🚨Jordan 1 Release in einer Stunde🚨"
        content.body = "Alle weiteren Informationen findest du in der App."
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default

        
        var dateComponents = Calendar.current.dateComponents(([.year,.month,.day,.hour,.minute,.second]), from: Date())
        print(dateComponents)
        
        if( dateComponents.second!+5 > 60){
            dateComponents.minute! += 1
            dateComponents.second! =  (dateComponents.second!+5) % 60
        }else{
             dateComponents.second! += 5
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
        
        print(dateComponents)
        print("NOTIFY")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        background.createGradientBackground(view: self.view)
        UNUserNotificationCenter.current().delegate = self
       

    }

    
    @IBAction func addCalenderReminder(_ sender: Any) {
        let eventStore:EKEventStore = EKEventStore()

        eventStore.requestAccess(to: .event) { (granted,error) in
            if(granted) && (error == nil)
            {
                print("\n granted: \(granted)\n")

           
        
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

extension SneakerDetailViewController: UNUserNotificationCenterDelegate {

    //for displaying notification when app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        //If you don't want to show notification when app is open, do something here else and make a return here.
        //Even you you don't implement this delegate method, you will not see the notification on the specified controller. So, you have to implement this delegate and make sure the below line execute. i.e. completionHandler.

        completionHandler([.alert, .badge, .sound])
    }

    // For handling tap and user actions
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        switch response.actionIdentifier {
        case "action1":
            print("Action First Tapped")
        case "action2":
            print("Action Second Tapped")
        default:
            break
        }
        completionHandler()
    }

}
