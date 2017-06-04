//
//  AddEventViewController.swift
//  Spank
//
//  Created by Madushani Lekam Wasam Liyanage on 6/3/17.
//  Copyright © 2017 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseAuth
import FirebaseDatabase
import SnapKit

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}

class AddEventViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, HandleMapSearch {
    
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var penaltyAmoutTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationSearchView: UIView!
    
    
    var resultSearchController:UISearchController? = nil
    var selectedPin:MKPlacemark? = nil
    var pickedLocation: Location?
    var pickedDate: String?
    
    let locationManager = CLLocationManager()
    
    var firebaseRef: FIRDatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create an Event"
        authorization()
        mapView.showsUserLocation = true
        
        let locationSearchTVC = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTVC") as! LocationSearchTableViewController
        resultSearchController = UISearchController(searchResultsController: locationSearchTVC)
        resultSearchController?.searchResultsUpdater = locationSearchTVC
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        locationSearchView.addSubview((resultSearchController?.searchBar)!)
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        locationSearchTVC.mapView = mapView
        locationSearchTVC.handleMapSearchDelegate = self
        firebaseRef = FIRDatabase.database().reference()
        zoomIn()
        
    }
    
    func zoomIn() {
        let userLocation = locationManager.location
        
        let region = MKCoordinateRegionMakeWithDistance(
            (userLocation?.coordinate)!, 2000, 2000)
        
        mapView.setRegion(region, animated: true)
    }
    
    func authorization() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView?.pinTintColor = UIColor.orange
        pinView?.canShowCallout = true
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: .zero, size: smallSquare))
        button.setBackgroundImage(UIImage(named: "pin"), for: .normal)
        button.addTarget(self, action: #selector(getDirections), for: .touchUpInside)
        pinView?.leftCalloutAccessoryView = button
        return pinView
    }
    
    func getDirections(){
        if let selectedPin = selectedPin {
            let mapItem = MKMapItem(placemark: selectedPin)
            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
            mapItem.openInMaps(launchOptions: launchOptions)
        }
    }
    //    @objc(locationManager:didChangeAuthorizationStatus:) func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    //        if status == .authorizedWhenInUse {
    //            locationManager.requestLocation()
    //        }
    //    }
    //
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            print("location:: (location)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }
    
    @IBAction func locationButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        pickedDate = String(describing: datePicker.date)
    }
    
    @IBAction func createTapped(_ sender: UIButton) {
        //40.750789
        //73.988953
        
        pickedLocation = Location(lat: 40.750789, long: 73.988953)
        
        if let name = eventNameTextField.text,
            let penalty = Double(penaltyAmoutTextField.text!),
            let date = pickedDate,
            let location = pickedLocation {
            // let event = Event(name: name, penalty: penalty, date: date, location: location)
            
            let dict = ["name":name, "penalty":penalty, "date": date, "location": ["lat": pickedLocation?.lat, "long": pickedLocation?.long]] as [String : Any]
            firebaseRef?.child("events").childByAutoId().setValue(dict)
            
            
            let alertController = UIAlertController(title: "Successful!", message: "You created an Event", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                self.present(TeamChatroomViewController(), animated: true, completion: nil)
                
                // performSegue(withIdentifier: "mainTabSegue", sender: nil)
            }))
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    }
