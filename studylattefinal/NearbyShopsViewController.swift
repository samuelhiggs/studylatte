//
//  NearbyShopsViewController.swift
//  studylattefinal
//
//  Created by wayne dunlap on 4/15/18.
//  Copyright © 2018 Samuel Higgs. All rights reserved.
//

import UIKit
import MapKit

class NearbyShopsViewController: UIViewController {
    
    @IBOutlet weak var MapSegControl: UISegmentedControl!



    @IBOutlet weak var tableView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    var currentOption = 0
    
    override func viewDidLoad() {
        self.tableView.isHidden = true
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
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
