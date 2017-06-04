//
//  User.swift
//  Spank
//
//  Created by Madushani Lekam Wasam Liyanage on 6/3/17.
//  Copyright © 2017 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import Foundation

class User {
    
    let id: String
    let name: String
    let email: String
    let teams: [String]
    
    init(id: String, name: String, email: String, teams: [String]) {
        self.id = id
        self.name = name
        self.email = email
        self.teams = teams
    }
    
}
