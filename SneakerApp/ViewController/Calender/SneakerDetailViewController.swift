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
    @IBOutlet weak var sneakerName: UILabel!
    @IBOutlet weak var textBox: UITextView!
    @IBOutlet var images: [UIImageView]!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var priceSpan: UILabel!
    @IBOutlet weak var retailPrice: UILabel!
    @IBOutlet weak var notificationBtn: UIButton!
    
    
    var background = BackgroundColor()
    var sneaker : Sneaker?
    
    func updateUI(){
        textBox.text = sneaker?.description
        sneakerName.text = sneaker?.title
        releaseDate.text = sneaker?.releaseDate
        priceSpan.text = sneaker?.priceSpan
        retailPrice.text = sneaker?.retailPrice
        
        let url = URL(string:sneaker!.imageURL)
        let data = try? Data(contentsOf: url!)
        images[0].image = UIImage(data: data!)
        
        var k : Int = 1
        for i in sneaker!.imgArray{
            let url = URL(string: i)
             // TODO: try catch einbauen !
            let data = try? Data(contentsOf: url!)
            images[k].image = UIImage(data: data!)
            k = k+1
            
        }

        
    }
    
    @IBAction func turnOnNotification(_ sender: Any) {

//        UIView.animate(withDuration: 0.4) {
//                self.notificationBtn.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
//             }
//        UIView.animate(withDuration: 0.4) {
//           self.notificationBtn.transform = CGAffineTransform.identity
//        }
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
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        background.createGradientBackground(view: self.view)
        
        /// for notification in forderground
        UNUserNotificationCenter.current().delegate = self
       
        updateUI()
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
        _ = ToastMessage(message: "Der Release ist in deinem Kalender vermerkt!", view: self.view)

                   
    }
    @IBAction func shareBtn(_ sender: UIButton) {
        let text = sneaker?.title
        let URL:NSURL = NSURL(string:"https://stockx.com/de-de/")!
        let image = images[0]
        let vc = UIActivityViewController(activityItems:[ text,URL,image], applicationActivities: [])
        if let popoverController = vc.popoverPresentationController{
            popoverPresentationController!.sourceView = self.view
            popoverPresentationController!.sourceRect = self.view.bounds
            
        }
        self.present(vc,animated: true, completion: nil)
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
