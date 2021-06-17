//
//  HeaderView.swift
//  Model
//
//  Created by Andreas on 6/8/21.
//

import SwiftUI

struct HeaderView: View {
   
    @ObservedObject var userData: UserData
    @State private var instruct = false
    @State private var camera = false
    @Binding var categories: [Category]
    @Binding var category: Category
    var body: some View {
        HStack {
            NavigationLink(destination: StoreView(userData: userData, categories: categories)) {
                
                LinearGradient.lairHorizontalDark
                  .mask(Image("shop").resizable().scaledToFit().padding())
                  
                  .frame(width: 75, height: 75)
                    
                    
                    
                    
                    
                   
        }
            Spacer()
            Button(action: {
                camera = true
            }) {
                LinearGradient.lairHorizontalDark
                  .mask(Image(systemName: "camera").resizable().scaledToFit().padding())
                  
                  .frame(width: 75, height: 75)
                    
                    
                    
                    
                    
                    
            }
            
                
            
            
                
        
            .sheet(isPresented: $camera) {
                CameraView( userData: userData, camera: $camera).environment(\.colorScheme, .dark)
                    .onDisappear() {
                        let url = self.getDocumentsDirectory().appendingPathComponent("categories.txt")
                        do {
                            
                            let input = try String(contentsOf: url)
                            
                            
                            let jsonData = Data(input.utf8)
                           
                                let decoder = JSONDecoder()
                                
                                
                                    let note = try decoder.decode([Category].self, from: jsonData)
                                    categories = note
                            category = categories.first ?? category
                           
                                   
                                    //                                if i.first!.id == "1" {
                                    //                                    notes.removeFirst()
                                    //                                }
                                    
                                    
                                } catch {
                                }
                    }
            }
        } .padding()
}
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}
