//
//  Copyright © 2019 Paolo Leonardi.
//
//  Licensed under the MIT license. See the LICENSE file for more info.
//

import Foundation
import SwiftUI

struct Generator {
    
    struct Images {
        static func random() -> [String] {
            Array(0..<22).map { "image\($0)" }.shuffled()
        }
        static func testData() ->ImageViewModel{
            var model = ImageViewModel()
            
            let imageData = ImageDetail(previewURL: "https://cdn.pixabay.com/photo/2017/05/09/03/46/alberta-2297204_150.jpg", largeImageURL: "https://cdn.pixabay.com/photo/2017/05/09/03/46/alberta-2297204_150.jpg", type: "photo", tags: "tag")
                            
            //                "https://cdn.pixabay.com/photo/2017/05/09/03/46/alberta-2297204_150.jpg",
            //             "https://cdn.pixabay.com/photo/2017/05/09/03/47/buildings-2297210_150.jpg",
            //            "https://cdn.pixabay.com/photo/2014/05/03/00/09/landscape-336542_150.jpg",
            //            "https://cdn.pixabay.com/photo/2016/11/30/15/00/lighthouse-1872998_150.jpg",
            //            "https://cdn.pixabay.com/photo/2019/01/27/22/32/mountains-3959204_150.jpg",
            //            "https://cdn.pixabay.com/photo/2020/03/01/15/30/fox-4893199_150.jpg",
            //            "https://cdn.pixabay.com/photo/2014/07/29/06/41/polar-bear-404314_150.jpg",
            //            "https://cdn.pixabay.com/photo/2012/06/19/18/09/elk-50296_150.jpg",
            //            "https://cdn.pixabay.com/photo/2016/02/07/19/50/snow-1185474_150.jpg"
                        
//            model.imageDetails.append( imageData)
                
            return model

        }
    }

    
}
