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

    @Binding var images: [String]
    @Binding var settings: Settings
    
    var body: some View {
    
        WaterfallGrid((images), id: \.self) { image in
          ImageView(image)
            .onTapGesture{
                print("tapped \(image)")
            }
            
        }

        .gridStyle(
            columns: Int(settings.columns),
            spacing: CGFloat(settings.spacing),
            padding: settings.padding,
            animation: settings.animation
        )
    }
    

}

struct ImagesGrid_Previews: PreviewProvider {
    static var previews: some View {
        ImagesGrid(images: .constant(Generator.Images.testData()), settings: .constant(Settings.default(for: .images)))
                .environment(\.colorScheme, .dark)
    }
}
