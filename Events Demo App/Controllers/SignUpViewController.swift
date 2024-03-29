//
//  SignUpViewController.swift
//  Events Demo App
//
//  Created by Daniella Montinola on 12/2/19.
//  Copyright © 2019 Daniella Montinola. All rights reserved.
//

import UIKit
import Parse


class SignUpViewController: UIViewController {

    
    // MARK: - Properties

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    // MARK: - FUNCTIONS

    @IBAction func onSignup(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        user.email = emailField.text

        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "signupSegue", sender: nil)
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
