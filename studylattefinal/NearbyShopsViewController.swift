//
//  NearbyShopsViewController.swift
//  studylattefinal
//
//  Created by wayne dunlap on 4/15/18.
//  Copyright © 2018 Samuel Higgs. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark, firstTime:Bool)
}
class MyPointAnnotation : MKPointAnnotation {
    var pinTintColor: UIColor?
}

class NearbyShopsViewController: UIViewController, CLLocationManagerDelegate {
    
    var selectedPin:MKPlacemark? = nil
    
    @IBOutlet weak var MapSegControl: UISegmentedControl!



    @IBOutlet weak var tableView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    var resultSearchController:UISearchController? = nil
    var currentOption = 0
    
    var locationManager: CLLocationManager?
    //The range (meter) of how much we want to see arround the user's location
    let distanceSpan: Double = 500
    
    override func viewDidLoad() {
        self.tableView.isHidden = false
        super.viewDidLoad()
        self.locationManager = CLLocationManager()
        if let locationManager = self.locationManager {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.requestAlwaysAuthorization()
            locationManager.distanceFilter = 50
            locationManager.startUpdatingLocation()
        }
        
        
        self.displayNearbyShops()

        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        let span = MKCoordinateSpanMake(0.03, 0.03)
        let currentLocation = self.locationManager?.location?.coordinate
        let region = MKCoordinateRegion(center: currentLocation!, span: span)
        mapView.setRegion(region, animated: true)
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
        
        addMapTrackingButton()

        // Do any additional setup after loading the view.

    }
    
    func addMapTrackingButton(){
        let image = UIImage(named: "navicon") as UIImage?
        let button   = UIButton(type: UIButtonType.custom) as UIButton
        button.frame = CGRect(origin: CGPoint(x:15, y: 15), size: CGSize(width: 35, height: 35))
        button.setImage(image, for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(NearbyShopsViewController.centerMapOnUserButtonClicked), for:.touchUpInside)
        mapView.addSubview(button)
    }
    
    @objc func centerMapOnUserButtonClicked() {
        mapView.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.02, 0.02)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "myAnnotation") as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myAnnotation")
        } else {
            annotationView?.annotation = annotation
        }
        
        if let annotation = annotation as? MyPointAnnotation {
            annotationView?.pinTintColor = annotation.pinTintColor
        }
        
        return annotationView
    }
    
    func displayNearbyShops() {
        //Create object representing a search query for coffee shops
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "Coffee"
        
        //Set search area around current location
        let currentLocation = self.locationManager?.location?.coordinate
        let searchArea = MKCoordinateRegion(center: currentLocation!, span: MKCoordinateSpanMake(0.05, 0.05))
        request.region = searchArea
        
        //Search for the created query
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else {
                print("There was an error searching for: \(request.naturalLanguageQuery) error: \(error)")
                return
            }
            
            //Drop a pin on each result
            for item in response.mapItems {
                let firstTime:Bool = true
                self.dropPinZoomIn(placemark: item.placemark, firstTime: firstTime)
            }
        }
        
        
    }

    @IBAction func mapSegControlAction(_ sender: UISegmentedControl) {
        self.currentOption = self.MapSegControl.selectedSegmentIndex
        switch MapSegControl.selectedSegmentIndex {
        case 0:
            tableView.isHidden = false
        case 1:
            tableView.isHidden = true
        default:
            break;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//For dropping a pin on each search result
extension NearbyShopsViewController: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark, firstTime:Bool){
        // cache the pin
        mapView.delegate = self as? MKMapViewDelegate
        selectedPin = placemark
        // clear existing pins
        //mapView.removeAnnotations(mapView.annotations)
        let annotation = MyPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if (annotation.title?.contains("H"))!{
            
            annotation.pinTintColor = .green
            
        }
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city), \(state)"
        }
        mapView.addAnnotation(annotation)
        
        //Centers the map view around the dropped pin
        if firstTime == false{
            let span = MKCoordinateSpanMake(0.02, 0.02)
            let region = MKCoordinateRegionMake(placemark.coordinate, span)
            mapView.setRegion(region, animated: true)
        }

        
    
    }
}
