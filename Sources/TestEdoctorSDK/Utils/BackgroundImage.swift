//
//  BackgroundImage.swift
//  AppTestSDK
//
//  Created by Bùi Đình Mạnh on 17/08/2023.
//

import SwiftUI

struct BackgroundImage: View {
    let UrlString: String?
    var body: some View {
        if UrlString != nil {
            if #available(iOS 15.0, *) {
                AsyncImage(url: URL(string: UrlString!)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .blur(radius: 5)
                } placeholder: {
                    Color(red: 1, green: 1, blue: 1)
                }
            } else {
                Color(red: 1, green: 1, blue: 1)
            }
        }else {
            Color(red: 1, green: 1, blue: 1)
        }

    }
}

//struct BackgroundImage_Previews: PreviewProvider {
//    static var previews: some View {
//        BackgroundImage()
//    }
//}
