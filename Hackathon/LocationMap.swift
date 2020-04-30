//
//  LocationMap.swift
//  Hackathon
//
//  Created by BC on 2020-04-29.
//  Copyright © 2020 BC. All rights reserved.
//

import SwiftUI
import MapKit

struct LocationMap: View {
    @Binding var showModal: Bool
    @Binding var searchKeyword: String
    @State private var locationCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0 )

    var body: some View {
        ZStack {
            VStack {
                MapView(centerCoordinate: self.$locationCoordinate)
              HStack {

                Spacer()
                Button("Done") {
                    self.findGeocode()

              }
              .padding()
            }

            }
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
        }
    

    }
            private func findGeocode()  {
                let geocoder = CLGeocoder()
                let location = CLLocation(latitude: locationCoordinate.latitude,
                                          longitude: locationCoordinate.longitude)
                geocoder.reverseGeocodeLocation(location) { (places, error) in
                if error == nil {
                    if let placeMark = places?[0]{
                        print("Placemark \(placeMark)")
                        self.searchKeyword = placeMark.locality ?? placeMark.country ?? ""
                        self.showModal = false
                    }
                }
              }
    }
}

struct LocationMap_Previews: PreviewProvider {
    static var previews: some View {
        LocationMap(showModal: .constant(true), searchKeyword: .constant(""))
    }
}
