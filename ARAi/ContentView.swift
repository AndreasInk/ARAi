//
//  ContentView.swift
//  Model
//
//  Created by Andreas on 6/8/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var userData: UserData
    @State private var isOnboarding = false
    var body: some View {
        ZStack {
        Color.clear
//            .sheet(isPresented: $userData.showOnboarding) {
//                OnboardingView(isOnboarding: $isOnboarding, isOnboarding2: $isOnboarding, userData: userData)
//
//
//        }
        //if !userData.showOnboarding {
            HomeView(userData: userData)
      //  }
        }
           
            
    }
}

