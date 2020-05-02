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
    
    @State private var settings = Settings.default(for: .images)
    @State private var showSettings = false
    @State private var showMap = false
    @State private var searchKeyword = "Vancouver"
     @State private var showLoading = true
    @ObservedObject var viewModel = ImageViewModel()

    var body: some View {
        NavigationView {
            ZStack{                
                ImagesGrid(model: viewModel, settings: $settings)
                    .customNavigationBarTitle(Text(self.searchKeyword), displayMode: .inline)
                    .customNavigationBarItems(leading: self.leadingNavigationBarItems(), trailing: trailingNavigationBarItems())
                }

                
            }
            
            
            .sheet(isPresented: $showMap, onDismiss: refresh, content: {LocationMap(showModal: self.$showMap, searchKeyword: self.$searchKeyword)})
            .navigationViewStyle(StackNavigationViewStyle())
            .onAppear(perform: {
                self.viewModel.search(self.searchKeyword)
                
            })
        
    }
    
    private func leadingNavigationBarItems() -> some View {
        Button(action: { self.showMap = true }) {
            Image(systemName: "map")
        }
    }
    
    private func trailingNavigationBarItems() -> some View {
        HStack() {
            Button(action: {self.refresh() }) {
                Image(systemName: "")
            }
        }
    }
    
    func refresh(){
        self.viewModel.search(self.searchKeyword)


    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            Group {
           ContentView()
              .environment(\.colorScheme, .light)

           ContentView()
              .environment(\.colorScheme, .dark)
                
           ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch)"))

        }
            
    }
}
