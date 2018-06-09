//
//  EditVC.swift
//  Notes
//
//  Created by Ajo M Varghese on 30/05/18.
//  Copyright © 2018 Ajo M Varghese. All rights reserved.
//

import UIKit
import FirebaseDatabase

class EditVC: UIViewController {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var getTitle = String()
    var getDescription = String()
    
    var postRef : DatabaseReference!
    
    @IBAction func savePressed(_ sender: Any) {
        if titleField.text != "" {
            postRef = Database.database().reference().child("notes").childByAutoId()
            
            let postObject = [
                "titleText": titleField.text!,
                "descriptionText": descriptionTextView.text,
                "timeStamp": [".sv": "timestamp"]
            ] as [String: Any]
            
            postRef.setValue(postObject, withCompletionBlock: {error, ref in
                if error == nil {
                    _ = self.navigationController?.popViewController(animated: true)
                } else {
                    //handle error
                }
            })
        }
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleField.text! = getTitle
        descriptionTextView.text! = getDescription
    }
}
