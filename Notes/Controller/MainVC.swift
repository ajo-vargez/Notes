//
//  ViewController.swift
//  Notes
//
//  Created by Ajo M Varghese on 30/05/18.
//  Copyright © 2018 Ajo M Varghese. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tableView.rowHeight = 102
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell") as? NotesCell
        cell?.titleLabel.text = "My First Note"
        cell?.detailsLabel.text = "Detected a case where constraints ambiguously suggest a height of zero for a tableview cell's content view."
        cell?.timeLabel.text = "12:48"
        return cell!
    }
    
}

