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
    var activityView = CustomActivityIndicator()
    var customAlert = CustomAlert()
    var refreshView = RefreshView()

    var tableViewRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = .clear
        refreshControl.tintColor = .clear
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        return refreshControl
    }()
    
        @objc func refreshTableView() {
            refreshView.startAnimation()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                self.refreshView.stopAnimation()
                self.tableViewRefreshControl.endRefreshing()
            }
        }
    

    func showAlert(title:String,message:String,type:AlertType){
        DispatchQueue.main.async {
            self.customAlert.delegate = self
            self.customAlert.showAlert(title: title, message: message, alertType: type,view: self.view)

            }
        
    }
    
    func prepareUI() {
        // Adding 'tableViewRefreshControl' to tableView
        tableView.refreshControl = tableViewRefreshControl
        // Getting the nib from bundle
        createRefreshGesture()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        

        ///create background color
        let background = BackgroundColor()
        background.createGradientBackground(view: self.view, colors: nil)
        
        activityView.showLoadingScreen(superview: self.view)
        ///fetch data
        fetchCoursesJSON { (res) in
             switch res {
             case .success(let article):
                 article.forEach({ (article) in
                     self.blogPosts.append(article)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                        self.showAlert(title: "JUST DO IT", message: "View the latest news and breaking news in the sneaker world.", type: .fetch_successful)
                    }
                 })
             case .failure(let err):
                
            print("Failed to fetch courses:", err)
            self.showAlert(title: "E R R O R", message: err.localizedDescription, type: .error)

            
            

            
             }
            DispatchQueue.main.async {
            self.tableView.reloadData()
                self.activityView.stopAnimation(uiView: self.view)
                

            }


         }
        self.tableView.reloadData()
        tableView.refreshControl = tableViewRefreshControl
        createRefreshGesture()


            }
    /// create "Pull to refresh"
    func createRefreshGesture(){
//
//        refreshControl = UIRefreshControl()
//        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
//        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
//        tableView.addSubview(refreshControl)

            if let objOfRefreshView = Bundle.main.loadNibNamed("RefreshView", owner: self, options: nil)?.first as? RefreshView {
                // Initializing the 'refreshView'
                refreshView = objOfRefreshView
                // Giving the frame as per 'tableViewRefreshControl'
                refreshView.frame = tableView.refreshControl!.frame
                // Adding the 'refreshView' to 'tableViewRefreshControl'
                tableView.refreshControl!.addSubview(refreshView)
            }
        
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

extension NewsViewController : AlertDelegate{
    func okTapped(){
        customAlert.remove()
    }
}
