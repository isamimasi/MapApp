//
//  MapView.swift
//  MapApp
//
//  Created by F. ISAMI. on 2024/05/09.
//

import SwiftUI
//MapKit imported
import MapKit
//Define MapType
enum MapType{
    case standard
    case satelite
    case hybrid
}
struct MapView: View {
    @State var targetCoordinate = CLLocationCoordinate2D()//緯度と経度を定義
    @State var cameraPosition: MapCameraPosition =  .automatic
    let searchKey: String
    let mapType: MapType
    // define MapStyle:  standard or imagery or hybrid
    var mapStyle: MapStyle{
        switch mapType{
        case .standard:
            return MapStyle.standard()
        case .satelite:
            return MapStyle.imagery()
        case .hybrid:
            return MapStyle.hybrid()
        }
    }
    //
    var body: some View {
        //Map
        Map(position: $cameraPosition){
            Marker (searchKey, coordinate: targetCoordinate)
        }
        .mapStyle(mapStyle)
            .onChange(of: searchKey, initial: true){ oldValue, newValue in
                print ("search Keyword: \(newValue)")
            //search Map query
                let request = MKLocalSearch.Request()
            // add query to Keyword
                request.naturalLanguageQuery = newValue
            // Initialize MKlocal
                let search = MKLocalSearch(request:  request)
            //start search
                search.start{response, error in
                    if let mapItems = response?.mapItems,
                       let mapItem = mapItems.first {
                        targetCoordinate = mapItem.placemark.coordinate
                        //print ("GPS: \(targetCoordinate)")
                        cameraPosition = .region(MKCoordinateRegion(
                            center: targetCoordinate,
                            latitudinalMeters: 500,
                            longitudinalMeters: 500))
                               
                    }
                               }
                
            }
        
    }
}

#Preview {
    MapView(searchKey:"東京駅", mapType: .standard)
}
