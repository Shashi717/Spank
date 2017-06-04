//
//  Team.swift
//  Spank
//
//  Created by Madushani Lekam Wasam Liyanage on 6/3/17.
//  Copyright © 2017 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import Foundation

class Team {
    
    let id: String
    let name: String
    let members: [User]
    let event: String
    
    init(id: String, name: String, members: [User], event: String) {
        self.id = id
        self.name = name
        self.members = members
        self.event = event
    }
    
}
