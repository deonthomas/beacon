//
//  ViewController.swift
//  ibeacon.learning
//
//  Created by Deon Thomas on 2015/06/12.
//  Copyright (c) 2015 Deon Thomas. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class ViewController: UIViewController , CLLocationManagerDelegate{

    @IBOutlet weak var label: UILabel!
    
    let manager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "61687109-905F-4436-91F8-E602F514C96D"), identifier:"bluecats")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        manager.delegate = self
        
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) {
            manager.requestWhenInUseAuthorization()
        }
        
        manager.startRangingBeaconsInRegion(region)
       manager.startMonitoringForRegion(region)
        
        if CLLocationManager.locationServicesEnabled()
        {
            manager.startUpdatingLocation()
   
        }
    }
    
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
         label.text = "entered"
    }
    
    func locationManager(manager: CLLocationManager!, didVisit visit: CLVisit!) {
        label.text = toString(visit)
    }
    

    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
        if (knownBeacons.count > 0) {
            let closestBeacon = knownBeacons[0] as! CLBeacon
            label.text = closestBeacon.description
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus  status: CLAuthorizationStatus ){
        if  status == .AuthorizedWhenInUse {
            manager.startUpdatingLocation()
            manager.startMonitoringVisits()
        }
        
    }
}

