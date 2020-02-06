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
    var dataFetcher = BlogPostDataFetcher()
    var logoLoadingScreen : LogoLoadingScreen?


    var tableViewRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = .clear
        refreshControl.tintColor = .clear
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        return refreshControl
    }()
    
        @objc func refreshTableView() {
            refreshView.startAnimation()
            //3 sec delay for animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                
                self.refreshView.stopAnimation()
                self.fetchData(animation: false)
                self.tableView.reloadData()
                self.tableViewRefreshControl.endRefreshing()
            }
            
        }
    

    func showAlert(title:String,message:String,type:AlertType){
        DispatchQueue.main.async {
            self.customAlert.delegate = self
            self.customAlert.showAlert(title: title, message: message, alertType: type,view: self.view)

            }
        
    }
    func fetchData(animation:Bool){
        controll_tabbar(setBool: false)

            logoLoadingScreen = LogoLoadingScreen()
        let group = DispatchGroup()
        group.enter()
        if animation {
                    logoLoadingScreen?.startLoadingAnimation(view: self.view)

        }
        /// queue because waiting for the fetchData function
        DispatchQueue.global(qos: .userInitiated).async {
            self.dataFetcher.fetchBlogPostData()
            group.leave()
            
            if self.dataFetcher.fetchSuccessfull == false{
                self.showAlert(title: "E R R O R", message: "FETCH ERROR", type: .error)
            }else{
                  self.showAlert(title: "JUST DO IT", message: "View the latest news and breaking news in the sneaker world.", type: .fetch_successful)
            }
            
            /// in main queue to refresh the view
              DispatchQueue.main.async {
                self.blogPosts = self.dataFetcher.blogPosts
                self.tableView.reloadData()
                if animation{
                    self.logoLoadingScreen!.remove()
                }
                self.controll_tabbar(setBool: true)

                

            }
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
        fetchData(animation: true)

        tableView.refreshControl = tableViewRefreshControl
        createRefreshGesture()


            }
    /// create "Pull to refresh"
    func createRefreshGesture(){
            if let objOfRefreshView = Bundle.main.loadNibNamed("RefreshView", owner: self, options: nil)?.first as? RefreshView {
                refreshView = objOfRefreshView
                refreshView.frame = tableView.refreshControl!.frame
                tableView.refreshControl!.addSubview(refreshView)
            }
        
    }

    /// function for refreshing
     @objc func refresh(_ sender: Any) {
       
    DispatchQueue.global(qos: .userInitiated).async {
        self.refreshView.startAnimation()

        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.refreshControl.endRefreshing()
            
        })
        self.fetchData(animation: false)
        }
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
    func controll_tabbar(setBool:Bool){
        if let items = tabBarController?.tabBar.items {
                items.forEach { $0.isEnabled = setBool }
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
