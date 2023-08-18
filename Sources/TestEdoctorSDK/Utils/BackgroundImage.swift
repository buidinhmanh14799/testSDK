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
                } placeholder: {
                    Color(red: 0.02, green: 0.56, blue: 0)
                }
            } else {
                Color(red: 0.02, green: 0.56, blue: 0)
            }
        }else {
            Color(red: 0.02, green: 0.56, blue: 0)
        }

    }
}

//struct BackgroundImage_Previews: PreviewProvider {
//    static var previews: some View {
//        BackgroundImage()
//    }
//}
