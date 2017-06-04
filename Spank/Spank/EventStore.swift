//
//  EventStore.swift
//  Spank
//
//  Created by Madushani Lekam Wasam Liyanage on 6/3/17.
//  Copyright © 2017 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import Foundation
import FirebaseDatabase

class EventStore {
    
    var databaseRef = FIRDatabase.database().reference()
    
    func getEvent(id: String, completion: @escaping (Event) -> Void) {
        
        self.databaseRef.child("events").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var eventObject: Event?
            let id = snapshot.key
            
            if let name = snapshot.childSnapshot(forPath: "name").value as? String,
                let penalty = snapshot.childSnapshot(forPath: "penalty").value as? Double,
                let date = snapshot.childSnapshot(forPath: "date").value as? String,
                let locationDict = snapshot.childSnapshot(forPath: "location").value as? [String: Any],
                let lat = locationDict["lat"] as? Double,
                let long = locationDict["long"] as? Double {
                let location = Location(lat: lat, long: long)
                
                eventObject = Event(id: id, name: name, penalty: penalty, date: date, location: location)
            }
            if let event = eventObject {
                completion(event)
                return
                
            }
            
        })
    }
    
    
}
