//
//  NearbyShopsViewController.swift
//  studylattefinal
//
//  Created by wayne dunlap on 4/15/18.
//  Copyright © 2018 Samuel Higgs. All rights reserved.
//

import UIKit
import MapKit

class NearbyShopsViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var MapSegControl: UISegmentedControl!



    @IBOutlet weak var tableView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    var currentOption = 0
    
    var locationManager: CLLocationManager?
    //The range (meter) of how much we want to see arround the user's location
    let distanceSpan: Double = 500
    
    override func viewDidLoad() {
        self.tableView.isHidden = true
        super.viewDidLoad()
        
        
        self.locationManager = CLLocationManager()
        if let locationManager = self.locationManager {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.requestAlwaysAuthorization()
            locationManager.distanceFilter = 50
            locationManager.startUpdatingLocation()
        }
        

        // Do any additional setup after loading the view.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        if let mapView = self.mapView {
            let region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, self.distanceSpan, self.distanceSpan)
            mapView.setRegion(region, animated: true)
            mapView.showsUserLocation = true
        }
    }

    @IBAction func mapSegControlAction(_ sender: UISegmentedControl) {
        self.currentOption = self.MapSegControl.selectedSegmentIndex
        switch MapSegControl.selectedSegmentIndex {
        case 0:
            tableView.isHidden = true
        case 1:
            tableView.isHidden = false
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
