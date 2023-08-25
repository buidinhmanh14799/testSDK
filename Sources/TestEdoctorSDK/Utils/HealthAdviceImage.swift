//
//  SwiftUIView.swift
//  
//
//  Created by Bùi Đình Mạnh on 25/08/2023.
//

import SwiftUI

public struct HealthAdviceImage: View {
    public var body: some View {
        VStack {
            Image("TuVan").frame(width: 67, height: 67)
            Text("Tư vấn sức khoẻ")
                .font(
                Font.custom("SF Pro Text", size: 12)
                .weight(.semibold)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
        }
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIView()
//    }
//}
