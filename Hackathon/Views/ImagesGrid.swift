//
//  ImagesGrid.swift
//  Hackathon
//
//  Created by BC on 2020-04-29.
//  Copyright © 2020 BC. All rights reserved.
//

import SwiftUI
import WaterfallGrid


struct ImagesGrid: View {

    @ObservedObject var model = ImageViewModel()
    @Binding var settings: Settings
    @State var isPresented = false
    @State var selectedImage: ImageDetail?
    
    var body: some View {
        WaterfallGrid((model.imageDetails), id: \.self) { image in
            ImageView(image.previewURL)
            .onTapGesture{
                print("tapped \(image)")
                self.selectedImage = image
                self.isPresented = true
            }
        }
        .gridStyle(
            columns: Int(settings.columns),
            spacing: CGFloat(settings.spacing),
            padding: settings.padding,
            animation: settings.animation
        )
            .sheet(isPresented: $isPresented) {
                VStack{
                    ImageView(self.selectedImage!.largeImageURL)
                    Text("\(self.selectedImage!.tags)")
                }
        }
    }
    

}

struct ImagesGrid_Previews: PreviewProvider {
    static var previews: some View {
        ImagesGrid(model: Generator.Images.testData(), settings: .constant(Settings.default(for: .images)))
                .environment(\.colorScheme, .light)
    }
}
