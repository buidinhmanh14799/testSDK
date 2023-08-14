import SwiftUI
import WebKit

struct StartCallLayout: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var directCallManager = DirectCallManager.shared
    
    var body: some View {
        VStack {
            ZStack {
                       Color.black.edgesIgnoringSafeArea(.all)
                       
                       VStack {
                           Spacer()
                           
                           Image(systemName: "person.crop.circle.fill")
                               .resizable()
                               .aspectRatio(contentMode: .fill)
                               .frame(width: 120, height: 120)
                               .clipShape(Circle())
                               .padding(.bottom, 20)
                           
                           Text("Calling...")
                               .font(.title)
                               .foregroundColor(.white)
                           
                           Text(directCallManager.directCall?.callee?.nickname ?? "Unknown")
                               .font(.subheadline)
                               .foregroundColor(.gray)
                           
                           Spacer()
                           
                           HStack {
                               Spacer()
                               
                               Button(action: {
                                   directCallManager.endCall()
                                   presentationMode.wrappedValue.dismiss()
                               }) {
                                   Image(systemName: "phone.down.fill")
                                       .font(.system(size: 25))
                                       .foregroundColor(.red)
                                       .padding()
                                       .background(Color.white.opacity(0.2))
                                       .clipShape(Circle())
                               }
                               .padding(.horizontal, 20)
                           }
                       }
                   }
                   .navigationBarHidden(true)
        }
        .onDisappear {
            // Đóng hosting controller khi SwiftUI view biến mất
            if let presentingViewController = UIApplication.shared.windows.first?.rootViewController?.presentedViewController {
                presentingViewController.dismiss(animated: true, completion: nil)
            }
        }
    }
}

