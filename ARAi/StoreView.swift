//
//  StoreView.swift
//  Model
//
//  Created by Andreas on 6/8/21.
//

import SwiftUI

struct StoreView: View {
    
  
    @ObservedObject var userData: UserData
    
    let productIDs = [
        "com.ai.podposture.cheerful",
        "com.ai.podposture.ripple",
        "com.ai.podposture.energydrink"
    ]
    @State var categories: [Category]
    var body: some View {
        ScrollView {
        VStack {
            HStack {
                Spacer()
                Text("Scans left: ")
                    .font(.custom("Karla-Medium", size: 18, relativeTo: .headline))
                Text("\(userData.scans)")
                    .font(.custom("Karla-Medium", size: 18, relativeTo: .headline))
                   
            } .padding()
            VStack {
                HStack {
                Text("Create amazing 3D assets!")
                    .font(.custom("Karla-Medium", size: 18, relativeTo: .headline))
                    .padding(.top)
                Spacer()
                } .padding(.horizontal)
                HStack {
                Text("Take photos of an object and I'll process them into a 3D model (.reality file) that you can use anywhere!  With each purchase you get unlimited revisions of the same object scanned.")
                    .font(.custom("Karla-Medium", size: 14, relativeTo: .headline))
                Spacer()
                } .padding(.horizontal)
                if !userData.usedFreeScan {
//                    StoreCardView(title: "One Free Scan", text: "Unlock", price: 0.00, image: "working", audioName: "", userData: userData, model: model)
//                   
                }
                StoreCardView(title: "One Scan", text: "Buy", price: 0.99, image: "working", audioName: "", userData: userData, categories: categories)
                   
                StoreCardView(title: "Three Scans", text: "Buy", price: 1.99, image: "working", audioName: "", userData: userData, categories: categories)
                   
            
            }
            VStack(spacing: 0) {
                HStack {
                Text("Keep the developer going!")
                    .font(.custom("Karla-Medium", size: 18, relativeTo: .headline))
                Spacer()
                } .padding(.horizontal)
                HStack {
                Text("I drink alot of caffeine to keep creating apps.  This does not do anything in the app, it simply gives me an energy drink")
                    .font(.custom("Karla-Medium", size: 14, relativeTo: .headline))
                Spacer()
                } .padding(.horizontal)
                StoreCardView(title: "Energy drink for Andreas", text: "Support Andreas", price: 3.99, image: "energy", audioName: "", userData: userData, categories: categories)
            }
        }
    }
    }
}

