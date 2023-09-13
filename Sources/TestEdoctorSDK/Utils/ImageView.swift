//
//  ImageView.swift
//  AppTestSDK
//
//  Created by Bùi Đình Mạnh on 07/09/2023.
//

import SwiftUI

struct ImageView: View {
    @State private var image: UIImage? = nil
    @State private var isLoading = false
    @State private var isError = false
    
    let imageURL: URL?
    
    init(url: URL?) {
        self.imageURL = url
    }
    
    func loadImage() {
        isLoading = true
        isError = false
        
        guard let imageURL = imageURL else {
            isLoading = false
            isError = true
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            isLoading = false
            
            if let error = error {
                print("Error: \(error)")
                isError = true
                return
            }
            
            if let data = data, let loadedImage = UIImage(data: data) {
                image = loadedImage
            } else {
                isError = true
            }
        }.resume()
    }
    
    var body: some View {
        VStack {
            if isLoading {
                if #available(iOS 14.0, *) {
                    ProgressView()
                } else {
                    Text("Đang tải...").foregroundColor(.gray)
                }
            } else if isError {
                Text("Error loading image")
                    .foregroundColor(.red)
            } else if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
            }
        }
        .onAppear {
            loadImage()
        }
    }
}
