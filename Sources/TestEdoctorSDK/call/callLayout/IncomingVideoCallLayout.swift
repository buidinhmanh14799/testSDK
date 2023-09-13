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
    
    @State private var isMicMuted = true
    @State private var isCameraOff = true
    
    @State private var isAnimating = false
    
    @State private var secondsRemaining = 59
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
                BackgroundImage(UrlString: directCallManager.directCall?.caller?.profileURL, blur: 5).frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .background(Color.white.opacity(0.4))
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .background(callStatusManager.callStatus == .comming ? Color(red: 0.02, green: 0.56, blue: 0):  Color(red: 0.85, green: 0.65, blue: 0.55))
                    .opacity(0.3)
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
                            .equatable()
                            
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
                    
                    Group {
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
                    }.frame(width: .infinity, height: 40)



                    
                    Spacer()
                    Spacer()
                    
                    VStack {
                    
                        HStack{
                            Spacer()
                            Button(action: {
                                directCallManager.endCallFast()
                            }) {
                                ZStack {
                                    Image(systemName: "phone.down.fill")
                                        .font(.system(size: 27))
                                        .frame(width: 60, height: 60)
                                        .foregroundColor(.white)
                                        .padding(.bottom, 5)

                                    Text("x")
                                        .foregroundColor(.white)
                                        .font(
                                            Font.custom("Inter", size: 15)
                                                .weight(.bold)
                                        )
                                        .padding(.top, 10)
                                }.background(Color(red: 0.96, green: 0.13, blue: 0.18))
                                    .clipShape(Circle())

                            }
                            
                            Spacer()
                            if callStatusManager.callStatus == .comming {
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
                            }

                        }


                        HStack{
                            if callStatusManager.callStatus == .comming {
                                Spacer()
                                Button(action: {
                                    isMicMuted.toggle()
                                }) {
                                    Image(systemName: "mic.fill")
                                        .frame(width: 50, height: 50)
                                        .font(.system(size: 20
                                                     ))
                                        .foregroundColor(Color.white)
                                        .background(isMicMuted ? Color.blue : Color.gray)
                                        .clipShape(Circle())
                                }.padding(16)
                                
                                
                                Button(action: {
                                    isCameraOff.toggle()
                                }) {
                                    Image(systemName: "video.fill")
                                        .font(.system(size: 20))
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(Color.white)
                                        .background(isCameraOff ? Color.blue : Color.gray)
                                        .clipShape(Circle())
                                }.padding(16)
                                Spacer()

                            }
                        }.frame(width: .infinity, height: 50)
                        .padding(.top, 48)

                        }
                    
                    Spacer()
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

//struct IncomingVideoCallLayout_Previews: PreviewProvider {
//    static var previews: some View {
//        IncomingVideoCallLayout()
//    }
//}
