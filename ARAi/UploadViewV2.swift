//
//  UploadViewv2.swift
//  ARAi
//
//  Created by Andreas on 6/18/21.
//


import SwiftUI
import MessageUI
import RealityKit

struct UploadViewV2: View {
    
    @State private var preload = false
    @State private var shop = false
    @State private var showError = false
    @State private var success = false
    @State private var showModel = false
    @State private var uploading = false
    @State private var export = false
    @State private var export2 = false
    
    @State private var destination = Bundle.main.url(forResource: "banana", withExtension: "usdz")!
    
    @State private var prints = [Print]()
    @State private var item = Item(id: UUID(), name: "", description: "", progress: 0.0, result: Data())
    @State private var progress = 0.0
    @State private var userID = UUID().uuidString
    
    @State  var timer: SimpleTimer
    @State  var timerQueue: SimpleTimer
    @State var queue = Queue(queue: [String]())
    
    @ObservedObject var userData: UserData
    @ObservedObject var model: CameraViewModel
    @ObservedObject var captureFolderState: CaptureFolderState
    
    @Binding var categories: [Category]
    @Binding var upload: Bool
    let rest = RestManager()
    
    var body: some View {
        ZStack {
            if preload {
                ARQuickLookView(name: destination.path)
                    .ignoresSafeArea()
                    .onAppear() {
                        userData.reload += 1
                        preload = false
                        
                    }
                    }
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    destination = documents.appendingPathComponent("\(item.id).reality")
                    export = true
                }) {
                    Image(systemName: "arrow.up.square")
                        .font(.title)
                        .padding()
                }
            }
           
            Image("upload")
                .resizable()
                .scaledToFit()
                .padding()
               
            Text("Once uploaded, the process can take 5-10 minutes or more depending on the queue length.")
                .font(.custom("Karla-Medium", size: 18, relativeTo: .headline))
                .multilineTextAlignment(.center)
                .padding()
           LeadingTextView(text: "Item Name", size: 20)
                .padding()
                .sheet(isPresented: $export) {
                  ShareSheet(
                    activityItems: [captureFolderState.captureDir!],
                    excludedActivityTypes: [.copyToPasteboard])
                }
            
            TextField("Item Name", text: $item.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
               
            Spacer()
            Button(action: {
                withAnimation(.easeInOut) {
                    
                    if userData.scans == 0 {
                        shop = true
                    } else {
                        if item.name.isEmpty {
                            showError = true
                        } else {
                            if captureFolderState.captures.count > 19 {
                            uploading = true
                                let url2 = URL(string: "https://araiapi.herokuapp.com/joinQueue/?userID=\(userID)")
                                         if let url = url2 {
                                
                                             let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                                                 if let httpResponse = response as? HTTPURLResponse {
                                                         print(httpResponse.statusCode)
                                
                                                 } else {
                                                     print(error)
                                                 }
                                             }
                                             task.resume()
                                         }
                            
                                timer = SimpleTimer(interval: 5) {
                                    getLogs()
                                    
                                    print(1)
                               
                                }
                                timer.start()
                                timerQueue = SimpleTimer(interval: 5) {
                                  
                                checkQueue()
                                    print("YES")
                                }
                                timerQueue.start()
                                prints.append(Print(id: UUID().uuidString, process: "Joining Queue"))
                            } else {
                                showError = true
                            }
                    }
                    }
                }
                
            
            }) {
                ZStack {
                   
                    Text(userData.scans != 0 ? (userData.itemIDs.contains("\(captureFolderState.captures.first?.id)") ? "Reupload Without Redeeming" : "Redeem Scan To Upload") : "Purchase Scans In Shop")
                    
                   
                } .padding()
            } .buttonStyle(CTAButtonStyle2())
            Text(String(userData.scans) + " Scans Left")
                .font(.custom("Karla-Medium", size: 16, relativeTo: .headline))
                
        } .sheet(isPresented: $shop) {
            StoreView(userData: userData, categories: categories)
        }
        .sheet(isPresented: $showError) {
            VStack {
                Spacer()
                Text(uploading ? "We hit an error, please try to upload or try again" : ( captureFolderState.captures.count < 19 ? "Please upload more than 20 images" : "We hit an error, please give your item a name to upload or try again"))
                    .font(.custom("Karla-Medium", size: 18, relativeTo: .headline))
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
                Button(action: {
                    upload = false
                   showError = false
                }) {
                    ZStack {
                       
                       
                        Text("Try Again")
                            .font(.custom("Karla-Medium", size: 20, relativeTo: .headline))
                           
                    }
                } .buttonStyle(CTAButtonStyle2())
                    
            }
        }
            
      
        .sheet(isPresented: $success) {
            ZStack {
               
            VStack {
                Spacer()
                Text("Success!")
                    .font(.custom("Karla-Medium", size: 24, relativeTo: .headline))
                    .multilineTextAlignment(.center)
                    .padding()
                    .onAppear() {
                        
                        if userData.itemIDs.contains("\(captureFolderState.captures.first?.id)") {
                            
                        } else {
                            userData.itemIDs.append("\(captureFolderState.captures.first?.id)")
                        userData.scans -= 1
                        
                        
                        }
                    }
                Text("We did it! Remember, if the scan did not appear as expected, you can always take more photos and reupload for free.  Please keep in mind, iPhone's 11 and newer iPad Pro's produce better results.")
                    .font(.custom("Karla-Medium", size: 20, relativeTo: .headline))
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
                
                Button(action: {
                    success = false
                    showModel = true
                }) {
                    ZStack {
                       
                       
                        Text("Show Model!")
                            .font(.custom("Karla-Medium", size: 20, relativeTo: .headline))
                           
                    }
                } .buttonStyle(CTAButtonStyle2())

            }
                ForEach(0 ..< 20) { number in
                                    ConfettiView()
                                    }
            }
        }
            
        
        if uploading {
            Color(UIColor.secondarySystemBackground)
                .ignoresSafeArea()
              
                  
            VStack {
                ScrollViewReader { scrollViewProxy in
                    ScrollView(showsIndicators: false) {
                    ForEach(prints, id: \.id) { item in
                      
                        HStack {
                        Text(item.process)
                            .font(.custom("Karla-Medium", size: 18, relativeTo: .headline))
                            
                            Spacer()
                        }  .id(item.id)
                            .onAppear() {
                                withAnimation(.spring()) {
                                    scrollViewProxy.scrollTo(item.id)
                                }
                            }
                            .padding()
                            .padding()
                        
                        
                            .background( RoundedRectangle(cornerRadius: 25.0)
                                            .foregroundColor(Color("altText")).padding())
                    }
                        
                }
                }
              

ProgressView(value: progress)
                    .padding()
           
                .sheet(isPresented: $showModel) {
                    ZStack {
                     
                    
                    ARQuickLookView(name: destination.path)
                            .ignoresSafeArea()
                            .onDisappear() {
                                upload = false
                            }
                        VStack {
                            HStack {
                                
                                Button(action: {
                                    showModel = false
                                }) {
                                    Image(systemName: "xmark")
                                        .font(.title)
                                        .foregroundColor(.black)
                                        .padding()
                                        .background(RoundedRectangle(cornerRadius: 25).foregroundColor(.white.opacity(0.4)))
                                }  .buttonStyle(CTAButtonStyle())
                                Spacer()
                                Button(action: {
                                    
                                    
                                        
                                    
                //                    if category.name == "Your Models" {
                //                    destination = URL(fileURLWithPath: documents.appendingPathComponent("\(item.id).reality").path)
                //                        if !(destination?.isFileURL ?? false) {
                //
                //                        }
                //                    } else {
                //                        destination = Bundle.main.url(forResource: item.name, withExtension: "reality")!
                //
                //                    }
                                    export2 = true
                                }) {
                                    Image(systemName: "arrow.up.square")
                                        .font(.title)
                                        .foregroundColor(.black)
                                        .padding()
                                        .background(RoundedRectangle(cornerRadius: 25).foregroundColor(.white.opacity(0.4)))
                                }  .buttonStyle(CTAButtonStyle())
                            
                            
                           
                                .sheet(isPresented: $export2) {
                                  ShareSheet(
                                    activityItems: [destination],
                                    excludedActivityTypes: [.copyToPasteboard])
                                }
                                
                            } .padding()
                               
                            Spacer()
                    }
                   
                }
                }
            
            }
        }
        }
    }
    func checkQueue() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let url2 = URL(string: "https://araiapi.herokuapp.com/checkQueue/")
             if let url = url2 {
    
                 let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                     if let httpResponse = response as? HTTPURLResponse {
                             print(httpResponse.statusCode)
    
                     } else {
                         print(error)
                     }
                             guard let data2 = data else { return print("WHAT THE FUCK")}
                     let decoder = JSONDecoder()
                 do {
    
                         let note = try decoder.decode(Queue.self, from: data2)
                     queue = note
                     if note.queue.first == userID {
                         let imgs = captureFolderState.captures.map{ $0.imageUrl }
                         let gravities = captureFolderState.captures.map{ $0.gravityUrl }
                             timerQueue.cancel()
                             for i in imgs.indices {
                                 uploadMultipleFiles(urls: [imgs[i], gravities[i]], i: i)
                             }
                         
                         sendPrint(text: "Uploading Images")
                    
                        
                     } else {
                         let index = note.queue.firstIndex(where: { $0 == userID })
                         prints.append(Print(id: UUID().uuidString, process: "\(index ?? 0)/\(note.queue.count - 1) in queue"))
                     }
                     
                         
                 } catch {
                 }
                 }
                 task.resume()
                 }
                
            }
        
    }
       
        @State var uploaded = false
       
    func getLogs() {
        let url2 = URL(string: "https://araiapi.herokuapp.com/getLogs")
        
        guard let requestUrl = url2 else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        do {
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                let decoder = JSONDecoder()
                if let data = data {
                    do {
                        var note = try decoder.decode(Print.self, from: data)
                      
                        note.id = UUID().uuidString
                        prints.append(note)
                        if  note.process.lowercased().contains("id")  {
                           
                            getUSDZ(id: note.process.replacingOccurrences(of: "ID=", with: ""))
                            progress += 0.05
                            timer.cancel()
                           
                            }
                        
                        
                        
                    } catch {
                        print(error)
                       // sendPrint(text: error.localizedDescription)
                    }
                }
            }
            task.resume()
        }
        
    }
    func getUSDZ(id: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(30)) {
        print("getting usdz")
        let url2 = URL(string: "https://araiapi.herokuapp.com/getImage/?id=\(id).usdz")
         if let url = url2 {
       
             let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                 if let httpResponse = response as? HTTPURLResponse {
                         print(httpResponse.statusCode)
                     
                 } else {
                     print(error)
                 }
                         guard let data2 = data else { return print(error)
                             for i in 0...20 {
                                 print("jndksjikjdiwjdiidjiwjdiwjd")
                             }
                         }
                 do {
                 print(data2)
                 let fileManager = FileManager()
                 let currentWorkingPath = getDocumentsDirectory()
                     var sourceURL = currentWorkingPath
                     
                     let destination = getDocumentsDirectory().appendingPathComponent("\(item.id).usdz")
                 sourceURL.appendPathComponent("archive.zip")
//                     if fileManager.fileExists(atPath: destination.path ) {
//                         try? fileManager.removeItem(atPath: destination.path )
//                     }
                     DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                         do {
                 try data2.write(to: destination)
                             
//                             worldBlock = try Entity.load(contentsOf: destination)
//                             print(worldBlock)
                             progress += 0.03
                         } catch {
                             print(error)
                         }
                     }
                    print(data2)
                     self.destination = destination
                     DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                     success = true
                    
                         progress += 0.02
                        
                     }
                     
                     //let destination = documents.appendingPathComponent("\(item.id).usdz")
//                 do {
//
//                     try fileManager.unzipItem(at: sourceURL, to: destination)
//
//                 } catch {
//                     print("Extraction of ZIP archive failed with error:\(error)")
//                 }
                 } catch {
                     print(error)
                 }
             }
             task.resume()
         }
        
    }
    }
    func sendPrint(text: String) {
        let text2 = text.replacingOccurrences(of: " ", with: "--").replacingOccurrences(of: "/", with: "").replacingOccurrences(of: "\"", with: "")
        
        if  let url = URL(string: "https://araiapi.herokuapp.com/printNow/?print=\(text2)") {
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                
                
            }
            
            task.resume()
        }
        
    }
    func uploadMultipleFiles(urls: [URL], i: Int) {
          var infos = [RestManager.FileInfo]()
          for url in urls {
  
             let uuid = String(i)
              var newURL = self.getDocumentsDirectory().appendingPathComponent(String(i) + ".HEIC")
              if url.lastPathComponent.contains("HEIC") {
  
              do {
                  try UIImage(contentsOfFile: url.path)?.pngData()!.write(to: newURL)
                  let imageFileInfo = RestManager.FileInfo(withFileURL: url, filename: String(i) + ".HEIC", name: "uploadedFile", mimetype: "image/HEIC")
                  infos.append(imageFileInfo)
              } catch {
  
              }
              } else if url.lastPathComponent.lowercased().contains("txt") {
                   newURL = self.getDocumentsDirectory().appendingPathComponent(String(i) + ".txt")
                  do {
                      try Data(contentsOf: url).write(to: newURL)
                      let imageFileInfo = RestManager.FileInfo(withFileURL: newURL, filename: String(i) + ".txt", name: "uploadedFile", mimetype: "text/plain")
                      infos.append(imageFileInfo)
                  } catch {
  
                  }
              } else {
                  newURL = self.getDocumentsDirectory().appendingPathComponent(String(i) + ".TIFF")
                 do {
                     try Data(contentsOf: url).write(to: newURL)
                     let imageFileInfo = RestManager.FileInfo(withFileURL: newURL, filename: String(i) + ".TIFF", name: "uploadedFile", mimetype: "image/tiff")
                     infos.append(imageFileInfo)
                 } catch {
  
                 }
              }
  
          }
  
  
          upload(files: infos, toURL: URL(string: "https://araiapi.herokuapp.com/multiupload/")) { (success) -> Void in
              if success {
  
  
                 // captureFolderState.captures = []
                  //captureFolderState.requestLoad()
              }
          }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
              sendPrint(text: "Uploaded Images")
        }
      }
  
  
  
  
  
  
      func upload(files: [RestManager.FileInfo], toURL url: URL?, completion: (_ success: Bool) -> Void) {
          if let uploadURL = url {
              rest.upload(files: files, toURL: uploadURL, withHttpMethod: .post) { (results, failedFilesList) in
                  print("HTTP status code:", results.response?.httpStatusCode ?? 0)
  
                  if let error = results.error {
                      print(error)
                  }
                  let decoder = JSONDecoder()
                  if let data = results.data {
                      do {
                          let note = try decoder.decode(Print.self, from: data)
                          prints.append(note)
                      } catch {
  
                      }
                  }
  
                  if let failedFiles = failedFilesList {
                      for file in failedFiles {
                          print(file)
                      }
                  }
              }
          }
  
          completion(true)
      }
  
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
            }
    
struct Print: Decodable, Hashable {
    var id: String
    var process: String
}
