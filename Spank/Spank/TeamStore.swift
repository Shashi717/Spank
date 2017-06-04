//
//  TeamStore.swift
//  Spank
//
//  Created by Madushani Lekam Wasam Liyanage on 6/3/17.
//  Copyright © 2017 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import Foundation
import FirebaseDatabase

class TeamStore {
    var databaseRef = FIRDatabase.database().reference()
    let userStore = UserStore()
    
    func getUser(id: String, completion: @escaping (Team) -> Void) {
        
        self.databaseRef.child("teams").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var teamObject: Team?
            let id = snapshot.key
            
            if let name = snapshot.childSnapshot(forPath: "name").value as? String,
                let event = snapshot.childSnapshot(forPath: "event").value as? String,
                let memberIds = snapshot.childSnapshot(forPath: "members").value as? [String] {
                var members: [User] = []
                
                for memberId in memberIds {
                    self.userStore.getUser(id: memberId, completion: { (user) in
                        members.append(user)
                    })
                }
                teamObject = Team(id: id, name: name, members: members, event: event)
                
            }
            if let team = teamObject {
                completion(team)
                return
                
            }
            
        })
    }
    
}
