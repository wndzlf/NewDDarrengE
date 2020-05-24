//
//  ViewController.swift
//  NewDDarrengE
//
//  Created by admin on 2020/05/22.
//  Copyright © 2020 wndzlf. All rights reserved.
//

import UIKit
import NMapsMap

class MainViewController: UIViewController {
    @IBOutlet weak var mapView: NMFMapView?
    
    private let currentZoomLevelBicycleAPI: BicycleAPIManager = BicycleAPI()
    private let markerManager = MarkerManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let currentZoomLevel = mapView?.zoomLevel else { return }
        let currentPosition = LatLng(lat: 37.3592, lng: 127.1048)
        
        let currentLocation = CurrentLocationInfo(currentZoomLevel: currentZoomLevel, currentPositon: currentPosition)
        
        self.currentZoomLevelBicycleAPI.requestCurrentZoomLevelBicycle(currentLocation) { bicycleInfos in
            print("finish")
        }
        //self.markerManager.markerInfo(bicycleInfo: bicycleInfos, mapView: mapView)
    }
}

struct CurrentLocationInfo {
    var currentZoomLevel: Double
    var currentPositon: LatLng
}

struct LatLng {
    var lat: Double
    var lng: Double
}

struct MarkerManager {
    /*
    func markerInfo(bicycleInfo: [BicycleInfo], mapView: NMFMapView?) {
        _ = bicycleInfo.map {
            let marker = NMFMarker()
            let latlng = LatLng(lat: $0.stationLatitude, lng: $0.stationLongitude)
            marker.position = NMGLatLng(lat: latlng.lat, lng: latlng.lng)
            marker.mapView = mapView
            marker.iconImage = NMF_MARKER_IMAGE_PINK
        }
    }
    */
}

protocol BicycleAPIManager: AnyObject {
    func requestCurrentZoomLevelBicycle(_ currentInfo: CurrentLocationInfo, completion: @escaping ([BicycleInfo]) -> Void)
}

class BicycleAPI: BicycleAPIManager {
    private let baseURLString: String = "http://openapi.seoul.go.kr:8088"
    private let clientKey: String = "6269776666776e6437377851747a46"
    private let requestType: String = "json"
    private let serviceType: String = "bikeList"
    private let startIndex: Int = 30
    private let endIndex: Int = 50
    
    enum requestError: Error {
        case cannotCreateRequestURL
    }
    
    private func initBaseURL() throws -> URL {
        let requestURLString = "\(baseURLString)/\(clientKey)/\(requestType)/\(serviceType)/\(startIndex)/\(endIndex)"
        
        if let requestURL = URL(string: requestURLString) {
            return requestURL
        }
        
        throw requestError.cannotCreateRequestURL
    }
    
    func requestCurrentZoomLevelBicycle(_ currentInfo: CurrentLocationInfo, completion: @escaping ([BicycleInfo]) -> Void) {
        do {
            let url = try self.initBaseURL()
            
            print("456")
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                let decoder = JSONDecoder()
                
                print("123")
                if let json = try? decoder.decode(Bicycle.self, from: data) {
                    print(json)
                    completion([])
                }
            }.resume()
        } catch requestError.cannotCreateRequestURL {
            print("requestError.cannotCreateRequestURL")
        } catch {
            print("unExpected Error")
        }
    }
}

