//
//  TeamsViewController.swift
//  Spank
//
//  Created by Madushani Lekam Wasam Liyanage on 6/3/17.
//  Copyright © 2017 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit
import FirebaseAuth

class TeamsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!

    var teams: [Team]?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Your Teams"
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    func getTeams() {
        //let currentUser =
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard teams != nil else {
            return 1
        }
        return teams!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath)
        
        let selectedItem = teams?[indexPath.row]
        cell.textLabel?.text = selectedItem?.name
        

        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
