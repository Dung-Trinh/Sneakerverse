//
//  MapViewController.swift
//  SneakerApp
//
//  Created by Dung  on 14.01.20.
//  Copyright © 2020 Dung. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationTV: UITableView!
    
    var allLocations: [MapLocation] = []
    var shownLocation:[MapLocation] = []
    fileprivate let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
        return manager
    }()


    func currentLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if #available(iOS 11.0, *) {
           locationManager.showsBackgroundLocationIndicator = true
        } else {
           // Fallback on earlier versions
        }
        locationManager.startUpdatingLocation()
     }
     
    /// create pins
    func createAnnotation(title:String,latitude:Double,longitude :Double){
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        self.mapView.addAnnotation(annotation)
    }
    
    ///display the map of germany
    @IBAction func zoomOut(_ sender: UIButton) {
        let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(51.048463, 10.295628)
            let span = MKCoordinateSpan(latitudeDelta: 7, longitudeDelta: 7)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            self.mapView.setRegion(region, animated: true)

    }
    
    @IBAction func showMyLocation(_ sender: UIButton) {
        self.mapView.showsUserLocation = true
        self.mapView.showsCompass = true
        self.mapView.showsScale = true
        currentLocation()
    }
    
    func fetchJsonData(){
        do{
            let url = Bundle.main.url(forResource: "locationPins", withExtension: "json")
            
            let jsonData = try Data(contentsOf: url!)
            let locationPins = try JSONDecoder().decode([MapLocation].self, from: jsonData)
            
            for location in locationPins{
                allLocations.append(MapLocation(name: location.name, latitude: location.latitude, longitude: location.longitude, logoName: location.logoName, locationType: location.locationType,address: location.address))
            }
            
        }catch let err{
            print(err)
        }
    }
    func deleteLoctions(){
        let annotations = self.mapView.annotations
        self.mapView.removeAnnotations(annotations)
    }
    /// sort locations
    @IBAction func switchCategory(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            shownLocation = allLocations.filter{$0.locationType=="store"}
            locationTV.reloadData()
            break
        case 1:
            shownLocation = allLocations.filter{$0.locationType=="event"}
            locationTV.reloadData()
        default: break
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationTV.dataSource = self
        locationTV.delegate = self
        
        fetchJsonData()
        for i in allLocations{
            createAnnotation(title: i.name, latitude: i.latitude, longitude: i.longitude)
        }
        locationTV.reloadData()
        shownLocation = allLocations.filter{$0.locationType=="store"}
    }
    


}


extension MapViewController:UITableViewDataSource{
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
        return shownLocation.count
        
    }
    
    /// fill the cell with content
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "storeCell",for: indexPath) as! MapTableViewCell
        cell.modell = shownLocation[indexPath.row]
        
        
        return cell
    }
 
    
}
extension MapViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
         if currentCell is MapTableViewCell {
             let cell = currentCell as! MapTableViewCell         
            let model_latitude = cell.modell?.latitude
            let model_longitude = cell.modell?.longitude
            let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(model_latitude!, model_longitude!)
            let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            self.mapView.setRegion(region, animated: true)
        
     }
    }
}
extension MapViewController: CLLocationManagerDelegate {
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        let currentLocation = location.coordinate
        let coordinateRegion = MKCoordinateRegion(center: currentLocation, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(coordinateRegion, animated: true)
        locationManager.stopUpdatingLocation()
     }
     
     func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
     }
}

