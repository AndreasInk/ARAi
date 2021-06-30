//
//  HomeView.swift
//  Model
//
//  Created by Andreas on 6/8/21.
//

import SwiftUI
import RealityKit
struct HomeView: View {
    
    
    @State private var categories = [Category(id: UUID(), name: "Your Models", description: "", items: [Item](), colors: ["purple", "blue"]), Category(id: UUID(), name: "Food", description: "", items: [Item(id: UUID().uuidString, name: "Burger", description: "", progress: 1.0, result: Data()), Item(id: UUID().uuidString, name: "Pizza", description: "", progress: 1.0, result: Data()), Item(id: UUID().uuidString, name: "Broccoli", description: "", progress: 1.0, result: Data()), Item(id: UUID().uuidString, name: "Banana", description: "", progress: 1.0, result: Data())],  colors: ["red", "purple"]), Category(id: UUID(), name: "2020 Classics", description: "", items: [Item(id: UUID().uuidString, name: "Wipes", description: "", progress: 1.0, result: Data()), Item(id: UUID().uuidString, name: "Toliet-Paper", description: "", progress: 1.0, result: Data())],  colors: ["dark", "darker"])]
    //, Category(id: UUID(), name: "Tech", description: "", items: [Item(id: UUID().uuidString, name: "Microchip", description: "", progress: 1.0, result: Data())])
    
                             //[Item(id: UUID().uuidString, name: "Bannana", description: "It's a fruit!", progress: 1.0, result: Data()), Item(id: UUID().uuidString, name: "Apple", description: "It's a fruit!", progress: 1.0, result: Data()), Item(id: UUID().uuidString, name: "Orange", description: "It's a fruit!", progress: 1.0, result: Data()), Item(id: UUID().uuidString, name: "Blueberries", description: "It's a fruit!", progress: 1.0, result: Data())])]
    @State private var category = Category(id: UUID(), name: "Fruits", description: "", items: [Item](),  colors: ["purple", "blue"])
    //[Item(id: UUID().uuidString, name: "Bannana", description: "It's a fruit!", progress: 0.0, result: Data()), Item(id: UUID().uuidString, name: "Apple", description: "It's a fruit!", progress: 0.0, result: Data()), Item(id: UUID().uuidString, name: "Orange", description: "It's a fruit!", progress: 0.0, result: Data()), Item(id: UUID().uuidString, name: "Blueberries", description: "It's a fruit!", progress: 0.0, result: Data())])
    @ObservedObject var userData: UserData
    @State var entities = [Entity]()
   
    @Environment(\.presentationMode) private var presentation
    @State var coolDown = false
    var body: some View {
        NavigationView { [presentation] in
            ScrollView(showsIndicators: false) {
        VStack {
            HeaderView( userData: userData, categories: $categories, category: $category)
                .onChange(of: userData.reload) { value in
                    if !coolDown {
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
//                    for i in category.items.indices {
//                        #warning("removed")
//                    //categories[i].items = categories[i].items.removeDuplicates()
//                    }
                        coolDown = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                            coolDown = false
                        }
                }
                }
                .onAppear() {
                    
                    do {
                        if !getDocumentsDirectory().appendingPathComponent("x.png").isFileURL {
                    try UIImage(systemName: "xmark")?.pngData()?.write(to: getDocumentsDirectory().appendingPathComponent("x.png"))
                        }
                    } catch {
                        
                    }
                    
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
                                print(error.localizedDescription)
                                let encoder = JSONEncoder()
                               
                                if let encoded = try? encoder.encode(categories) {
                                    if let json = String(data: encoded, encoding: .utf8) {
                                        
                                        do {
                                            let url = self.getDocumentsDirectory().appendingPathComponent("categories.txt")
                                            try json.write(to: url, atomically: false, encoding: String.Encoding.utf8)
                                            
                                        } catch {
                                            print("erorr")
                                        }
                                    }
                                }
                                
                            }
                    #warning("causing issue?")
                   // categories[i].items = categories[i].items.removeDuplicates()
                
                    category = categories.first ?? category
//                    for i in categories.indices {
//                        for i2 in categories[i].items.indices {
//                        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//                  let destination = documents.appendingPathComponent("\(categories[i].items[i2].id).png")
//
//                        if categories[i].name == "Your Models" {
//                        if categories[i].items[i2].result.isEmpty {
//
//
//
//
//
//                }
//                        }
//                        }
//                    }
                }
            SearchBarView(categories: $categories, category: $category)
            CategoryView(categories: $categories, pickedCategory: $category, userData: userData)
                .ignoresSafeArea()
           
           Spacer()
                .onChange(of: categories) { newValue in
                    
                    let encoder = JSONEncoder()
                   
                    if let encoded = try? encoder.encode(categories) {
                        if let json = String(data: encoded, encoding: .utf8) {
                            
                            do {
                                let url = self.getDocumentsDirectory().appendingPathComponent("categories.txt")
                                try json.write(to: url, atomically: false, encoding: String.Encoding.utf8)
                                
                            } catch {
                                print("erorr")
                            }
                        }
                    }
                        }
        
                    
            ModelGridView(category: $category, entities: entities, userData: userData, categories: $categories)
             //  
        } .navigationBarHidden(true)
              //
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


