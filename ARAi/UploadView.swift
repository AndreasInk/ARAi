//
//  UploadView.swift
//  Model
//
//  Created by Andreas on 6/8/21.
//

////import SwiftUI
////import MessageUI
////import RealityKit
////struct Items: Decodable, Hashable, Identifiable {
////    var id: String
////    var process: String
////}
//
struct Queue: Decodable {
    var queue: [String]

}
//struct ModelID: Decodable {
//    var modelID: String
//
//}
//struct UploadView: View {
//    let gesture = DragGesture()
//    @ObservedObject var userData: UserData
//    @ObservedObject var model: CameraViewModel
//    @State var shop = false
//    @ObservedObject var captureFolderState: CaptureFolderState
//    @Binding var categories: [Category]
//    @State var item = Item(id: UUID(), name: "", description: "", progress: 0.0, result: Data())
//    @State var showError = false
//@State var success = false
//    @State var export = false
//    @State var export2 = false
//    @State var uploading = false
//    @Binding var upload: Bool
//    @State var destination = Bundle.main.url(forResource: "Banana", withExtension: "reality")!
//    @State var images = [UIImage]()
//    @State var items = [Items]()
//    @State var isShowingMailView = false
//    @State var result: Result<MFMailComposeResult, Error>? = nil
//    let rest = RestManager()
//    @State var userID = UUID().uuidString
//    @State var queue = Queue(queue: [String]())
//    @State var notQueued = true
//    @State var stopLogging = false
//    @State var stopLoop = 0
//    func sendPrint(text: String) {
//        let text2 = text.replacingOccurrences(of: " ", with: "--").replacingOccurrences(of: "/", with: "").replacingOccurrences(of: "\"", with: "")
//        let url = URL(string: "https://araiapi.herokuapp.com/printNow/?print=\(text2)")!
//
//        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
//            guard let data2 = data else { return }
//
//
//
//                let decoder = JSONDecoder()
//            do {
//
//                    let note = try decoder.decode(Item.self, from: data2)
//
//            } catch {
//            }
//            }
//
//        task.resume()
//    }
//    @State var preload = true
//    @State var progress = 0.0
//    var body: some View {
//        ZStack {
//            if preload {
//            ARQuickLookView(name: destination.path)
//                    .ignoresSafeArea()
//                    .onAppear() {
//                        userData.reload += 1
//                        preload = false
//
//                    }
//                    }
//        VStack {
//            HStack {
//                Spacer()
//                Button(action: {
//                    let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//                    destination = documents.appendingPathComponent("\(item.id).reality")
////                    for capture in captureFolderState.captures {
////                        images.append( UIImage(contentsOfFile: capture.imageUrl.path)!)
////
////                    }
////                    let imagesData = images.flatMap() {  $0.pngData() ?? Data() }
////                    let encoder = JSONEncoder()
////
////                    if let encoded = try? encoder.encode(imagesData) {
////                        if let json = String(data: encoded, encoding: .utf8) {
////
////                            do {
////                                let url = self.getDocumentsDirectory().appendingPathComponent("imgs.txt")
////                                try json.write(to: url, atomically: false, encoding: String.Encoding.utf8)
////
////                            } catch {
////                                print("erorr")
////                            }
////                        }
////                    }
//                    export = true
//                }) {
//                    Image(systemName: "arrow.up.square")
//                        .font(.title)
//                        .padding()
//                }
//            }
//
//            Image("upload")
//                .resizable()
//                .scaledToFit()
//                .padding()
//                .onAppear() {
//                    let url = self.getDocumentsDirectory().appendingPathComponent("categories.txt")
//                    do {
//
//                        let input = try String(contentsOf: url)
//
//
//                        let jsonData = Data(input.utf8)
//
//                            let decoder = JSONDecoder()
//
//
//                                let note = try decoder.decode([Category].self, from: jsonData)
//                                categories = note
//
//
//                                //                                if i.first!.id == "1" {
//                                //                                    notes.removeFirst()
//                                //                                }
//
//
//                            } catch {
//                                print(error.localizedDescription)
//                            }
//                }
//            Text("Once uploaded, the process can take 5-10 minutes or more depending on the queue length.")
//                .font(.custom("Karla-Medium", size: 18, relativeTo: .headline))
//                .multilineTextAlignment(.center)
//                .padding()
//           LeadingTextView(text: "Item Name", size: 20)
//                .padding()
//                .sheet(isPresented: $export) {
//                  ShareSheet(
//                    activityItems: [captureFolderState.captureDir!],
//                    excludedActivityTypes: [.copyToPasteboard])
//                }
//
//            TextField("Item Name", text: $item.name)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//
//            Spacer()
//            Button(action: {
//                withAnimation(.easeInOut) {
//
//                    if userData.scans == 0 {
//                        shop = true
//                    } else {
//                        if item.name.isEmpty {
//                            showError = true
//                        } else {
//                            if captureFolderState.captures.count > 19 {
//                            uploading = true
//                            } else {
//                                showError = true
//                            }
//                    }
//                    }
//                }
//
//
//            }) {
//                ZStack {
//
//                    Text(userData.scans != 0 ? (userData.itemIDs.contains("\(captureFolderState.captures.first?.id)") ? "Reupload Without Redeeming" : "Redeem Scan To Upload") : "Purchase Scans In Shop")
//
//
//                } .padding()
//            } .buttonStyle(CTAButtonStyle2())
//            Text(String(userData.scans) + " Scans Left")
//                .font(.custom("Karla-Medium", size: 16, relativeTo: .headline))
//
//        } .sheet(isPresented: $shop) {
//            StoreView(userData: userData, categories: categories)
//        }
//        .sheet(isPresented: $showError) {
//            VStack {
//                Spacer()
//                Text(uploading ? "We hit an error, please try to upload or try again" : ( captureFolderState.captures.count < 19 ? "Please upload more than 20 images" : "We hit an error, please give your item a name to upload or try again"))
//                    .font(.custom("Karla-Medium", size: 18, relativeTo: .headline))
//                    .multilineTextAlignment(.center)
//                    .padding()
//                Spacer()
//                Button(action: {
//                    upload = false
//                   showError = false
//                }) {
//                    ZStack {
//
//
//                        Text("Try Again")
//                            .font(.custom("Karla-Medium", size: 20, relativeTo: .headline))
//
//                    }
//                } .buttonStyle(CTAButtonStyle2())
//                    .onDisappear() {
//                        upload = false
//                    }
//            }
//        }
//
//
//        .sheet(isPresented: $success) {
//            ZStack {
//
//            VStack {
//                Spacer()
//                Text("Success!")
//                    .font(.custom("Karla-Medium", size: 24, relativeTo: .headline))
//                    .multilineTextAlignment(.center)
//                    .padding()
//                    .onAppear() {
//
//                        if userData.itemIDs.contains("\(captureFolderState.captures.first?.id)") {
//
//                        } else {
//                            userData.itemIDs.append("\(captureFolderState.captures.first?.id)")
//                        userData.scans -= 1
//
//
//                        }
//                    }
//                Text("We did it! Remember, if the scan did not appear as expected, you can always take more photos and reupload for free.  Please keep in mind, iPhone's 11 and newer iPad Pro's produce better results.")
//                    .font(.custom("Karla-Medium", size: 20, relativeTo: .headline))
//                    .multilineTextAlignment(.center)
//                    .padding()
//                Spacer()
//
//                Button(action: {
//                    success = false
//                    showModel = true
//                }) {
//                    ZStack {
//
//
//                        Text("Show Model!")
//                            .font(.custom("Karla-Medium", size: 20, relativeTo: .headline))
//
//                    }
//                } .buttonStyle(CTAButtonStyle2())
//
//            }
//                ForEach(0 ..< 20) { number in
//                                    ConfettiView()
//                                    }
//            }
//        }
//
//
//        if uploading {
//            Color(UIColor.secondarySystemBackground)
//                .ignoresSafeArea()
//                .onDisappear() {
//                    if queue.queue.first == userID {
//                       // leaveQueue()/
//
//                    }
//                }
//                .onAppear() {
//
//                    do {
//
//
////                        item.result = try Data(contentsOf:  (captureFolderState.captures.last?.imageUrl ?? getDocumentsDirectory().appendingPathComponent("x.png")))
//                        let url = self.getDocumentsDirectory().appendingPathComponent("categories.txt")
//                        do {
//
//                            let input = try String(contentsOf: url)
//
//
//                            let jsonData = Data(input.utf8)
//
//                                let decoder = JSONDecoder()
//
//
//                                    let note = try decoder.decode([Category].self, from: jsonData)
//                                    categories = note
//
//
//                                    //                                if i.first!.id == "1" {
//                                    //                                    notes.removeFirst()
//                                    //                                }
//
//
//                                } catch {
//                                    print(error.localizedDescription)
//                                }
//
//
//                        do {
//
//                            let index = categories.firstIndex(where: { $0.name == "Your Models" })
//                            categories[index ?? 0].items.append(item)
//                            let encoder = JSONEncoder()
//
//                            if let encoded = try? encoder.encode(categories) {
//                                if let json = String(data: encoded, encoding: .utf8) {
//
//                                    do {
//                                        let url = self.getDocumentsDirectory().appendingPathComponent("categories.txt")
//                                        try json.write(to: url, atomically: false, encoding: String.Encoding.utf8)
//                                        userData.reload += 1
//                                    } catch {
//                                        print("erorr")
//                                    }
//                                }
//                            }
//                        } catch {
//                        }
//
//                    } catch {
//print(error)
//                    }
//                    }
//
//            VStack {
//                ScrollViewReader { scrollViewProxy in
//                    ScrollView(showsIndicators: false) {
//                    ForEach(items, id: \.self) { item in
//
//                        HStack {
//                        Text(item.process)
//                            .font(.custom("Karla-Medium", size: 18, relativeTo: .headline))
//                            Spacer()
//                        } .padding()
//                            .padding()
//                            .id(item.id)
//                            .onAppear() {
//                                withAnimation(.spring()) {
//                                scrollViewProxy.scrollTo(item.id)
//                                }
//                            }
//                            .background( RoundedRectangle(cornerRadius: 25.0)
//                                            .foregroundColor(Color("altText")).padding())
//                        }
//
//                }
//                }
//                .highPriorityGesture(gesture)
//
//ProgressView(value: progress)
//                    .padding()
//
//                .sheet(isPresented: $showModel) {
//                    ZStack {
//
//
//                    ARQuickLookView(name: destination.path)
//                            .ignoresSafeArea()
//                            .onDisappear() {
//                                upload = false
//                            }
//                        VStack {
//                            HStack {
//
//                                Button(action: {
//                                    showModel = false
//                                }) {
//                                    Image(systemName: "xmark")
//                                        .font(.title)
//                                        .foregroundColor(.black)
//                                        .padding()
//                                        .background(RoundedRectangle(cornerRadius: 25).foregroundColor(.white.opacity(0.4)))
//                                }  .buttonStyle(CTAButtonStyle())
//                                Spacer()
//                                Button(action: {
//
//
//
//
//                //                    if category.name == "Your Models" {
//                //                    destination = URL(fileURLWithPath: documents.appendingPathComponent("\(item.id).reality").path)
//                //                        if !(destination?.isFileURL ?? false) {
//                //
//                //                        }
//                //                    } else {
//                //                        destination = Bundle.main.url(forResource: item.name, withExtension: "reality")!
//                //
//                //                    }
//                                    export2 = true
//                                }) {
//                                    Image(systemName: "arrow.up.square")
//                                        .font(.title)
//                                        .foregroundColor(.black)
//                                        .padding()
//                                        .background(RoundedRectangle(cornerRadius: 25).foregroundColor(.white.opacity(0.4)))
//                                }  .buttonStyle(CTAButtonStyle())
//
//
//
//                                .sheet(isPresented: $export2) {
//                                  ShareSheet(
//                                    activityItems: [destination],
//                                    excludedActivityTypes: [.copyToPasteboard])
//                                }
//
//                            } .padding()
//
//                            Spacer()
//                    }
//                   // ARHomeView(item: $item, category: $category, userData: userData, destination: $destination)
//                }
//                }
//                .sheet(isPresented: $isShowingMailView) {
//                            MailView(isShowing: self.$isShowingMailView, result: self.$result)
//                        }
//                    .onAppear() {
//                        items.append(Items(id: UUID().uuidString, process: "Joining Queue"))
//
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                            joinQueue()
//                        }
//
//
//
//
////                        for imgUrl in imgUrls {
////                            let imageData = UIImage(contentsOfFile: imgUrl.path)?.jpegData(compressionQuality: 0.5)
////                            let strBase64 = imageData?.base64EncodedString(options: .lineLength64Characters).replacingOccurrences(of: "/", with: "-")
////
////                            let newStr = strBase64?.removingAllWhitespaces
////                            let url = URL(string: "https://araiapi.herokuapp.com/add/?img=\(newStr!)")!
////                            var request = URLRequest(url: url)
////                            let session = URLSession.shared
////                            request.setValue(
////                                "authToken",
////                                forHTTPHeaderField: "Authorization"
////                            )
//////                            let body = ["img": "defg"]
//////                            let bodyData = try? JSONSerialization.data(
//////                                withJSONObject: body,
//////                                options: []
//////                            )
////
////                            // Change the URLRequest to a POST request
////                            request.httpMethod = "POST"
////                           // request.httpBody = bodyData
////                            let task = session.dataTask(with: request) { (data, response, error) in
////
////                                if let error = error {
////                                    // Handle HTTP request error
////                                    print(error)
////                                } else if let data = data {
////                                    // Handle HTTP request response
////                                    print(String(data: data, encoding: .utf8)!)
////                                } else {
////                                    // Handle unexpected error
////                                }
////                            }
////                            task.resume()
////                        }
//
////
////                            let fileManager = FileManager()
////                            let currentWorkingPath = fileManager.currentDirectoryPath
////                            var sourceURL = URL(fileURLWithPath: currentWorkingPath)
////                            sourceURL.appendPathComponent(captureFolderState.captureDir!.relativePath)
////                            var destinationURL = self.getDocumentsDirectory()
////
////                            if MFMailComposeViewController.canSendMail() {
////                                //self.isShowingMailView.toggle()
////                              } else {
////                                  // show failure alert
////                              }
////
////
////                            destinationURL = destinationURL.appendingPathComponent("\(item.id).zip")
////                            do {
////                                //try fileManager.zipItem(at: captureFolderState.captureDir!, to: destinationURL)
//////                                FirebaseStorageManager().uploadFile(localFile: destinationURL, serverFileName: "\(destinationURL.lastPathComponent)", userID: userData.userID, folderName: item.id.uuidString) { (isSuccess, url) in
//////                                         //print("uploadImageData: \(isSuccess), \(url)")
//////
//////                                    }
////
////
////                            } catch {
////                                print("Creation of ZIP archive failed with error:\(error)")
////                                showError = true
////                            }
////                            for imgUrl in gravityUrls {
////
////
////
////                                FirebaseStorageManager().uploadFile(localFile: destinationURL, serverFileName: "\(destinationURL.lastPathComponent)", userID: userData.userID, folderName: item.id.uuidString) { (isSuccess, url) in
////                                         print("uploadImageData: \(isSuccess), \(url)")
////                                    }
////
////                            }
//            let encoder = JSONEncoder()
//                            let url = self.getDocumentsDirectory().appendingPathComponent("fcm.txt")
//                            if let encoded = try? encoder.encode(userData.fcm) {
//                                if let json = String(data: encoded, encoding: .utf8) {
//
//                                    do {
//
//                                        try json.write(to: url, atomically: false, encoding: String.Encoding.utf8)
//
//                                    } catch {
//                                        print("erorr")
//                                        showError = true
//                                    }
//                                }
//                            }
////                            FirebaseStorageManager().uploadFile(localFile: url, serverFileName: "\(url.lastPathComponent)", userID: userData.userID, folderName: item.id.uuidString) { (isSuccess, url) in
////                                     print("uploadImageData: \(isSuccess), \(url)")
////                                }
////                            let url2 = URL(string: "https://araiapi.herokuapp.com/")
////
////                            guard let requestUrl = url2 else { fatalError() }
////                            // Prepare URL Request Object
////                            var request = URLRequest(url: requestUrl)
////                            request.httpMethod = "POST"
////                            do {
////                            // HTTP Request Parameters which will be sent in HTTP Request Body
////                            let postString = "id=\(item.id)&data=abc)"
////                            // Set HTTP Request Body
////                            request.httpBody = postString.data(using: String.Encoding.utf8)
////                            // Perform HTTP Request
////                            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
////
////                                    // Check for Error
////                                    if let error = error {
////                                        print("Error took place \(error)")
////                                        return
////                                    }
////
////                                    // Convert HTTP Response Data to a String
////                                    if let data = data, let dataString = String(data: data, encoding: .utf8) {
////                                        print("Response data string:\n \(dataString)")
////                                    }
//
//
////                            task.resume()
//
//
//
//
//
//
//        let timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { timer in
//            if notQueued {
//            checkQueue()
//            }
//            if !stopLogging {
//                if queue.queue.first == userID {
//            let url2 = URL(string: "https://araiapi.herokuapp.com/getLogs")
//
//                    if let url = url2 {
//                                        // Prepare URL Request Object
//                                        var request = URLRequest(url: url)
//                                        request.httpMethod = "GET"
//                                        do {
//                                        // HTTP Request Parameters which will be sent in HTTP Request Body
//                                       // let postString = "id=\(item.id)&data=abc)"
//                                        // Set HTTP Request Body
//                                        //request.httpBody = postString.data(using: String.Encoding.utf8)
//                                        // Perform HTTP Request
//                                        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//            let decoder = JSONDecoder()
//            if let data = data {
//                do {
//                    var note = try decoder.decode(Items.self, from: data)
//                    note.id = UUID().uuidString
//                    //note.process.replacingOccurrences(of: "--", with: " ")
//                    items.append(note)
//
//                    items = items.removeDuplicates()
//                    if  note.process.lowercased().contains("uploaded")  {
//                        stopLoop += 1
//                        if stopLoop > 14 {
//                            showError = true
//                        }
//                    }
//                    if  note.process.lowercased().contains("progress")  {
//                    withAnimation(.easeInOut) {
//                        progress = (Double(note.process.replacingOccurrences(of: "Progress--=--", with: "")) ?? 0.0) - 0.1
//                    }
//                    }
//                    if  note.process.lowercased().contains("error")  {
//
//                      showError = true
//                    }
//                    if  note.process.lowercased().contains("id")  {
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 30.0) {
//                        getUSDZ(id: note.process.replacingOccurrences(of: "ID=", with: ""))
//                        progress += 0.05
//                        //getModel(id: note.process.replacingOccurrences(of: "ID=", with: ""))
//                        stopLogging = true
//                       // }
//                        }
//                    }
//
//                } catch {
//                    print(error)
//                }
//            }
//        }
//                                            task.resume()
//                                        }
//        }
//
//                    }
//            }
//            }
//            }
//
//        }
//        }
//        }
//    }
//    func finished() {
////        DispatchQueue.main.asyncAfter(deadline: .now() + Double(15)) {
//////            if captureFolderState.captureDir?.appendingPathComponent("result.usdz").isFileURL {
//////        getUSDZ()
//////        }
////        }
//       // DispatchQueue.main.asyncAfter(deadline: .now() + Double(60)) {
//        let url2 = URL(string: "https://araiapi.herokuapp.com/isReady/")
//         if let url = url2 {
//
//             let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
//                 if let httpResponse = response as? HTTPURLResponse {
//                         print(httpResponse.statusCode)
//
//                 } else {
//
//                 }
//           //  }
//         }
//        }
////                         guard let data2 = data else { return }
////                 let decoder = JSONDecoder()
////
////             do {
////
////
////             } catch {
////
////             }
////             }
////             task.resume()
////         } else {
////
////         }
//    }
//
//    @State var showModel = false
//
//func leaveQueue() {
//    queue = Queue(queue: [String]())
//let url2 = URL(string: "https://araiapi.herokuapp.com/leaveQueue/")
//if let url = url2 {
//
//    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
//        if let httpResponse = response as? HTTPURLResponse {
//                print(httpResponse.statusCode)
//
//        } else {
//
//        }
//                guard let data2 = data else { return }
//        let decoder = JSONDecoder()
//
//    }
//    task.resume()
//
//}
//}
//    func getUSDZ(id: String) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + Double(30)) {
//        print("getting usdz")
//        let url2 = URL(string: "https://araiapi.herokuapp.com/getImage/?id=\(id).usdz")
//         if let url = url2 {
//
//             let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
//                 if let httpResponse = response as? HTTPURLResponse {
//                         print(httpResponse.statusCode)
//
//                 } else {
//                     print(error)
//                 }
//                         guard let data2 = data else { return print(error)
//                             for i in 0...20 {
//                                 print("jndksjikjdiwjdiidjiwjdiwjd")
//                             }
//                         }
//                 do {
//                 print(data2)
//                 let fileManager = FileManager()
//                 let currentWorkingPath = getDocumentsDirectory()
//                     var sourceURL = currentWorkingPath
//
//                     let destination = getDocumentsDirectory().appendingPathComponent("\(item.id).usdz")
//                 sourceURL.appendPathComponent("archive.zip")
////                     if fileManager.fileExists(atPath: destination.path ) {
////                         try? fileManager.removeItem(atPath: destination.path )
////                     }
//                     DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//                         do {
//                 try data2.write(to: destination)
//
////                             worldBlock = try Entity.load(contentsOf: destination)
////                             print(worldBlock)
//                             progress += 0.03
//                         } catch {
//                             print(error)
//                         }
//                     }
//                    print(data2)
//                     self.destination = destination
//                     DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
//                     success = true
//                     stopLogging = true
//                         progress += 0.02
//                         DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
//                         //leaveQueue()
//                         }
//                     }
//
//                     //let destination = documents.appendingPathComponent("\(item.id).usdz")
////                 do {
////
////                     try fileManager.unzipItem(at: sourceURL, to: destination)
////
////                 } catch {
////                     print("Extraction of ZIP archive failed with error:\(error)")
////                 }
//                 } catch {
//                     print(error)
//                 }
//             }
//             task.resume()
//         }
//
//    }
//    }
//    func joinQueue() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//        let url2 = URL(string: "https://araiapi.herokuapp.com/joinQueue/?userID=\(userID)")
//         if let url = url2 {
//
//             let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
//                 if let httpResponse = response as? HTTPURLResponse {
//                         print(httpResponse.statusCode)
//
//                 } else {
//                     print(error)
//                 }
//                         guard let data2 = data else { return }
//                 let decoder = JSONDecoder()
//             do {
//
//                     let note = try decoder.decode(Queue.self, from: data2)
//                 queue = note
//                 if note.queue.first != userID {
//                     let index = note.queue.firstIndex(where: { $0 == userID })
//                     items.append(Items(id: UUID().uuidString, process: "\(index ?? 0)/\(note.queue.count - 1) in queue"))
//                 }
//                 if note.queue.first == userID {
//                     captureFolderState.requestLoad()
//                     items.append(Items(id: UUID().uuidString, process: "Uploading Data"))
//                     //captureFolderState.requestLoad()
//                    // print(choosenFolder)
////                     let imgUrls = try FileManager.default
////                         .contentsOfDirectory(at: (captureFolderState.captureDir!), includingPropertiesForKeys: [],
////                                              options: [.skipsHiddenFiles])
////                         .filter { $0.isFileURL
////                             && $0.lastPathComponent.hasSuffix(CaptureInfo.imageSuffix)
////                         }
////                     print(try FileManager.default
////                            .contentsOfDirectory(at: (captureFolderState.captureDir!), includingPropertiesForKeys: [],
////                                                 options: [.skipsHiddenFiles]))
////                     let txtUrls = try FileManager.default
////                         .contentsOfDirectory(at: (captureFolderState.captureDir!), includingPropertiesForKeys: [],
////                                              options: [.skipsHiddenFiles])
////
////                         .filter { $0.isFileURL
////                             && $0.lastPathComponent.contains("TXT")
////                         }
////                     let depthUrls = try FileManager.default
////                         .contentsOfDirectory(at: (captureFolderState.captureDir!), includingPropertiesForKeys: [],
////                                              options: [.skipsHiddenFiles])
////
////                         .filter { $0.isFileURL
////                             && $0.lastPathComponent.contains("TIF")
////                         }
//                     let imgUrls = captureFolderState.captures.map{$0.imageUrl}
//                     let txtUrls = captureFolderState.captures.map{$0.gravityUrl}
//                     let depthUrls = captureFolderState.captures.map{$0.depthUrl}
//                         for i in imgUrls.indices {
//                             DispatchQueue.main.asyncAfter(deadline: .now() + Double(i/10)) {
//                                 if !(UIImage(contentsOfFile: imgUrls[i].path)?.pngData()?.isEmpty ?? true) {
//                                 if txtUrls.indices.contains(i) && depthUrls.indices.contains(i) {
//
//                                 uploadMultipleFiles(urls: [imgUrls[i], txtUrls[i]], i: i)
//
//
//                                 } else {
//                                     if txtUrls.indices.contains(i) {
//                                         uploadMultipleFiles(urls: [imgUrls[i], txtUrls[i]], i: i)
//                                     } else {
//
//                                         uploadMultipleFiles(urls: [imgUrls[i]], i: i)
//                                     }
//                                 }
//                             }
//                                 }
//                         }
//                     notQueued = false
//                 }
//             } catch {
//                print(error)
//             }
//             }
//             task.resume()
//         } else {
//
//         }
//        }
//    }
//    func setIDs(ids: [String]) {
//
//        let url2 = URL(string: "https://araiapi.herokuapp.com/setIDs/?ids=\(ids)")
//         if let url = url2 {
//
//             let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
//                 if let httpResponse = response as? HTTPURLResponse {
//                         print(httpResponse.statusCode)
//
//                 } else {
//                     //ready = true
//                 }
//             }
//             task.resume()
//    }
//    }
//    @State var uploaded = false
//    func checkQueue() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//        let url2 = URL(string: "https://araiapi.herokuapp.com/checkQueue/")
//         if let url = url2 {
//
//             let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
//                 if let httpResponse = response as? HTTPURLResponse {
//                         print(httpResponse.statusCode)
//
//                 } else {
//                     //ready = true
//                 }
//                         guard let data2 = data else { return }
//                 do {
//                 let decoder = JSONDecoder()
//                 let note = try decoder.decode(Queue.self, from: data2)
//             queue = note
//
//                 if note.queue.first != userID {
//                     let index = note.queue.firstIndex(where: { $0 == userID })
//                     if !items.map{ $0.process }.contains( "\(index ?? 0)/\(note.queue.count - 1) in queue") {
//                     items.append(Items(id: UUID().uuidString, process: "\(index ?? 0)/\(note.queue.count - 1) in queue"))
//                 }
//                 }
//
//
//
//
//                 if note.queue.first == userID {
//
//                     captureFolderState.requestLoad()
//                     items.append(Items(id: UUID().uuidString, process: "Uploading Data"))
//                     notQueued = false
//
//                     let imgUrls = try FileManager.default
//                         .contentsOfDirectory(at: (model.captureFolderState?.captureDir!)!, includingPropertiesForKeys: [],
//                                              options: [.skipsHiddenFiles])
//                         .filter { $0.isFileURL
//                             && $0.lastPathComponent.hasSuffix(CaptureInfo.imageSuffix)
//                         }
//                     let txtUrls = try FileManager.default
//                         .contentsOfDirectory(at: (model.captureFolderState?.captureDir!)!, includingPropertiesForKeys: [],
//                                              options: [.skipsHiddenFiles])
//
//                         .filter { $0.isFileURL
//                             && !$0.lastPathComponent.hasSuffix(CaptureInfo.imageSuffix)
//                         }
//
//
//                         for i in imgUrls.indices {
//                             DispatchQueue.main.asyncAfter(deadline: .now() + Double(i/10)) {
//                                 if !(UIImage(contentsOfFile: imgUrls[i].path)?.pngData()?.isEmpty ?? true) {
//
//                                 if txtUrls.indices.contains(i) {
//                                 uploadMultipleFiles(urls: [imgUrls[i], txtUrls[i]], i: i)
//                                 if i == imgUrls.count - 1 {
//
//                                 }
//                                 } else {
//                                     uploadMultipleFiles(urls: [imgUrls[i]], i: i)
//                                 }
//                                 }
//                             }
//                         }
//                     finished()
//
//
//                 }
//             } catch {
//                 //ready = true
//                 print(error)
//             }
//             }
//             task.resume()
//         } else {
//
//         }
//        }
//    }
////    func getModel(id: String) {
////        let storage = Storage.storage()
////                let path = "/" + id + "/"
////        let storageRef = storage.reference()
////                let riversRef = storageRef.child(path + "\(id).usdz")
////                print(path)
////        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
////
////  let destination = documents.appendingPathComponent("\(item.id).usdz")
////                 // You can also access to download URL after upload.
////                 riversRef.downloadURL { (url, error) in
////                   guard let downloadURL = url else {
////
////
////                     return print("error")
////
////                   }
////
////                     let url = downloadURL
////
////
////                            let session = URLSession(configuration: .default,
////                                                          delegate: nil,
////                                                     delegateQueue: nil)
////
////                     var request = URLRequest(url: url)
////                            request.httpMethod = "GET"
////
////                            let downloadTask = session.downloadTask(with: request, completionHandler: { (location: URL?,
////                                                      response: URLResponse?,
////                                                         error: Error?) -> Void in
////
////                                let fileManager = FileManager.default
////
////                                if fileManager.fileExists(atPath: destination.path ) {
////                                    try? fileManager.removeItem(atPath: destination.path )
////                                }
////
////                                try? fileManager.moveItem(atPath: location!.path,
////                                                          toPath: destination.path)
////                                success = true
//////                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [] in
//////                                    do {
//////
//////                                        do {
//////                                        try data2.write(to: destination)
//////
//////                                        } catch {
//////                                            print(error)
//////                                        }
//////
//////
//////                                    } catch {
//////                                        print("Fail loading entity.")
//////
//////                                    }
//////                                }
////
////
////                                                                    })
////
////                     downloadTask.resume()
////           stopLogging = true
////            }
////    }
//    func uploadMultipleFiles(urls: [URL], i: Int) {
//        var infos = [RestManager.FileInfo]()
//        for url in urls {
//
//           let uuid = String(i)
//            var newURL = self.getDocumentsDirectory().appendingPathComponent(String(i) + ".HEIC")
//            if url.lastPathComponent.contains("HEIC") {
//
//            do {
//                try UIImage(contentsOfFile: url.path)?.pngData()!.write(to: newURL)
//                let imageFileInfo = RestManager.FileInfo(withFileURL: url, filename: String(i) + ".HEIC", name: "uploadedFile", mimetype: "image/HEIC")
//                infos.append(imageFileInfo)
//            } catch {
//
//            }
//            } else if url.lastPathComponent.contains("TXT") {
//                 newURL = self.getDocumentsDirectory().appendingPathComponent(String(i) + ".txt")
//                do {
//                    try Data(contentsOf: url).write(to: newURL)
//                    let imageFileInfo = RestManager.FileInfo(withFileURL: newURL, filename: String(i) + ".txt", name: "uploadedFile", mimetype: "text/plain")
//                    infos.append(imageFileInfo)
//                } catch {
//
//                }
//            } else {
//                newURL = self.getDocumentsDirectory().appendingPathComponent(String(i) + ".TIFF")
//               do {
//                   try Data(contentsOf: url).write(to: newURL)
//                   let imageFileInfo = RestManager.FileInfo(withFileURL: newURL, filename: String(i) + ".TIFF", name: "uploadedFile", mimetype: "image/tiff")
//                   infos.append(imageFileInfo)
//               } catch {
//
//               }
//            }
//
//        }
//
//
//        upload(files: infos, toURL: URL(string: "https://araiapi.herokuapp.com/multiupload/")) { (success) -> Void in
//            if success {
//
//
//               // captureFolderState.captures = []
//                //captureFolderState.requestLoad()
//            }
//        }
//        finished()
//            sendPrint(text: "Uploaded Images")
//    }
//
//
//
//
//
//
//    func upload(files: [RestManager.FileInfo], toURL url: URL?, completion: (_ success: Bool) -> Void) {
//        if let uploadURL = url {
//            rest.upload(files: files, toURL: uploadURL, withHttpMethod: .post) { (results, failedFilesList) in
//                print("HTTP status code:", results.response?.httpStatusCode ?? 0)
//
//                if let error = results.error {
//                    print(error)
//                }
//                let decoder = JSONDecoder()
//                if let data = results.data {
//                    do {
//                        let note = try decoder.decode(Items.self, from: data)
//                        items.append(note)
//                    } catch {
//
//                    }
//                }
//
//                if let failedFiles = failedFilesList {
//                    for file in failedFiles {
//                        print(file)
//                    }
//                }
//            }
//        }
//
//        completion(true)
//    }
//
//
//
//
//
//
//
//func capturesFolder() -> URL? {
//        guard let documentsFolder =
//                try? FileManager.default.url(for: .documentDirectory,
//                                             in: .userDomainMask,
//                                             appropriateFor: nil, create: false) else {
//            return nil
//        }
//        return documentsFolder.appendingPathComponent("Captures/", isDirectory: true)
//    }
//      func creationDate(for url: URL) -> Date {
//        let date = try? url.resourceValues(forKeys: [.creationDateKey]).creationDate
//
//        if date == nil {
//            //logger.error("creation data is nil for: \(url.path).")
//            return Date.distantPast
//        } else {
//            return date!
//        }
//    }
//    func getDocumentsDirectory() -> URL {
//        // find all possible documents directories for this user
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//
//        // just send back the first one, which ought to be the only one
//        return paths[0]
//    }
//}
//extension String {
//    func components(withMaxLength length: Int) -> [String] {
//        return stride(from: 0, to: self.count, by: length).map {
//            let start = self.index(self.startIndex, offsetBy: $0)
//            let end = self.index(start, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
//            return String(self[start..<end])
//        }
//    }
//}
//
//struct MailView: UIViewControllerRepresentable {
//
//    @Binding var isShowing: Bool
//    @Binding var result: Result<MFMailComposeResult, Error>?
//
//    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
//
//        @Binding var isShowing: Bool
//        @Binding var result: Result<MFMailComposeResult, Error>?
//
//        init(isShowing: Binding<Bool>,
//             result: Binding<Result<MFMailComposeResult, Error>?>) {
//            _isShowing = isShowing
//            _result = result
//        }
//
//        func mailComposeController(_ controller: MFMailComposeViewController,
//                                   didFinishWith result: MFMailComposeResult,
//                                   error: Error?) {
//            defer {
//                isShowing = false
//            }
//            guard error == nil else {
//                self.result = .failure(error!)
//                return
//            }
//            self.result = .success(result)
//        }
//    }
//    func makeCoordinator() -> Coordinator {
//          return Coordinator(isShowing: $isShowing,
//                             result: $result)
//      }
//
//      func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
//          let vc = MFMailComposeViewController()
//          vc.mailComposeDelegate = context.coordinator
//          return vc
//      }
//
//      func updateUIViewController(_ uiViewController: MFMailComposeViewController,
//                                  context: UIViewControllerRepresentableContext<MailView>) {
//
//      }
//  }
//extension Dictionary {
//    func percentEncoded() -> Data? {
//        return map { key, value in
//            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
//            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
//            return escapedKey + "=" + escapedValue
//        }
//        .joined(separator: "&")
//        .data(using: .utf8)
//    }
//}
//
//extension CharacterSet {
//    static let urlQueryValueAllowed: CharacterSet = {
//        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
//        let subDelimitersToEncode = "!$&'()*+,;="
//
//        var allowed = CharacterSet.urlQueryAllowed
//        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
//        return allowed
//    }()
//}
//extension StringProtocol where Self: RangeReplaceableCollection {
//    var removingAllWhitespaces: Self {
//        filter(\.isWhitespace.negated)
//    }
//    mutating func removeAllWhitespaces() {
//        removeAll(where: \.isWhitespace)
//    }
//}
//extension Bool {
//    var negated: Bool { !self }
//}
