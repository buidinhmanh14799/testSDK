//
//  FinnishCallLayout.swift
//  AppTestSDK
//
//  Created by Bùi Đình Mạnh on 18/08/2023.
//

import SwiftUI

struct FinnishCallLayout: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Cuộc gọi đã kết thúc.")
                
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.gray)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct FinnishCallLayout_Previews: PreviewProvider {
    static var previews: some View {
        FinnishCallLayout()
    }
}
