//
//  ContentView.swift
//  Model
//
//  Created by Andreas on 6/8/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model = CameraViewModel()
    @ObservedObject var userData: UserData
    @ObservedObject var modelLoader: ModelLoader
    @State private var isOnboarding = false
    var body: some View {
       
        HomeView(model: model, userData: userData, modelLoader: modelLoader)
           
            .sheet(isPresented: $userData.showOnboarding) {
                OnboardingView(isOnboarding: $isOnboarding, isOnboarding2: $isOnboarding, userData: userData)
               
                
        }
    }
}

