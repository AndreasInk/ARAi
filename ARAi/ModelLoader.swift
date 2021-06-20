//
//  ModelLoader.swift
//  Model
//
//  Created by Andreas on 6/9/21.
//

//import SwiftUI
//import Combine
//import RealityKit
//class ModelLoader: ObservableObject {
//    // ...
//   @Published var noFile = false
//    @Published var loading = false
//    
//    func getDocumentsDirectory() -> URL {
//        // find all possible documents directories for this user
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        
//        // just send back the first one, which ought to be the only one
//        return paths[0]
//    }
//    
//    func load(category: Category, item: Item, userID: String, destination: URL?, completion: (_ success: Bool) -> Void)  {
////        let storage = Storage.storage()
////        let storageRef = storage.reference()
////
//        
//       // if category.name == "Your Models" {
//            #warning("changed")
//        
//            let destination = getDocumentsDirectory().appendingPathComponent("\(item.id).reality")
//            let url = getDocumentsDirectory().appendingPathComponent("\(item.id).usdz")//Bundle.main.url(forResource: "Crew", withExtension: "reality")!
//                  //worldBlock = ((try? Entity.load(contentsOf:destination)) ?? Entity())!
//        print(destination.isFileURL )
//        var data = Data()
//        do {
//        data = try Data(contentsOf: destination)
//        } catch {
//            print(error)
//        }
//        if !data.isEmpty {
//            
//        
//        do  {
//           
//            worldBlock = try Entity.load(contentsOf: destination).clone(recursive: true)
//                
//                                                print(worldBlock)
//                
//                
//                    self.loading = false
//          
//          //  try? FileManager.default.moveItem(at: destination, to: getDocumentsDirectory().appendingPathComponent("\(item.id).reality"))
////            try? FileManager.default.removeItem(at: destination)
//                    completion(true)
//            
//                                            } catch {
//                                                print("Fail loading entity.")
//                                                print(error)
//                                                try? FileManager.default.moveItem(at: url, to: destination)
//                                                do {
//                                                worldBlock = try Entity.load(contentsOf: destination).clone(recursive: true)
//                                                completion(true)
//                                                    self.loading = false
//                                                } catch {
//                                                    print(error)
//                                                    print("noFile")
//                                                    noFile = true
//                                                }
//                                            }
//        } else {
//            try? FileManager.default.moveItem(at: url, to: destination)
//            do {
//            worldBlock = try Entity.load(contentsOf: destination).clone(recursive: true)
//            completion(true)
//                self.loading = false
//            } catch {
//                print("noFile")
//                print(error)
//            }
//        }
//            
////h = userID + "/" + item.id.uuidString + "/"
////        let riversRef = storageRef.child(path + "\(item.id).reality")
////        print(path)
////         // You can also access to download URL after upload.
////         riversRef.downloadURL { (url, error) in
////           guard let downloadURL = url else {
////
////               self.noFile = true
////               self.loading = false
////             return print("error")
////
////           }
////            //EEAC1567-159F-41C1-AC23-EA2651A0EFC6
////             let url = downloadURL
////                    let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
////
////                    let session = URLSession(configuration: .default,
////                                                  delegate: nil,
////                                             delegateQueue: nil)
////
////             var request = URLRequest(url: url)
////                    request.httpMethod = "GET"
////
////                    let downloadTask = session.downloadTask(with: request, completionHandler: { (location: URL?,
////                                              response: URLResponse?,
////                                                 error: Error?) -> Void in
////
////                        let fileManager = FileManager.default
////
////                        if fileManager.fileExists(atPath: destination!.path) {
////                            try? fileManager.removeItem(atPath: destination!.path)
////                        }
////
////                        try? fileManager.moveItem(atPath: location!.path,
////                                                  toPath: destination!.path)
////
////                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
////                            do {
////                                worldBlock = try Entity.load(contentsOf: destination!)
////
////                                print(worldBlock)
////
////
////                                self?.loading = false
////                            } catch {
////                                print("Fail loading entity.")
////
////                            }
////                        }
////
////
////                                                            })
////
////             downloadTask.resume()
////
////
////
////}
////
//            
//            
//    }
////        } else {
////            self.loading = false
////            completion(true)
////        }
//
//    }
//
