//
//  ViewController.swift
//  Notes
//
//  Created by Ajo M Varghese on 30/05/18.
//  Copyright © 2018 Ajo M Varghese. All rights reserved.
//

import UIKit
import Firebase

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var notes = [Notes]()
    var refHandle : DatabaseHandle?
    var postRef : DatabaseReference?
    var titl = [String]()
    var des = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        postRef = Database.database().reference()
        
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        
        readNotes()
    }
    
    //Mark: Read Firebase
    func readNotes()  {
//        let  postRef = Database.database().reference().child("notes")
//
//        postRef.observe(.value, with: { snapshot in
//
//            var tempNotes = [Notes]()
//
//            for child in snapshot.children {
//                if let childSnapshot = child as? DataSnapshot,
//                let dict = childSnapshot.value as? [String: Any],
//                let title = dict["title"] as? String,
//                let description = dict["description"] as? String,
//                    let timestamp = dict["timeStamp"] as? Double {
//
//                    let note = Notes(titleText: title, descriptionText: description, time: timestamp)
//                    tempNotes.append(note)
//                }
//            }
//            self.notes = tempNotes
//            self.tableView.reloadData()
//        })
        
        refHandle = postRef?.child("notes").observe(.value, with: { (snapshot) in
            if let notesDict = snapshot.value as? [String: AnyObject] {
                
                print(notesDict)
             
               let note = Notes()
//
//                note.setValuesForKeys(notesDict)
//                self.notes.append(note)
                
                let titleText = notesDict["titleText"] as? String
                let descriptionText = notesDict["descriptionText"] as? String
                let timeStamp = notesDict["timeStamp"] as? Double
                
                
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
        
    }
    
    //Mark: TableView Setup
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell") as? NotesCell
       //cell?.set(note: notes[indexPath.row])
        cell?.titleLabel.text = notes[indexPath.row].titleText
        cell?.descriptionLabel.text = notes[indexPath.row].descriptionText
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let destinationViewController = storyboard.instantiateViewController(withIdentifier: "EditVC") as? EditVC
//
//
//        self.navigationController?.pushViewController(destinationViewController!, animated: true)
        
        performSegue(withIdentifier: "EditVC", sender: self)
    }
}
