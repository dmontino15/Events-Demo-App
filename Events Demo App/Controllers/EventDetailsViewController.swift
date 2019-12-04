//
//  EventDetailsViewController.swift
//  Events Demo App
//
//  Created by Daniella Montinola on 12/3/19.
//  Copyright © 2019 Daniella Montinola. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class EventDetailsViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var userProfileView: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var event: PFObject?
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentEvent = event {
        eventNameLabel.text = currentEvent["name"] as? String
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
