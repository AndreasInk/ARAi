//
//  ModelGridView.swift
//  Model
//
//  Created by Andreas on 6/8/21.
//

import SwiftUI
import RealityKit

struct ModelGridView: View {
    let columns = [GridItem(.adaptive(minimum: 80)), GridItem(.adaptive(minimum: 80))]
    @State private var items = [Item]()
    @State private var item = Item(id: UUID(), name: "", description: "", progress: 0.0, result: Data())
    @State private var i = 0
    @Binding var category: Category
    @State var entities = [Entity]()
    @State private var ready = false
    @ObservedObject var userData: UserData
    
    @State private var scan = false
    @State private var showError = false
    @State private var destination = Bundle.main.url(forResource: "Banana", withExtension: "reality")!
    @State private var camera = false
    @State private var export = false
    @State private var preload = true
    
    @State private var reload = false
    
    @State private var isLocal = true
    var body: some View {
        ZStack {
            Color("altText")
                .ignoresSafeArea()
                    .onAppear() {
                        items = category.items.removeDuplicates()
                       
                    }
            
           
              
            if category.items.isEmpty {
                VStack {
                Image("scan")
                    .resizable()
                    .scaledToFit()
                    .padding()
                Text("Take photos of an object and I'll process them into a 3D .reality file")
                        .font(.custom("Karla-Medium", size: 18, relativeTo: .headline))
                        .multilineTextAlignment(.center)
                        .padding()
                       
                    Button(action: {
                        scan = true
                    }) {
                        ZStack {
                            
                            
                            Text("Start Scanning")
                                .font(.custom("Karla-Medium", size: 20, relativeTo: .headline))
                               
                        }
                    }  .buttonStyle(CTAButtonStyle2())
                    
                }
                .sheet(isPresented: $scan) {
                    CameraView( userData: userData, camera: $camera).environment(\.colorScheme, .dark)
                }
//                .sheet(isPresented: $camera) {
//                    ZStack {
//                       Text("Preparing Camera")
//                            .font(.custom("Karla-Medium", size: 18, relativeTo: .headline))
//                    }
//                }
            } else {
                if preload {
                    ARQuickLookView(item: $item, isLocal: $isLocal, reload: $reload)
                        .ignoresSafeArea()
                        .onAppear() {
                            preload = false
                        }
                        }
            
                ScrollView( showsIndicators: false) {
                    VStack {
            ForEach(category.items, id: \.id) { item in
//                if item.progress == 1 {
             
                    
                
                    ZStack {
                        Color("altText")
                            .ignoresSafeArea()
                           
                        ModelItemView(item: item)
                       //     .id(item.id)
                    }
                    ///.id(item.id)
                    .onTapGesture() {
                        self.item = item
                        
                     
                        if category.name != "Food"  && category.name != "2020 Classics" {
                            destination = getDocumentsDirectory().appendingPathComponent("\(item.id).usdz")
                            isLocal = true
                                           } else {
    //                                           if item.name == "Toliet Paper" {
    //                                               destination = Bundle.main.url(forResource: "TP", withExtension: "reality")!
    //                                           } else {
                                               isLocal = false
                                             //  destination = Bundle.main.url(forResource: item.name, withExtension: "reality")!
                                               }
                       
                        ready = true
                        
                    }
              
                .sheet(isPresented: $ready) {
                    ZStack {
                     
                    
                        ARMainView(items: $items, item: $item, i: $i, isOpen: $ready, isLocal: $isLocal)
                            .ignoresSafeArea()
                            .onDisappear() {
                               
                            }
                    
                   
                }
                    
                   // ARHomeView(item: $item, category: $category, userData: userData, destination: $destination)
                }
                
//                .sheet(isPresented: $modelLoader.loading) {
//                    VStack {
//                        Text("Loading Model")
//                            .font(.custom("Karla-Medium", size: 20, relativeTo: .headline))
//                    }
//                }
//            ///2E2ACBF9-F02E-457E-9122-F61D7E806ADF
//                .sheet(isPresented: $modelLoader.noFile) {
//                    VStack {
//                        Text("Your Model Isn't Ready Yet, You'll Get a Notification When It's Ready!")
//                            .font(.custom("Karla-Medium", size: 20, relativeTo: .headline))
//                            .multilineTextAlignment(.center)
//                    }
//                }
                .sheet(isPresented: $showError) {
                    VStack {
                        Text("We hit an error :( please try again")
                            .font(.custom("Karla-Medium", size: 18, relativeTo: .headline))
                            .multilineTextAlignment(.center)
                    }
                }
                    
                
            
//                } else {
//                    NavigationLink(destination: StatusView(progress: item.progress)) {
//                        ZStack {
//                            Color("altText")
//                                .ignoresSafeArea()
//                            ModelItemView(item: item)
//
//                        }
//                    }
                
                
        } //.id(UUID())
        }//.id(UUID())
        .padding()
                       
                        .animation(nil)
            }// .id(UUID())
                
}
        }
    }
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}
