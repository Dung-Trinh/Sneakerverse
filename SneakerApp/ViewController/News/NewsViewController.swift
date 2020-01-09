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
    var refreshControl: UIRefreshControl!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        createRefreshGesture()
        tableView.dataSource = self
        tableView.delegate = self
        
        ///create background color
        let background = BackgroundColor()
        background.createGradientBackground(view: self.view)
        
        
        ///fetch data
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
        

            }
    /// create "Pull to refresh"
    func createRefreshGesture(){
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    /// function for refreshing
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
    /// animation if the cell is displayed
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha=0
        UIView.animate(withDuration: 0.4, animations: {
            cell.alpha=1
        })
        
        cell.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 0.6) {
            cell.transform = CGAffineTransform.identity
        }
    }
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
