//
//  ViewController.swift
//  SneakerApp
//
//  Created by Dung  on 19.11.19.
//  Copyright © 2019 Dung. All rights reserved.
//

import UIKit

class CalenderViewController: UIViewController {
    @IBOutlet weak var switcher: UISegmentedControl!
    @IBOutlet weak var calenderTop: UICollectionView!
    @IBOutlet weak var calenderBottom: UICollectionView!
    var allSneaker : [Sneaker] = []
    var sneakerCalenderTop : [Sneaker] = []
    var sneakerCalenderBottom: [Sneaker] = []
    var activityI:CustomActivityIndicator = CustomActivityIndicator()
    var customAlert = CustomAlert()
    var logoLoadingScreen : LogoLoadingScreen?
    var dataFetcher = SneakerDataFetcher()

    func showAlert(title:String,message:String,type:AlertType){
        DispatchQueue.main.async {
            self.customAlert.showAlert(title: title, message: message, alertType: type,view: self.view)
            self.customAlert.okBtn.target(forAction: Selector(("tapped")), withSender: self)
            }
    }
    
    func setSneakerArray(){
        var top: [Sneaker] = []
        var bottom: [Sneaker] = []

            for s in allSneaker{
                if(s.position=="top"){
                    top.append(s)
                }
                if(s.position=="bottom"){
                    bottom.append(s)
                }
            }
        sneakerCalenderTop=top
        sneakerCalenderBottom=bottom
        }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundColor = BackgroundColor()
        backgroundColor.createGradientBackground(view: self.view,colors: nil)
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { granted, error in
                   // handle error if there is one
               })
        calenderTop.dataSource = self
        calenderTop.delegate = self
        
        calenderBottom.dataSource = self
        calenderBottom.delegate = self
        
        
        //fetchData()
        fetchData()
        
    }
    
    func fetchData(){
        logoLoadingScreen = LogoLoadingScreen()
        let group = DispatchGroup()
        group.enter()
        logoLoadingScreen?.startLoadingAnimation(view: self.view)
        /// queue because waiting for the fetchSneakerData fuction
        DispatchQueue.global(qos: .userInitiated).async {
            self.dataFetcher.fetchSneakerData()
            
            group.leave()
            print(self.dataFetcher.allSneaker.count)
            print(self.dataFetcher.sneakerCalenderTop)
            print(self.dataFetcher.sneakerCalenderBottom)

            self.allSneaker = self.dataFetcher.allSneaker
            self.sneakerCalenderTop = self.dataFetcher.sneakerCalenderTop
            self.sneakerCalenderBottom = self.dataFetcher.sneakerCalenderBottom
            
            if self.dataFetcher.fetchSuccessfull == false{
                self.showAlert(title: "E R R O R", message: "FETCH ERROR", type: .error)
            }
            
            /// in main queue to refresh the view
              DispatchQueue.main.async {
                    self.calenderTop.reloadData()
                    self.calenderBottom.reloadData()
                    self.logoLoadingScreen!.remove()

            }
        }
    }
    
    @IBAction func reloadData(_ sender: Any) {
        allSneaker.removeAll()
        sneakerCalenderTop.removeAll()
        sneakerCalenderBottom.removeAll()
        
        self.sneakerCalenderTop=allSneaker
        self.sneakerCalenderBottom=allSneaker
        
        self.calenderTop.reloadData()
        self.calenderBottom.reloadData()
        fetchData()

        
    }
    


    @IBAction func switchViews(_ sender: UISegmentedControl) {
        setSneakerArray()
        switch(sender.selectedSegmentIndex){
        case 0:
            break
        case 1:
            self.sneakerCalenderTop=sneakerCalenderTop.filter{$0.brand == "Nike"}
            self.sneakerCalenderBottom=sneakerCalenderBottom.filter{$0.brand == "Nike"}
        case 2:
            self.sneakerCalenderTop=sneakerCalenderTop.filter{$0.brand == "Adidas"}
            self.sneakerCalenderBottom=sneakerCalenderBottom.filter{$0.brand == "Adidas"}
        case 3:
            self.sneakerCalenderTop=sneakerCalenderTop.filter{$0.brand == "Puma"}
            self.sneakerCalenderBottom=sneakerCalenderBottom.filter{$0.brand == "Puma"}
        default:
            print("")
        }
        calenderTop.reloadData()
        calenderBottom.reloadData()
        
//        if sender.selectedSegmentIndex == 0{
//            setSneakerArray()
//            //self.sneakerCalenderTop = allSneaker;
//
//            calenderTop.reloadData()
//            calenderBottom.reloadData()
//        }
//        else if sender.selectedSegmentIndex == 1{
//            setSneakerArray()
//
//            self.sneakerCalenderTop=sneakerCalenderTop.filter{$0.brand == "Nike"}
//            self.sneakerCalenderBottom=sneakerCalenderBottom.filter{$0.brand == "Nike"}
//            calenderTop.reloadData()
//            calenderBottom.reloadData()
//        }
//        else if sender.selectedSegmentIndex == 2{
//            setSneakerArray()
//
//            self.sneakerCalenderTop=sneakerCalenderTop.filter{$0.brand == "Adidas"}
//            self.sneakerCalenderBottom=sneakerCalenderBottom.filter{$0.brand == "Adidas"}
//            calenderTop.reloadData()
//            calenderBottom.reloadData()
//        }
//        else if sender.selectedSegmentIndex == 3{
//            setSneakerArray()
//
//            self.sneakerCalenderTop=sneakerCalenderTop.filter{$0.brand == "Puma"}
//            self.sneakerCalenderBottom=sneakerCalenderBottom.filter{$0.brand == "Puma"}
//
//            calenderTop.reloadData()
//            calenderBottom.reloadData()
//               }
        
    }
    
}


extension CalenderViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == calenderBottom){
            return sneakerCalenderBottom.count
        }
        return sneakerCalenderTop.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SneakerCell", for: indexPath) as! SneakerCollectionViewCell
        if collectionView == calenderBottom{
            cell.sneaker = sneakerCalenderBottom[indexPath.row]
            return cell
        }
        
        if(sneakerCalenderTop.count>0){
        cell.sneaker = sneakerCalenderTop[indexPath.row]
        }
        return cell
        
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
                cell.alpha=0
        UIView.animate(withDuration: 0.4, animations: {
            cell.alpha=1
        })

    }
    
    
}
//TODO: zur detail view wechseln
extension CalenderViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SneakerDetailViewController") as? SneakerDetailViewController

        if(collectionView == calenderBottom){
            vc?.sneaker = sneakerCalenderBottom[indexPath.row]
            self.navigationController?.pushViewController(vc!,animated:true)
            return
        }
        /// push the DetailViewController on the stack
        
        vc?.sneaker = sneakerCalenderTop[indexPath.row]
self.navigationController?.pushViewController(vc!,animated:true)


    }
}

extension CalenderViewController : AlertDelegate{
    func okTapped(){
        customAlert.remove()
    }
}
