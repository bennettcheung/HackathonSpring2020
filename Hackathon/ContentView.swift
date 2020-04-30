//
//  ContentView.swift
//  Hackathon
//
//  Created by BC on 2020-04-28.
//  Copyright © 2020 BC. All rights reserved.
//

import SwiftUI
import WaterfallGrid
import MapKit

struct ContentView: View {
    
    @State private var images = Generator.Images.testData()
    @State private var settings = Settings.default(for: .images)
    @State private var showSettings = false
    @State private var showMap = false
    @State private var searchKeyword = ""
    
    var body: some View {
        NavigationView {
            ImagesGrid(images: $images, settings: $settings)
                .customNavigationBarTitle(Text("Inspirations"), displayMode: .inline)
                .customNavigationBarItems(leading: self.leadingNavigationBarItems(), trailing: trailingNavigationBarItems())
        }
//        .sheet(isPresented: $showSettings, content: { SettingsView(settings: self.$settings, screen: .images, isPresented: self.$showSettings) })
            .sheet(isPresented: $showMap, onDismiss: getData, content: {LocationMap(showModal: self.$showMap, searchKeyword: self.$searchKeyword)})
            .navigationViewStyle(StackNavigationViewStyle())
        
    }
    
    private func leadingNavigationBarItems() -> some View {
        Button(action: { self.showMap = true }) {
            Image(systemName: "map")
        }
    }
    
    private func trailingNavigationBarItems() -> some View {
        HStack() {
            Button(action: { self.images = Generator.Images.random() }) {
                Image(systemName: "gobackward")
            }
        }
    }
    
   func getData(){
            var components = URLComponents(string: "https://pixabay.com/api")
            components?.queryItems = [URLQueryItem(name: "key", value: "16299216-fca99185703295e0edae6c1cc"),
                                      URLQueryItem(name: "q", value: self.searchKeyword),
                                      URLQueryItem(name: "image_type", value: "photo")]
            guard let url = components?.url else {return}
            
            URLSession.shared.dataTaskPublisher(for: url) //1
                    .map { $0.data }                               //2
                    .decode(type: PixaBayResponse.self,                //3
                            decoder: JSONDecoder())
            //        .mapError(mapError)                            //4
                    .eraseToAnyPublisher()
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            Group {
           ContentView()
              .environment(\.colorScheme, .light)

           ContentView()
              .environment(\.colorScheme, .dark)
        }
            
    }
}
