//
//  BackgroundImage.swift
//  AppTestSDK
//
//  Created by Bùi Đình Mạnh on 17/08/2023.
//

import SwiftUI

struct BackgroundImage: View, Encodable {
    let UrlString: String?
    let blur: CGFloat
    var body: some View {
        if #available(iOS 15.0, *), UrlString != nil {
            AsyncImage(url: URL(string: UrlString!)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .blur(radius: blur)
            } placeholder: {
                Color(red: 1, green: 1, blue: 1)
            }
        } else {
            if UrlString != nil {
                ImageView(url: URL(string: UrlString!))
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .blur(radius: blur)
            } else {
                Color(red: 1, green: 1, blue: 1)
            }

        }

    }
}

//struct BackgroundImage_Previews: PreviewProvider {
//    static var previews: some View {
//        BackgroundImage()
//    }
//}
