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
    var showSneakerList : [Sneaker] = []
   //  var sneakers: [SneakerDetail] = []
   
    
    
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
                    print(article.title)
                print(article.description)

                    self.allSneaker.append(article)
                })
            case .failure(let err):
                print("Failed to fetch courses:", err)
            }
          
        }
        self.calenderTop.reloadData()
        self.calenderBottom.reloadData()
       
        self.showSneakerList=allSneaker

        
    }
    
  
    
    fileprivate func fetchSneaker(completion:@escaping(Result<[Sneaker],Error>)-> Void){
        let urlString = "https://flasksneakerapi.herokuapp.com/news"
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
            self.showSneakerList = allSneaker;
            self.showSneakerList.sort {
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
            self.showSneakerList=allSneaker.filter{$0.brand == "Nike"}
            calenderTop.reloadData()
            calenderBottom.reloadData()
        }
        else if sender.selectedSegmentIndex == 2{
            self.showSneakerList=allSneaker.filter{$0.brand == "Adidas"
            }
            calenderTop.reloadData()
            calenderBottom.reloadData()
        }
        else if sender.selectedSegmentIndex == 3{
            self.showSneakerList=allSneaker.filter{$0.brand == "Puma"}
            calenderTop.reloadData()
            calenderBottom.reloadData()
               }
        
    }
    
}


extension CalenderViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if(collectionView == calenderBottom){
//            return 2
//        }
        //allSneaker.count
        return showSneakerList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SneakerCell", for: indexPath) as! SneakerCollectionViewCell
        // cell.sneaker = allSneaker[indexPath.row]
        if(showSneakerList.count>0){
        cell.sneaker = showSneakerList[indexPath.row]
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
        vc?.sneaker = showSneakerList[indexPath.row]
self.navigationController?.pushViewController(vc!,animated:true)


    }
}

