//
//  ModelItemView.swift
//  Model
//
//  Created by Andreas on 6/8/21.
//

import SwiftUI
import RealityKit
struct ModelItemView: View {

    @State var item: Item
    @State private var entity = Entity()
    @State private var show3D = false
    var body: some View {
        ZStack {
            Color("altText")
                .ignoresSafeArea()
               
        VStack {
            HStack {
        LeadingTextView(text: item.name, size: 18, opacity: 1.0)
//                if item.progress != 1.0 {
//                   
//                    CircularProgressView(progress: $item.progress)
//                        
//                        
//                    
//                }
            } 
            Spacer()
               
            if show3D {
//                NoCameraARViewContainer(entity: $entity)
//                    .frame(width: 100, height: 100)
            } else {
                Image(uiImage:  (item.result.isEmpty ? UIImage(named:item.name) : UIImage(data: item.result)) ?? UIImage())
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .padding()
               
                
                //.transition(.opacity)
                
            }
        } 
    } 
            
    }
}
