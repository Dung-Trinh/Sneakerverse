//
//  OnboardingViewController.swift
//  SneakerApp
//
//  Created by Dung  on 13.01.20.
//  Copyright © 2020 Dung. All rights reserved.
//

import UIKit

class OnboardingViewController: UIPageViewController {


    enum PageViews: String {
            case guideView1
            case guideView2
            case guideView3
            case guideView4
        }
            
        fileprivate lazy var orderedViewController: [UIViewController] = {
            return [self.getViewController(withIdentifier: PageViews.guideView1.rawValue),
                    self.getViewController(withIdentifier: PageViews.guideView2.rawValue),
                    self.getViewController(withIdentifier: PageViews.guideView3.rawValue),
                    self.getViewController(withIdentifier: PageViews.guideView4.rawValue)]
        }()
        
        fileprivate func getViewController(withIdentifier identifier: String) -> UIViewController
        {
            var vc = (storyboard?.instantiateViewController(withIdentifier: identifier))!
            
            
            return vc
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            self.dataSource = self
            
            if let firstVC = orderedViewController.first {
                setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
            }
        }
        
    @IBAction func getStarted(_ sender: UIButton) {
        performSegue(withIdentifier: "guide_to_mainView", sender: nil)
    }
    
    }
extension OnboardingViewController:UIPageViewControllerDataSource{
    func presentationCount(for: UIPageViewController) -> Int {
        return orderedViewController.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewController.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return nil }
        guard orderedViewController.count > previousIndex else { return nil }
        return orderedViewController[previousIndex]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewController.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < orderedViewController.count else { return nil }
        guard orderedViewController.count > nextIndex else { return nil }
        return orderedViewController[nextIndex]
    }
    
    
}

