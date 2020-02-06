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
    @IBOutlet weak var reloadBtn: UIBarButtonItem!
    
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
        self.sortSneakerArray()
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
        
        fetchData()
        
        
    }
    func sortSneakerArray(){
        self.dataFetcher.sortSneaker(sneakers: &self.sneakerCalenderBottom)
        self.dataFetcher.sortSneaker(sneakers: &self.sneakerCalenderTop)
    }
    
    func fetchData(){
        logoLoadingScreen = LogoLoadingScreen()
        controll_tabbar(setBool: false)
        let group = DispatchGroup()
        group.enter()
        logoLoadingScreen?.startLoadingAnimation(view: self.view)
        /// queue because waiting for the fetchSneakerData function
        DispatchQueue.global(qos: .userInitiated).async {
            self.dataFetcher.fetchSneakerData()
            group.leave()
            self.setSneakerArray()
            DispatchQueue.main.async {
            self.calenderTop.reloadData()
            self.calenderBottom.reloadData()
            }
            if self.dataFetcher.fetchSuccessfull == false{
                self.showAlert(title: "E R R O R", message: "FETCH ERROR", type: .error)
            }
            
            /// in main queue to refresh the view
              DispatchQueue.main.async {
                self.allSneaker = self.dataFetcher.allSneaker
                self.setSneakerArray()
                self.sortSneakerArray()

                self.calenderTop.reloadData()
                self.calenderBottom.reloadData()
                self.logoLoadingScreen!.remove()
                self.reloadBtn.isEnabled = true
                self.controll_tabbar(setBool: true)

            }
        }
    }

    
    @IBAction func reloadData(_ sender: UIButton) {
        reloadBtn.isEnabled = false
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
            self.sortSneakerArray()
        case 2:
            self.sneakerCalenderTop=sneakerCalenderTop.filter{$0.brand == "Adidas"}
            self.sneakerCalenderBottom=sneakerCalenderBottom.filter{$0.brand == "Adidas"}
            self.sortSneakerArray()
        case 3:
            self.sneakerCalenderTop=sneakerCalenderTop.filter{$0.brand == "Puma"}
            self.sneakerCalenderBottom=sneakerCalenderBottom.filter{$0.brand == "Puma"}
            self.sortSneakerArray()
        default:
            break
        }
        calenderTop.reloadData()
        calenderBottom.reloadData()
    }
    
    func controll_tabbar(setBool:Bool){
        if let items = tabBarController?.tabBar.items {
                items.forEach { $0.isEnabled = setBool }
        }
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
