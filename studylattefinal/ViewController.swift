//
//  ViewController.swift
//  studylattefinal
//
//  Created by Samuel Higgs on 4/10/18.
//  Copyright © 2018 Samuel Higgs. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

func applicationDidBecomeActive(application: UIApplication) {
    // Call the 'activate' method to log an app event for use
    // in analytics and advertising reporting.
    AppEventsLogger.activate(application)
    // ...
}

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
        
        view.addSubview(loginButton)
        
        self.imageView.image = UIImage.init(named: "StudyWithSucculents")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

