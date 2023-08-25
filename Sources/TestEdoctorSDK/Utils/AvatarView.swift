//
//  AvatarView.swift
//  AppTestSDK
//
//  Created by Bùi Đình Mạnh on 15/08/2023.
//

import SwiftUI

struct AvatarView: View {
    var UrlString: String?
    var size: CGFloat
    
    var body: some View {
        if UrlString != nil {
            if #available(iOS 15.0, *) {
                AsyncImage(url: URL(string: UrlString!)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size, height: size)
                        .clipShape(Circle())
                } placeholder: {
                    Image(systemName: "person.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: size, height: size)
                        .clipShape(Circle())
                }
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size, height: size)
                    .clipShape(Circle())
            }
        } else {
            Image(systemName: "person.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
                .clipShape(Circle())
        }
    }
}
