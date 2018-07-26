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
    var titleToPass = String()
    var descriptionToPass = String()
    var indexToPass = NSInteger()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        postRef = Database.database().reference()
        
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        
        readNotes()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    //Mark: Read Firebase
    func readNotes()  {

        refHandle = postRef?.child("notes").observe(.value, with: { snapshot in

            var tempNotes = [Notes]()

            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                let notesDict = childSnapshot.value as? [String: Any],
                let titleText = notesDict["titleText"] as? String,
                let descriptionText = notesDict["descriptionText"] as? String,
                    let timeStamp = notesDict["timeStamp"] as? Double {                    
                    let note = Notes(titletext: titleText, descriptiontext: descriptionText, timestamp: timeStamp)
                    tempNotes.append(note)
                }
            }
            self.notes = tempNotes
            self.tableView.reloadData()
        })
    }
    
    //Mark: TableView Setup
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell") as? NotesCell
        cell?.setLabels(note: notes[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell : UITableViewCell = tableView.cellForRow(at: indexPath)! as! NotesCell
        selectedCell.contentView.backgroundColor = UIColor(displayP3Red: 250/255.0, green: 128/255.0, blue: 114/255.0, alpha: 1.0)
        
        indexToPass = indexPath.row
        
        if selectedCell.isSelected == true {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    //Mark: Passing Data and Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditVC" {
            let selectedCell = sender as! NotesCell
            let destionationVC = segue.destination as! EditVC
            destionationVC.passedTitle = selectedCell.titleLabel.text!
            destionationVC.passedDescription = selectedCell.descriptionLabel.text!
            destionationVC.indexPath = indexToPass
        }
    }
}
