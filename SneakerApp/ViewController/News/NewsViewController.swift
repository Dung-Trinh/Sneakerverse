//
//  NewsViewController.swift
//  SneakerApp
//
//  Created by Dung  on 22.11.19.
//  Copyright © 2019 Dung. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var blogPosts : [BlogPost] = []
    var gradientLayer: CAGradientLayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.dataSource = self
        let newBlogPost = BlogPost(imageURL: "https://blogmedia.evbstatic.com/wp-content/uploads/wpmulti/sites/14/2019/03/sneakercon.jpg", title: "SNEAKER CON")
       
        blogPosts.append(newBlogPost)

        tableView.delegate = self
        createGradientBackground()
        
        fetchCoursesJSON { (res) in
             switch res {
             case .success(let article):
                 article.forEach({ (article) in
                     print(article.title)
                     print(article.imageURL)
                     self.blogPosts.append(article)
                 })
             case .failure(let err):
                 print("Failed to fetch courses:", err)
             }
            self.tableView.reloadData()
         }
 
            }
    
  
           
            fileprivate func fetchCoursesJSON(completion: @escaping (Result<[BlogPost], Error>) -> ()) {
                let urlString = "http://127.0.0.1:5000/news"
                guard let url = URL(string: urlString) else { return }
                
                URLSession.shared.dataTask(with: url) { (data, resp, err) in
                    
                    if let err = err {
                        completion(.failure(err))
                        return
                    }
                    
                    // successful
                    do {
                        let article = try JSONDecoder().decode([BlogPost].self, from: data!)
                        completion(.success(article))
        //                completion(courses, nil)
                        
                    } catch let jsonError {
                        completion(.failure(jsonError))
        //                completion(nil, jsonError)
                    }
                    
                    
                }.resume()
            }
    
    func createGradientBackground() {
        gradientLayer = CAGradientLayer()
     
        gradientLayer.frame = self.view.bounds
        let blau = UIColor(red:0.24, green:0.28, blue:0.50, alpha:1.0).cgColor
        let pink = UIColor(red:0.72, green:0.31, blue:0.59, alpha:1.0).cgColor
        let blau2 = UIColor(red:0.24, green:0.28, blue:0.50, alpha:1.0).cgColor

        gradientLayer.colors = [pink,blau,blau2]
     
        self.view.layer.addSublayer(gradientLayer)
        self.view.layer.insertSublayer(gradientLayer, at: 0)

    }


}
extension NewsViewController:UITableViewDataSource{
    
    /// Anzahl der Zellen
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //blogPosts.count
        return 3
    }
    
    /// befüllen der Zellen
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "blogpostCell") as! BlogPostTableViewCell
            
        cell.modell = blogPosts[0]
        cell.layer.masksToBounds = false


        
        
        return cell
    }
 
    
}
    

extension NewsViewController: UITableViewDelegate{
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
             let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
             if currentCell is BlogPostTableViewCell {
                 let cell = currentCell as! BlogPostTableViewCell
                
             }
            
         }
   
    
    }
    
    

