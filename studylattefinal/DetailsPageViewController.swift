//
//  DetailsPageViewController.swift
//  studylattefinal
//
//  Created by Shayan Khan on 5/3/18.
//  Copyright © 2018 Samuel Higgs. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

// Creates array for Favorites list
var favList:[MKMapItem] = []

class DetailsPageViewController: UIViewController {
    
    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var isOpenLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func appendToFavArray(_ sender: Any) {
        // append the current label and location to favorites list
        if (!favList.contains(shop!)) {
            favList.append(shop!)
            print(favList)
            print("BREAK")
        }
    }
    
        var shop:MKMapItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        populateUI()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populateUI() {
        if let shop = shop {
            shopName.text = shop.name
            addressLabel.text = parseAddress(selectedItem: shop.placemark)
            self.title = shop.name
        }
    }
    
    func parseAddress(selectedItem:MKPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        return addressLine
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
