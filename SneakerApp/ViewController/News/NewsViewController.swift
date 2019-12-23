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
    
    var refreshControl: UIRefreshControl!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        background.createGradientBackground(view: self.view)
        tableView.dataSource = self

        tableView.delegate = self
        
        fetchCoursesJSON { (res) in
             switch res {
             case .success(let article):
                 article.forEach({ (article) in
                     self.blogPosts.append(article)
                 })
             case .failure(let err):
            print("Failed to fetch courses:", err)
             }
            DispatchQueue.main.async {
            self.tableView.reloadData()
            }
         }
        self.tableView.reloadData()
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
            }


     @objc func refresh(_ sender: Any) {
        tableView.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.refreshControl.endRefreshing()
        })

        }
  
           
            fileprivate func fetchCoursesJSON(completion: @escaping (Result<[BlogPost], Error>) -> ()) {
                let urlString = "https://flasksneakerapi.herokuapp.com/blog"
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
    
    // MARK: - Tranfer the BlogPost to NewsDetail2VC
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let dest = segue.destination as? NewsDetailViewController, let cell = sender as? BlogPostTableViewCell, let indexPath = tableView.indexPath(for: cell){
            dest.blogPost = blogPosts[indexPath.row]
        }
       }



}
extension NewsViewController:UITableViewDataSource{
    
    /// number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //blogPosts.count
        return blogPosts.count
        
    }
    
    /// fill the cell with content
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "blogpostCell",for: indexPath) as! BlogPostTableViewCell
            
        cell.modell = blogPosts[indexPath.row]
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


    

