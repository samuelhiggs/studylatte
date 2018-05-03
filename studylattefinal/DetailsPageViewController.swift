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
    
    var shop:MKMapItem?
    
    @IBAction func appendToFavArray(_ sender: Any) {
        // append the current label and location to favorites list
        if (!favList.contains(shop!)) {
            favList.append(shop!)
            print(favList)
            print("BREAK")
        }
    }
    
    
    
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
            self.title = shop.name
        }
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
