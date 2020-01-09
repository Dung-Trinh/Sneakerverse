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
        backgroundColor.createGradientBackground(view: self.view)
        
        calenderTop.dataSource = self
        calenderTop.delegate = self
        
        calenderBottom.dataSource = self
        calenderBottom.delegate = self
        
//        allSneaker.append(Sneaker(title: "Nike schuh", date: "12.12", img: UIImage(named: "j1")!,brand:"Nike"))
//        allSneaker.append(Sneaker(title: "adidas schuh", date: "12.12", img: UIImage(named: "y1")!,brand:"Adidas"))
//        allSneaker.append(Sneaker(title: "puma schuh", date: "12.12", img: UIImage(named: "p1")!,brand:"Puma"))
        

        fetchSneaker { (res) in
            switch res {
            case .success(let article):
               article.forEach({ (article) in
                print(article.position)

                    self.allSneaker.append(article)
                })
            case .failure(let err):
                print("Failed to fetch courses:", err)
            }
            //einfügen der schuhe
            for s in self.allSneaker{
              if s.position == "bottom"{
                self.sneakerCalenderBottom.append(s)
              }else if s.position == "top"{
                self.sneakerCalenderTop.append(s)
                }
          }
            DispatchQueue.main.async {
            self.calenderTop.reloadData()
            self.calenderBottom.reloadData()
            }
        }

       
        //self.sneakerCalenderTop=allSneaker

        
    }
    
  
    
    fileprivate func fetchSneaker(completion:@escaping(Result<[Sneaker],Error>)-> Void){
        let urlString = "https://flasksneakerapi.herokuapp.com/sneakers"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
                       
                       if let err = err {
                           completion(.failure(err))
                           return
                       }
                       
                       // successful
                       do {
                        let article = try JSONDecoder().decode([Sneaker].self, from: data!)
                           completion(.success(article))
           //                completion(courses, nil)
                           
                       } catch let jsonError {
                           completion(.failure(jsonError))
           //                completion(nil, jsonError)
                       }
                       
                       
                   }.resume()
    }
     

    @IBAction func switchViews(_ sender: UISegmentedControl) {
        
        
        if sender.selectedSegmentIndex == 0{
            setSneakerArray()
            //self.sneakerCalenderTop = allSneaker;
            self.sneakerCalenderTop.sort {
                let splitLine: [String]?
                let splitLine2 : [String]?

                if $0.releaseDate.contains("."){
                    splitLine = $0.releaseDate.components(separatedBy: ".")
                }else{
                    splitLine = $0.releaseDate.components(separatedBy: "/")
                }
                
                
                if $1.releaseDate.contains("."){
                    splitLine2 = $1.releaseDate.components(separatedBy: ".")
                }else{
                    splitLine2 = $1.releaseDate.components(separatedBy: "/")
                }
                return splitLine![1] < splitLine2![1]
                
            }
            calenderTop.reloadData()
            calenderBottom.reloadData()
        }
        else if sender.selectedSegmentIndex == 1{
            setSneakerArray()

            self.sneakerCalenderTop=sneakerCalenderTop.filter{$0.brand == "Nike"}
            self.sneakerCalenderBottom=sneakerCalenderBottom.filter{$0.brand == "Nike"}
            calenderTop.reloadData()
            calenderBottom.reloadData()
        }
        else if sender.selectedSegmentIndex == 2{
            setSneakerArray()

            self.sneakerCalenderTop=sneakerCalenderTop.filter{$0.brand == "Adidas"}
            self.sneakerCalenderBottom=sneakerCalenderBottom.filter{$0.brand == "Adidas"}
            calenderTop.reloadData()
            calenderBottom.reloadData()
        }
        else if sender.selectedSegmentIndex == 3{
            setSneakerArray()

            self.sneakerCalenderTop=allSneaker.filter{$0.brand == "Puma"}
            self.sneakerCalenderBottom=allSneaker.filter{$0.brand == "Puma"}

            calenderTop.reloadData()
            calenderBottom.reloadData()
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

        /// push the DetailViewController on the stack
        vc?.sneaker = sneakerCalenderTop[indexPath.row]
self.navigationController?.pushViewController(vc!,animated:true)


    }
}

