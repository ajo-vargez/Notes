//
//  EditVC.swift
//  Notes
//
//  Created by Ajo M Varghese on 30/05/18.
//  Copyright © 2018 Ajo M Varghese. All rights reserved.
//

import UIKit
import FirebaseDatabase

class EditVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    // MARK : - Declaration
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var passedTitle = String()
    var passedDescription = String()
    
    var postRef : DatabaseReference!
    var keyArray : [String] = []
    var indexPath = NSInteger()
    
    @IBAction func savePressed(_ sender: Any) {
        if titleField.text != "" {
            let ref = postRef.child("notes").childByAutoId()
            
            let postObject = [
                "titleText": titleField.text!,
                "descriptionText": descriptionTextView.text,
                "timeStamp": [".sv": "timestamp"]
            ] as [String: Any]
            
            ref.setValue(postObject, withCompletionBlock: {error, ref in
                if error == nil {
                    _ = self.navigationController?.popViewController(animated: true)
                } else {
                    //handle error
                }
            })
        }
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        generateKeys()
        
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.postRef.child("notes").child(self.keyArray[self.indexPath]).removeValue()
            self.keyArray = []
        }
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK : - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postRef = Database.database().reference()
        
        titleField.delegate = self
        descriptionTextView.delegate = self
        
        titleField.text! = passedTitle
        descriptionTextView.text! = passedDescription
    }
    
    func generateKeys() {
        postRef.child("notes").observe(.value) { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let key = snap.key
                self.keyArray.append(key)
            }
        }
    }
    
    // MARK : - Keyboard Manipulation
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            descriptionTextView.resignFirstResponder()
            return false
        }
        return true
    }
}
