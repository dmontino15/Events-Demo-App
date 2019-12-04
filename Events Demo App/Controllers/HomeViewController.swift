//
//  HomeViewController.swift
//  Events Demo App
//
//  Created by Daniella Montinola on 12/3/19.
//  Copyright © 2019 Daniella Montinola. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: - Properties
       
       @IBOutlet weak var tableView: UITableView!
       
       // i need to attach the table view to data
       // create events and it is going to be equal to an array of PFObject
       // so now i have an array of events
       var events = [PFObject]()
    
    
    
    // MARK: = Functions
    
    @IBAction func onLogoutButton(_ sender: Any) {
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        delegate.window?.rootViewController = loginViewController
        PFUser.logOut()
    
    }
    
    
    @IBAction func createNewEvent(_ sender: UIButton) {
        print("Create new event page!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // we're creating this viewDidAppear because after we create an event, we want to reload the table right away to show that new event
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // query - so now this is parse
        // it starts off by just creating the query
        // so let query equal to our class name Events
        let query = PFQuery(className: "Events")
        query.whereKey("administrator", equalTo: PFUser.current()!)
        query.includeKey("date")
        query.limit = 20
        
        // so now go look for the events
        query.findObjectsInBackground { (events, error) in
            // upon getting the events back; if events is not equal to nil, so you found some events
            if events != nil {
                // put them in your empty array; set the empty events array (variable above) equal to these events from the parse api
                self.events = events!
                // this line of code is very important because it populates your table and shows your data
                self.tableView.reloadData()
            }
        }
    }
     
    // in order to work with tableView you will need these 2 functions --it's required
    
    // asking you for the number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    // what should this cell be/have what kind of data/look like
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventCell
        
        let event = events[indexPath.row]
        let eventDate = event["date"] as! String
        cell.eventLabel.text = eventDate
        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    //     Find the selected event
        let selectedCell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: selectedCell)!
        let selectedEvent = events[indexPath.row]
        
    //     pass the selected event to the match details view controller
        let eventDetailsViewController = segue.destination as! EventDetailsViewController
        eventDetailsViewController.event = selectedEvent
    }
  
}
