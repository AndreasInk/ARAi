//
//  ARMainView.swift
//  ARAi
//
//  Created by Andreas on 6/28/21.
//

import SwiftUI
import RealityKit
struct ARMainView: View {
    @Binding var items: [Item]
    @Binding var item: Item
    @Binding var i: Int
    @Binding var isOpen: Bool
    @State var nonAR = false
    @State var nonAR2 = true
    @State var reload = false
    @Binding var isLocal: Bool
    var body: some View {
        ZStack {
            
//            if nonAR {
//                ARQuickLookView(name: item.name, nonAR: nonAR2)
//                .edgesIgnoringSafeArea(.all)
//                    .onAppear() {
//
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                                nonAR = false
//                                print(nonAR)
//                                print(26713721)
//                        }
//                        }
//
//            } else {
            if !reload {
            if nonAR2 {
                ARQuickLookView(item: $item, isLocal: $isLocal, reload: $reload)
                  
            }
                if nonAR {
                    ARQuickLookView(item: $item, isLocal: $isLocal, reload: $reload)
                        .onAppear() {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            nonAR2 = false
                            }
                        }
                        .onDisappear() {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            nonAR2 = true
                            }
                        }
                } else {
                   
                       
                }
               
            }
                
            
                
            ARMenuOverlayView(items: $items, item: $item, i: $i, isOpen: $isOpen, nonAR: $nonAR, reload: $reload, isLocal: $isLocal)
                .onAppear() {
                    if item.name == "" {
                        item = items.last ?? item
                    }
                }
        
        }  .edgesIgnoringSafeArea(.all)
    }
}


