import SwiftUI
import WebKit

struct VideoCallScreen: View {
    
    @EnvironmentObject var directCallManager : DirectCallManager
    var onClose: (() -> Void)
    @State private var isMicMuted = false
    @State private var isCameraOff = false
    @State private var isCallActive = true
    
    
    var body: some View {
        ZStack {
            if ((directCallManager.directCall?.remoteVideoView) != nil) {
                RemoteVideoView(remoteView: (directCallManager.directCall?.remoteVideoView!)!)
            }
            
            if ((directCallManager.directCall?.localVideoView) != nil) {
                LocalVideoView(localView: (directCallManager.directCall?.localVideoView!)!)
            }
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        isMicMuted.toggle()
//                        directCallManager.directCall?.mut = isMicMuted
                    }) {
                        Image(systemName: isMicMuted ? "mic.slash.fill" : "mic.fill")
                            .foregroundColor(isMicMuted ? .red : .blue)
                    }
                    .padding()
                    
                    Button(action: {
                        isCameraOff.toggle()
//                        directCallManager.directCall?.video = !isCameraOff
                    }) {
                        Image(systemName: isCameraOff ? "video.slash.fill" : "video.fill")
                            .foregroundColor(isCameraOff ? .red : .blue)
                    }
                    .padding()
                    
                    Button(action: {
                        directCallManager.endCall()
                        onClose()
                    }) {
                        Image(systemName: "phone.down.fill")
                            .foregroundColor(.red)
                    }
                    .padding()
                }
                }
            }
        .statusBar(hidden: true)
        .navigationBarHidden(true)
    }
}

struct RemoteVideoView: View {
    let remoteView: UIView
    
    var body: some View {
        ViewRepresentable(remoteView)
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}

struct LocalVideoView: View {
    let localView: UIView
    
    var body: some View {
        ViewRepresentable(localView)
            .scaledToFit()
            .frame(width: 120, height: 160)
            .position(x: UIScreen.main.bounds.width - 75, y: UIScreen.main.bounds.height - 100)
    }
}

struct ViewRepresentable: UIViewRepresentable {
    let view: UIView
    
    init(_ view: UIView) {
        self.view = view
    }
    
    func makeUIView(context: Context) -> UIView {
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Update the view if needed
    }
}
