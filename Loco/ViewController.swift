//
//  ViewController.swift
//  Loco
//
//  Created by 赤堀雅司 on 11/8/19.
//  Copyright © 2019 赤堀雅司. All rights reserved.
//
import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: 35.658034, longitude: 139.701636, zoom: 18.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 35.658034, longitude: 139.701636)
        marker.title = "渋谷駅"
        marker.snippet = "東京都渋谷区道玄坂一丁目"
        marker.map = mapView
        Alamofire.request("https://map.yahooapis.jp/search/local/V1/localSearch?cid=d8a23e9e64a4c817227ab09858bc1330&lat=35.658034&lon=139.701636&dist=0.5&query=%E3%83%A9%E3%83%BC%E3%83%A1%E3%83%B3&appid=dj00aiZpPVNKMVlLc2IxUFRzaCZzPWNvbnN1bWVyc2VjcmV0Jng9OTg-&output=json").responseJSON { response in
            
            if let jsonObject = response.result.value {
                let json = JSON(jsonObject)
                let features = json["Feature"]
                
                for(_,subjson):(String,JSON) in features{
                    let name = subjson["Name"].stringValue
                    let address = subjson["Property"]["Address"].stringValue
                    let coodinates = subjson["Geometry"]["Coordinates"].stringValue
                    
                    let coodinatesArray = coodinates.split(separator: ",")
                    let lat = coodinatesArray[1]
                    let lon = coodinatesArray[0]
                    
                    let latdouble = Double(lat)
                    let londouble = Double(lon)
                    
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: latdouble!, longitude: londouble!)
                    marker.title = name
                    marker.snippet = address
                    marker.map = mapView
                    
                    
                    
                    
                    
                }
            }
            
            
        }
    }

        // Do any additional setup after loading the view.



}

