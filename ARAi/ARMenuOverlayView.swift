//
//  ARMenuOverlayView.swift
//  ARAi
//
//  Created by Andreas on 6/28/21.
//

import SwiftUI

struct ARMenuOverlayView: View {
    @Binding var items: [Item]
    @Binding var item: Item
    @Binding var i: Int
    @Binding var isOpen: Bool
    @Binding var nonAR: Bool
    @State var open = false
    @State var showButtons = false
    @State var animateButtons = false
    @State var share = false
    @State var export = false
    @State var shop = false
    @Binding var reload: Bool
    @Binding var isLocal: Bool
    @State var url = URL(string: "")
    @ObservedObject var userData: UserData
    @Binding var categories: [Category]
    var body: some View {
        HStack {
           
           
               
                Spacer()
          
        VStack {
           
            
            Button(action: {
                withAnimation(.easeInOut(duration: 1.0)) {
                showButtons.toggle()
                }
               
            }) {
                Image(systemName: showButtons ? "arrow.up" : "arrow.down")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                    .background( LinearGradient(gradient: Gradient(colors:  [Color("w2"), Color("w1")]), startPoint: .topLeading, endPoint: .bottom).clipShape(RoundedRectangle(cornerRadius: 25)) .opacity(0.9)
                                    .frame(maxWidth: 115, maxHeight: 150)
                                    .shadow(
                                        color:Color("w2").opacity( 0.2),
                                      radius: 18,
                                      x: -18,
                                      y: -18)
                                    .shadow(
                                        color: Color("w1").opacity( 0.2),
                                      radius: 14,
                                      x: 14,
                                        y: 14))
            } .buttonStyle(CTAButtonStyle())
                
           
            
            if showButtons {
           
            
                if !showButtons {
                    Spacer()
                }
                Button(action: {
                    isOpen = false
                }) {
                    Image(systemName: "xmark")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                        .background( LinearGradient(gradient: Gradient(colors:  [Color("purple"), Color("pink")]), startPoint: .topLeading, endPoint: .bottom).clipShape(RoundedRectangle(cornerRadius: 25)) .opacity(0.9)
                                        .frame(maxWidth: 115, maxHeight: 150)
                                        .shadow(
                                            color:Color("purple").opacity( 0.2),
                                          radius: 18,
                                          x: -18,
                                          y: -18)
                                        .shadow(
                                            color: Color("pink").opacity( 0.2),
                                          radius: 14,
                                          x: 14,
                                            y: 14))
                }  .buttonStyle(CTAButtonStyle())
                
             
               
           
            
            Button(action: {
                if items.indices.contains(i - 1) {
                i -= 1
                    item = items[i]
                } else {
                   
                    i = 0
                    if items.indices.contains(i) {
                    item = items[i]
                    }
                    
                }
                reload = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    reload = false
                }
                
            }) {
                Image(systemName: "arrow.left")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                    .background( LinearGradient(gradient: Gradient(colors:  [Color("purple"), Color("red")]), startPoint: .topLeading, endPoint: .bottom).clipShape(RoundedRectangle(cornerRadius: 25)) .opacity(0.9)
                                    .frame(maxWidth: 115, maxHeight: 150)
                                    .shadow(
                                        color:Color("purple").opacity( 0.2),
                                      radius: 18,
                                      x: -18,
                                      y: -18)
                                    .shadow(
                                        color: Color("red").opacity( 0.2),
                                      radius: 14,
                                      x: 14,
                                        y: 14))
            } .buttonStyle(CTAButtonStyle())
            
            Button(action: {
                if items.indices.contains(i + 1) {
                i += 1
                    item = items[i]
                } else {
                    i = 0
                    if items.indices.contains(i) {
                    item = items[i]
                    }
                }
                reload = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    reload = false
                }
            }) {
                Image(systemName: "arrow.right")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                    .background( LinearGradient(gradient: Gradient(colors:  [Color("purple"), Color("red")]), startPoint: .topLeading, endPoint: .bottom).clipShape(RoundedRectangle(cornerRadius: 25)) .opacity(0.9)
                                    .frame(maxWidth: 115, maxHeight: 150)
                                    .shadow(
                                        color:Color("purple").opacity( 0.2),
                                      radius: 18,
                                      x: -18,
                                      y: -18)
                                    .shadow(
                                        color: Color("red").opacity( 0.2),
                                      radius: 14,
                                      x: 14,
                                        y: 14))
            } .buttonStyle(CTAButtonStyle())
           
                Button(action: {
                    showButtons = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    nonAR.toggle()
                    }
                }) {
                    Image(systemName: "cube")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                        .background( LinearGradient(gradient: Gradient(colors:  [Color("purple"), Color("blue")]), startPoint: .topLeading, endPoint: .bottom).clipShape(RoundedRectangle(cornerRadius: 25)) .opacity(0.9)
                                        .frame(maxWidth: 115, maxHeight: 150)
                                        .shadow(
                                            color:Color("purple").opacity( 0.2),
                                          radius: 18,
                                          x: -18,
                                          y: -18)
                                        .shadow(
                                            color: Color("blue").opacity( 0.2),
                                          radius: 14,
                                          x: 14,
                                            y: 14))
                } .buttonStyle(CTAButtonStyle())
                HStack {
                Button(action: {
                    
                    export = true
                   
                   
                    
                    
                }) {
                    Image(systemName: "square.and.arrow.up.on.square")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                        .background( LinearGradient(gradient: Gradient(colors:  [Color("w2"), Color("w1")]), startPoint: .topLeading, endPoint: .bottom).clipShape(RoundedRectangle(cornerRadius: 25)) .opacity(0.9)
                                        .frame(maxWidth: 115, maxHeight: 150)
                                        .shadow(
                                            color:Color("w2").opacity( 0.2),
                                          radius: 18,
                                          x: -18,
                                          y: -18)
                                        .shadow(
                                            color: Color("w1").opacity( 0.2),
                                          radius: 14,
                                          x: 14,
                                            y: 14))
                } .buttonStyle(CTAButtonStyle())
                    
                    if share {
                    Button(action: {
//                        do {
//                        let data = try Data(contentsOf: getDocumentsDirectory().appendingPathComponent("\(item.id).usdz"))
//                        url = getDocumentsDirectory().appendingPathComponent("\(item.id).obj")
//                        let fileManager = FileManager.default
//                        try? fileManager.moveItem(at: getDocumentsDirectory().appendingPathComponent("\(item.id).usdz"),
//                                                                     to:  url)
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                                do {
//                         try data.write(to: getDocumentsDirectory().appendingPathComponent("\(item.id).usdz"))
//                                } catch {
//                                }
//                                }
//                        export = true
//                        } catch {
//
//                        }
                    }) {
                        Text("OBJ")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding()
                            .background( LinearGradient(gradient: Gradient(colors:  [Color("w3"), Color("w2")]), startPoint: .topLeading, endPoint: .bottom).clipShape(RoundedRectangle(cornerRadius: 25)) .opacity(0.9)
                                            .frame(maxWidth: 115, maxHeight: 150)
                                            .shadow(
                                                color:Color("w3").opacity( 0.2),
                                              radius: 18,
                                              x: -18,
                                              y: -18)
                                            .shadow(
                                                color: Color("w2").opacity( 0.2),
                                              radius: 14,
                                              x: 14,
                                                y: 14))
                    } .buttonStyle(CTAButtonStyle())
                    }
        }
            }
               
                Spacer()
                .sheet(isPresented: $export) {
                    VStack {
                        Spacer()
                        Image("ob3")
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
                            .rotation3DEffect(.degrees(3), axis: (x: 0, y: 1, z: 0))
                            .shadow(color: Color(.lightGray).opacity(0.2), radius: 40)
                        Spacer()
                        Text(!userData.itemIDs.contains(item.id) ? (userData.scans == 0 ? "Tap Below to Purchase More Downloads" : "Redeem One Download?") : "Download Your Model!")
                            .font(.custom("Karla-Bold", size: 24, relativeTo: .headline))
                            .multilineTextAlignment(.center)
                            .padding()
                        Text(!userData.itemIDs.contains(item.id) ? "Once you download one scan, you can take more photos and reupload them, then download your revisions as many times as you like" : "")
                            .font(.custom("Karla-Medium", size: 18, relativeTo: .headline))
                            .multilineTextAlignment(.center)
                            .padding()
                        Spacer()
                        Button(action: {
                            if userData.itemIDs.contains(item.id) {
                            share = true
                            } else {
                                if userData.scans == 0 {
                                    shop = true
                                } else {
                                share.toggle()
                                }
                                
                            }
                            
                        }) {
                            ZStack {
                               
                               
                                Text(userData.itemIDs.contains(item.id) ? "Download" : (userData.scans == 0 ? "Shop" : "Download"))
                                    .font(.custom("Karla-Medium", size: 20, relativeTo: .headline))
                                   
                            }
                        } .buttonStyle(CTAButtonStyle2())
                    }
                    .sheet(isPresented: $share) {
                        ShareSheet(
                          activityItems: [isLocal ? getDocumentsDirectory().appendingPathComponent("\(item.id).usdz") : Bundle.main.url(forResource: item.name, withExtension: "reality")!  ],
                          excludedActivityTypes: [.copyToPasteboard])
                            .onAppear() {
                                if !userData.itemIDs.contains(item.id) {
                                    userData.scans -= 1
                                    userData.itemIDs.append(item.id)
                                }
                            }
                        
                    }
                    .sheet(isPresented: $shop) {
                        StoreView(userData: userData, categories: categories)
                    }
                }
            
        } .padding(.vertical)
        } 
            .animation(.spring())
            .transition(.move(edge: .bottom))
            .sheet(isPresented: $shop) {
                StoreView(userData: userData, categories: categories)
            }
    }
    func getDocumentsDirectory() -> URL {
           // find all possible documents directories for this user
           let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
   
           // just send back the first one, which ought to be the only one
           return paths[0]
       }
}
