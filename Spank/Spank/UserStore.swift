//
//  UserStore.swift
//  Spank
//
//  Created by Madushani Lekam Wasam Liyanage on 6/3/17.
//  Copyright © 2017 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import Foundation
import FirebaseDatabase

class UserStore {
    
    var databaseRef = FIRDatabase.database().reference()
    
    func getUser(id: String, completion: @escaping (User) -> Void) {
        
        self.databaseRef.child("users").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var userObject: User?
            let id = snapshot.key
            
            if let name = snapshot.childSnapshot(forPath: "name").value as? String,
                let email = snapshot.childSnapshot(forPath: "email").value as? String,
            let teams = snapshot.childSnapshot(forPath: "teams").value as? [String] {
                
                userObject = User(id: id,
                                  name: name,
                                  email: email,
                                  teams: teams
                    
                )
            }
            if let user = userObject {
                completion(user)
                return
                
            }
            
        })
    }
    
}
