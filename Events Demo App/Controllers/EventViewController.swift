//
//  EventViewController.swift
//  Events Demo App
//
//  Created by Daniella Montinola on 12/3/19.
//  Copyright © 2019 Daniella Montinola. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class EventViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Properties
    
    @IBOutlet weak var eventNameTextField: UITextField!
    
    @IBOutlet weak var dateAndTimeTextField: UITextField!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    let datePicker: UIDatePicker = UIDatePicker()
    
        
        // MARK: - Functions
        
        
        @IBAction func discardEventButton(_ sender: UIButton) {
        }
        
        @IBAction func createEventButton(_ sender: UIButton) {
            let event = PFObject(className: "Events")
            
            event["name"] = eventNameTextField.text!
            event["date"] = dateAndTimeTextField.text!
            event["location"] = locationTextField.text!
            event["administrator"] = PFUser.current()!
            
            let imageData = imageView.image!.pngData()
            let file = PFFileObject(data: imageData!)
            
            event["image"] = file
            
            event.saveInBackground { (success, error) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                    print("saved!")
                } else {
                    print("error!")
                }
            }
        
        }
        
        @IBAction func onCameraButton(_ sender: UITapGestureRecognizer) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.sourceType = .camera
            } else {
                picker.sourceType = .photoLibrary
            }
            
            present(picker, animated: true, completion: nil)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.editedImage] as! UIImage
            
            let size = CGSize(width: 300, height: 300)
            let scaledImage = image.af_imageScaled(to: size)
            
            imageView.image = scaledImage
            dismiss(animated: true, completion: nil)
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // user set date
            datePicker.setDate(Date(), animated: false)
            datePicker.datePickerMode = .dateAndTime
            datePicker.addTarget(self, action: #selector(datePickerChanged(datePicker:)), for: .valueChanged)
            
            // tap gesture recognizer to exit date and time picker
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(EventViewController.viewTapped(gestureRecognizer:)))
            
            view.addGestureRecognizer(tapGesture)
            
            dateAndTimeTextField.inputView = datePicker
        }
        
        @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
            view.endEditing(true)
        }
        
        @objc func datePickerChanged(datePicker:UIDatePicker) {
            let selectedDate = datePicker.date
            
            let dateFormatter = DateFormatter()
    //        dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE, MMM dd, yyyy 'T' HH:mm"
            let formattedDateString = dateFormatter.string(from: selectedDate)
    //        view.endEditing(true)
            
            dateAndTimeTextField.text = formattedDateString
        }

}
