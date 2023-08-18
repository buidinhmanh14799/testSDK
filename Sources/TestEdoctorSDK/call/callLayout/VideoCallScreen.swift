import SwiftUI
import WebKit

struct VideoCallScreen: View {
    
    @EnvironmentObject var directCallManager : DirectCallManager
    var onClose: (() -> Void)
    @State private var isLocalAudioEnabled = true
    @State private var isLocalVideoEnabled = true
    @State private var isCallActive = true
    
    @State private var isFrontCam = true
    
    @State private var secondsElapsed = 0
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.secondsElapsed += 1
        }
    }
    
    var timeFormatted: String {
        let minutes = secondsElapsed / 60
        let seconds = secondsElapsed % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                SendBirdVideoViewWrapper(sendBirdVideoView: (directCallManager.remoteVideoView)).frame(width: geometry.size.width, height: geometry.size.height)
                
                VStack {
                    HStack {
                        Spacer()
                        ZStack {
                            SendBirdVideoViewWrapper(sendBirdVideoView: (directCallManager.localVideoView))
                            Button(action: {
                                isFrontCam.toggle()
                            }) {
                                Image(systemName: "arrow.triangle.2.circlepath.camera.fill")
                                    .font(Font.custom("Font Awesome 6 Pro", size: 22))
                                    .foregroundColor(Color(red: 0.16, green: 0.16, blue: 0.16))
                                    .frame(width: 27.42857, height: 23.12507)
                                    .opacity(0.6)
                            }
                            .padding(.top, 100)
                            .padding(.leading, 100)
                            .onChange(of: isFrontCam) { newValue in
                                directCallManager.directCall?.switchCamera() { error in
                                    
                                }
                            }
                        }.frame(width: 157, height: 157).background(Color.gray)
                            .cornerRadius(18)

                    }.padding(.trailing, 16)
                    Spacer()
                }.padding(.top, 45)

                VStack {
                    Spacer()
                    VStack {
                        
                        HStack {
                            Spacer()
                            AvatarView(UrlString: directCallManager.directCall?.caller?.profileURL, size: 62).padding()
                            VStack{
                                HStack {
                                    Text("\(directCallManager.directCall?.caller?.nickname ?? "---")")
                                        .font(
                                        Font.custom("Inter", size: 18)
                                        .weight(.bold)
                                        )
                                        .foregroundColor(Color(red: 0.29, green: 0.31, blue: 0.34))
                                    Spacer()
                                    HStack(alignment: .center, spacing: 0) {
                                        Text("\(timeFormatted)")
                                        .font(
                                        Font.custom("Mulish", size: 14)
                                        .weight(.heavy)
                                        )
                                        .kerning(0.28)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(Color(red: 0.87, green: 0.09, blue: 0.12))
                                        .onAppear {
                                            _ = self.timer
                                        }
                                    }
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color(red: 0.97, green: 0.92, blue: 0.87))
                                    .cornerRadius(10)
                                    .padding(.trailing, 24)
                                    .padding(.top, -10)
                                }

                                HStack {
                                    
                                    Image(systemName: "person.fill")
                                        .font(Font.custom("Font Awesome 6 Pro", size: 14))
                                        .foregroundColor(Color(red: 0.55, green: 0.56, blue: 0.62))
                                    
                                    Text("\(directCallManager.directCall?.callee?.nickname ?? "---") (Tôi)")
                                        .font(
                                        Font.custom("Inter", size: 14)
                                        .weight(.semibold)
                                        )
                                        .foregroundColor(Color(red: 0.77, green: 0.77, blue: 0.77))
                                        .frame(alignment: .topLeading)
                                        .padding(.leading, -3)
                                    Spacer()
                                }.frame(width: .infinity, height: 6)
                                
                                Text("Phòng khám nam khoa Huỳnh Mai...")
                                .lineLimit(1)
                                .font(Font.custom("Inter", size: 12))
                                .foregroundColor(Color(red: 0.73, green: 0.74, blue: 0.78))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .frame(width: .infinity, height: 84)
    
                        
                        HStack {
                            Button(action: {

                            }) {
                                Image(systemName: "ellipsis.message.fill")
                                    .font(.system(size: 22))
                                    .frame(width: 43.904, height: 43.904)
                                    .foregroundColor(Color.gray)
                                    .background(Color(red: 0.91, green: 0.91, blue: 0.93))
                                    .clipShape(Circle())
                            }
                            Spacer()
                            
                            Button(action: {
                                isLocalAudioEnabled.toggle()

                            }) {
                                Image(systemName: "mic.fill")
                                    .frame(width: 43.904, height: 43.904)
                                    .font(.system(size: 22))
                                    .foregroundColor(isLocalAudioEnabled ? Color.white : Color.gray)
                                    .background(isLocalAudioEnabled ? Color.blue : Color(red: 0.91, green: 0.91, blue: 0.93))
                                    .clipShape(Circle())
                            }
                            .onChange(of: isLocalAudioEnabled) { newValue in
                                if newValue {
                                    directCallManager.directCall?.muteMicrophone()
                                } else {
                                    directCallManager.directCall?.unmuteMicrophone()
                                }
                            }
                            Spacer()
                            
                            Button(action: {
                                isLocalVideoEnabled.toggle()
                                //                        directCallManager.directCall?.video = !isCameraOff
                            }) {
                                Image(systemName: "video.fill")
                                    .frame(width: 43.904, height: 43.904)
                                    .foregroundColor(isLocalVideoEnabled ? Color.white : Color.gray)
                                    .background(isLocalVideoEnabled ? Color.blue : Color(red: 0.91, green: 0.91, blue: 0.93))
                                    .clipShape(Circle())
                            }
                            .onChange(of: isLocalVideoEnabled) { newValue in
                                if newValue {
                                    directCallManager.directCall?.startVideo()
                                } else {
                                    directCallManager.directCall?.stopVideo()
                                }
                            }
                            Spacer()
                            
                            Button(action: {
                                
                            }) {
                                Image(systemName: "plus")
                                    .font(.system(size: 22))
                                    .frame(width: 43.904, height: 43.904)
                                    .foregroundColor(Color.white)
                                    .background(Color(red: 0.02, green: 0.56, blue: 0))
                                    .clipShape(Circle())
                            }
                            Spacer()
                            
                            Button(action: {
                                directCallManager.endCall()
                                onClose()
                            }) {
                                Image(systemName: "phone.down.fill")
                                    .font(.system(size: 22))
                                    .frame(width: 43.904, height: 43.904)
                                    .foregroundColor(.white)
                                    .background(Color(red: 0.96, green: 0.13, blue: 0.18))
                                    .clipShape(Circle())

                            }

                        }.padding(.horizontal, 24)
                            .padding(.vertical, 5)
                    }
                    .frame(width: geometry.size.width - 32, height: 168)
                    .background(Color.white)
                    .cornerRadius(18)
                    .opacity(0.97)

                }.padding(.bottom, 35)
                .frame(width: geometry.size.width, height: geometry.size.height)
            }.frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.green)
            .onAppear {
                isLocalAudioEnabled = directCallManager.directCall?.isLocalAudioEnabled ?? true
                isLocalVideoEnabled = directCallManager.directCall?.isLocalVideoEnabled ?? true
            }
        }
    }
}

//struct VideoCallScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        VideoCallScreen()
//    }
//}


struct RemoteVideoView: View {
    let remoteView: UIView
    
    var body: some View {
        ViewRepresentable(remoteView)
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}

struct RemoteVideoViewController: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        viewController.view = DirectCallManager.shared.remoteVideoView
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Update UI if needed
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
