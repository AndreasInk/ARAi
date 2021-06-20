//
//  OnboardingView.swift
//  Model
//
//  Created by Andreas on 6/9/21.
//

import SwiftUI
import UserNotifications
struct OnboardingView: View {
    @State var onboardingViews = [Onboarding(id: UUID(), image: "logo", title: "AiAR", description: "Empowering Your Creativity And Productivity."), Onboarding(id: UUID(), image: "Burger", title: "Create Amazingly Realistic 3D Models With Photos", description: "You take photos of an object that you want scanned, and I process them into a 3D model.")] //Onboarding(id: UUID(), image: "noti", title: "Can We Send You Notifications?", description: "You'll receive notifications on updates and when you model is finished.")]
    @State private var slideNum = 0
    @Binding var isOnboarding: Bool
    @Binding var isOnboarding2: Bool
    @State private var time = 0
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var userData: UserData
    var body: some View {
        VStack {
            TabView(selection: $slideNum) {
                ForEach(onboardingViews.indices, id: \.self) { i in
                    OnboardingDetail(onboarding: onboardingViews[i])
                        .tag(i)
                }
            }
            .tabViewStyle(PageTabViewStyle())
         
            if onboardingViews[slideNum].title.contains("Can") {
            Button(action: {
                if slideNum + 1 < onboardingViews.count  {
                    slideNum += 1
                } else {
                    // dismiss sheet
                    presentationMode.wrappedValue.dismiss()
                }
                
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundColor(Color(.lightGray))
                        .frame(height: 75)
                        .padding()
                    Text("No")
                        .font(.custom("Karla-Medium", size: 18, relativeTo: .headline))
                        .foregroundColor(.white)
                }
            }  .buttonStyle(CTAButtonStyle())
            }
            Button(action: {
                if onboardingViews[slideNum].title.contains("Noti") {
//                    let pushManager = PushNotificationManager(userData: userData)
//                     pushManager.registerForPushNotifications()
                    
                }
                if slideNum + 1 < onboardingViews.count  {
                    slideNum += 1
                } else {
                    // dismiss sheet
                    presentationMode.wrappedValue.dismiss()
                    
                }
                
            }) {
                ZStack {
                    
                    Text(onboardingViews[slideNum].title.contains("Can") ? "Yes" : "Continue")
                       
                        
                }
            }  .buttonStyle(CTAButtonStyle2())
            
        }
    }
}

struct OnboardingDetail: View {
    @State var onboarding: Onboarding
   
    var body: some View {
        VStack {
            Text(onboarding.title)
                .font(.custom("Karla-Bold", size: 24, relativeTo: .title))
                .multilineTextAlignment(.center)
                .padding(.bottom)
                .fixedSize(horizontal: false, vertical: true)
            Text(onboarding.description)
                .font(.custom("Karla-Medium", size: 18, relativeTo: .headline))
                .multilineTextAlignment(.center)
                .padding(.bottom)
                .fixedSize(horizontal: false, vertical: true)
           
            
            Image(onboarding.image)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .rotation3DEffect(.degrees(3), axis: (x: 0, y: 1, z: 0))
                .shadow(color: Color(.lightGray).opacity(0.2), radius: 40)
        }
        .padding()
    }
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}


struct Onboarding: Identifiable, Hashable {
    var id: UUID
    var image: String
    var title: String
    var description: String
}
