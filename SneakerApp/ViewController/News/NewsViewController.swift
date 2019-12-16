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
    var background = BackgroundColor()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        background.createGradientBackground(view: self.view)
        tableView.dataSource = self
        let newBlogPost = BlogPost(imageURL: "https://blogmedia.evbstatic.com/wp-content/uploads/wpmulti/sites/14/2019/03/sneakercon.jpg", title: "SNEAKER CON")
       
        blogPosts.append(newBlogPost)

        tableView.delegate = self
        
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
            DispatchQueue.main.async {
            self.tableView.reloadData()
            }
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
    



}
extension NewsViewController:UITableViewDataSource{
    
    /// number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //blogPosts.count
        return 3
    }
    
    /// fill the cell with content
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
    
    

