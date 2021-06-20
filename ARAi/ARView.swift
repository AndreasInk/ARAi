//
//  ARView.swift
//  Model
//
//  Created by Andreas on 6/8/21.
//

import SwiftUI
import UniformTypeIdentifiers
import UIKit
//struct ARHomeView: View {
//    @Binding var item: Item
//    @Binding var category: Category
//    @ObservedObject var userData: UserData
//    @State private var export = false
//    @State private var tap = false
//    @State private var ready = false
//    @Binding var destination: URL?
//    
//    
//    func getDocumentsDirectory() -> URL {
//        // find all possible documents directories for this user
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        
//        // just send back the first one, which ought to be the only one
//        return paths[0]
//    }
//    
//    var body: some View {
//        ZStack {
//            Color.clear
//                .onAppear() {
//                     let destination = getDocumentsDirectory().appendingPathComponent("\(item.id).usdz")
//                    let url = getDocumentsDirectory().appendingPathComponent("result.usdz")//Bundle.main.url(forResource: "Crew", withExtension: "reality")!
//                          //worldBlock = ((try? Entity.load(contentsOf:destination)) ?? Entity())!
//                    
//                    if (destination.isFileURL) {
//                        modelLoader.load(category: category, item: item, userID: userData.userID, destination: destination) { success in
//                            if success {
//                            ready = true
//                            } else {
//                                
//                            }
//                        }
//                    } else {
//                    let fileManager = FileManager.default
//                    try? fileManager.moveItem(atPath: url.path,
//                                              toPath: destination.path)
//                        if fileManager.fileExists(atPath: url.path ) {
//                            try? fileManager.removeItem(atPath: url.path )
//                        }
//                        modelLoader.load(category: category, item: item, userID: userData.userID, destination: destination) { success in
//                            if success {
//                            ready = true
//                            } else {
//                                
//                            }
//                    }
//                    }
//                }
//             if ready {
//            ARViewContainer(item: $item, category: $category, userData: userData)
//                .ignoresSafeArea()
//            }
//        VStack {
//            HStack {
//                Spacer()
//                Button(action: {
//                    
//                    
//                        
//                    
////                    if category.name == "Your Models" {
////                    destination = URL(fileURLWithPath: documents.appendingPathComponent("\(item.id).reality").path)
////                        if !(destination?.isFileURL ?? false) {
////                           
////                        }
////                    } else {
////                        destination = Bundle.main.url(forResource: item.name, withExtension: "reality")!
////                       
////                    }
//                    export = true
//                }) {
//                    Image(systemName: "arrow.up.square")
//                        .font(.title)
//                        .padding()
//                }
//            }
//            
//            Spacer()
//                .sheet(isPresented: $export) {
//                  ShareSheet(
//                    activityItems: [getDocumentsDirectory().appendingPathComponent("\(item.id).usdz")],
//                    excludedActivityTypes: [.copyToPasteboard])
//                }
//               
//                
//              }
////            if !tap {
////            VStack {
////                Spacer()
////            Text("Tap your screen to place your model")
////                .font(.custom("Karla-Medium", size: 16, relativeTo: .headline))
////                .multilineTextAlignment(.center)
////                .foregroundColor(Color("altText"))
////                .padding()
////                .background(RoundedRectangle(cornerRadius: 25).foregroundColor(Color("text")))
////                .onAppear() {
////                    let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
////                        withAnimation(.easeInOut) {
////                        tap = tapped
////                        }
////                    }
////                }
////            } .transition(.opacity)
////            }
//        } .onDisappear() {
//            tapped = false
//            tap = false
//            
//        }
//       
//    }
//    
//    }
//
//
import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {
  typealias Callback = (
    _ activityType: UIActivity.ActivityType?,
    _ completed: Bool,
    _ returnedItems: [Any]?,
    _ error: Error?) -> Void

  var activityItems: [Any]
  var applicationActivities: [UIActivity]?
  var excludedActivityTypes: [UIActivity.ActivityType]?
  var callback: Callback?

  func makeUIViewController(context: Context) -> UIActivityViewController {
    let controller = UIActivityViewController(
      activityItems: activityItems,
      applicationActivities: applicationActivities)
    controller.excludedActivityTypes = excludedActivityTypes
    controller.completionWithItemsHandler = callback
    return controller
  }

  func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
    // nothing to do here
  }
}
struct ShareSheet_Previews: PreviewProvider {
  static var previews: some View {
    let theShareSheet = ShareSheet(
      activityItems: ["A preview string" as NSString],
      excludedActivityTypes: [UIActivity.ActivityType.airDrop])
    return theShareSheet
  }
}
extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}
