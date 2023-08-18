//
//  IncomingVideoCallLayout.swift
//  AppTestSDK
//
//  Created by Bùi Đình Mạnh on 17/08/2023.
//

import SwiftUI

struct IncomingVideoCallLayout: View {
    
    @EnvironmentObject var directCallManager : DirectCallManager
    @EnvironmentObject var callStatusManager : CallStatusManager
    var onClose: (() -> Void)
    
    @State private var isMicMuted = true
    @State private var isCameraOff = true
    
    @State private var isAnimating = false
    
    @State private var secondsRemaining = 60
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.secondsRemaining > 0 {
                self.secondsRemaining -= 1
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                BackgroundImage(UrlString: directCallManager.directCall?.caller?.profileURL).frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .background(callStatusManager.callStatus == .comming ? Color(red: 0.02, green: 0.56, blue: 0):  Color(red: 0.85, green: 0.65, blue: 0.55))
                    .opacity(0.5)
                VStack {
                    Spacer()
                    
                    ZStack {
                        ForEach(0..<3) { index in
                            Circle()
                                .frame(width: 175, height: 175)
                                .foregroundColor(Color.white)
                                .overlay(
                                    Circle()
                                        .stroke(Color.white.opacity(0.3), lineWidth: 10)
                                        .scaleEffect(isAnimating ? 1.5 : 1.0)
                                        .opacity(isAnimating ? 0 : 1)
                                        .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: false).delay(Double(index) * 0.5))
                                )
                        }
                        .onAppear() {
                            isAnimating.toggle()
                            _ = self.timer
                        }
                        
                        AvatarView(UrlString: directCallManager.directCall?.caller?.profileURL, size: 157)
                    }.padding(.top)
                    
                    Text("BS.\(directCallManager.directCall?.caller?.nickname ?? "") gọi Video")
                        .foregroundColor(Color(red: 0.87, green: 0.09, blue: 0.12))
                        .padding(.top, 20)
                        .font(
                            Font.custom("Inter", size: 16)
                                .weight(.medium)
                        )
                    Text("\(directCallManager.directCall?.caller?.nickname ?? "")")
                        .font(
                            Font.custom("Inter", size: 30)
                                .weight(.medium))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(0)
                    
                    if callStatusManager.callStatus == .comming {
                        Text("\(secondsRemaining)S")
                            .font(
                                Font.custom("Inter", size: 30)
                                    .weight(.bold)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(secondsRemaining < 10 ? .red : .white)
                            .padding(.top, 36)
                    }else {
                        Text("\(getTextCallStatus(callStatus: callStatusManager.callStatus))")
                            .font(
                                Font.custom("Inter", size: 16)
                                    .weight(.bold)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding(.top, 36)
                    }


                    
                    Spacer()
                    Spacer()
                    
                    VStack {
                        HStack{
                            Spacer()
                            Button(action: {
                                directCallManager.endCall()
                                onClose()
                            }) {
                                Image(systemName: "phone.down.fill")
                                    .font(.system(size: 27
                                                 ))
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.white)
                                    .background(Color(red: 0.96, green: 0.13, blue: 0.18))
                                    .clipShape(Circle())
                                
                            }
                            Spacer()
                            
                            Button(action: {
                                DispatchQueue.main.async {
                                    directCallManager.acceptCall(isMicOn: isMicMuted, isCamOn: isCameraOff)
                                }
                            }) {
                                Image(systemName: "phone.fill")
                                    .font(.system(size: 27))
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(Color.white)
                                    .background(Color(red: 0.02, green: 0.56, blue: 0))
                                    .clipShape(Circle())
                            }
                            Spacer()
                        }.padding()

                        HStack{
                            Spacer()
                            Button(action: {
                                isMicMuted.toggle()
                            }) {
                                Image(systemName: "mic.fill")
                                    .frame(width: 60, height: 60)
                                    .font(.system(size: 20
                                                 ))
                                    .foregroundColor(Color.white)
                                    .background(isMicMuted ? Color.blue : Color.gray)
                                    .clipShape(Circle())
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                isCameraOff.toggle()
                            }) {
                                Image(systemName: "video.fill")
                                    .font(.system(size: 20))
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(Color.white)
                                    .background(isCameraOff ? Color.blue : Color.gray)
                                    .clipShape(Circle())
                            }
                            Spacer()
                        }.padding(.horizontal)

                        
                    }
                    
                    
                    Spacer()
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

//struct IncomingVideoCallLayout_Previews: PreviewProvider {
//    static var previews: some View {
//        IncomingVideoCallLayout()
//    }
//}
