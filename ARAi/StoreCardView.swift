//
//  StoreCardView.swift
//  Model
//
//  Created by Andreas on 6/8/21.
//

import SwiftUI
import AVFoundation
import SwiftyStoreKit

struct StoreCardView: View {
    @State  var title: String
    @State  var text: String
    @State  var price: Double
    @State  var image: String
    @State  var audioName: String
    @State private var upload = false
    @State private var success = false
    @State private var camera = false
    @ObservedObject var userData: UserData
    let productIDs = [
        "com.ai.model.one",
        "com.ai.model.three",
        "com.ai.model.energydrink"
    ]
    @Environment(\.presentationMode) private var presentation
    @State var categories: [Category]
    var body: some View {
        ZStack {
            Color("Background")
                .opacity(0.4)
                
            VStack {
               
                HStack {
                    if text == "Support Andreas" {
                    
                        LinearGradient.lairHorizontalDark
                          .mask(Image(image).resizable().scaledToFit().padding())
                          
                          .frame(width: 200, height: 200)
                        
                    }
                    VStack {
            HStack {
            Text(title)
                .font(.custom("Karla-Medium", size: 18, relativeTo: .headline))
                
                Spacer()
            }
            HStack {
                Text("$\(price.removeZerosFromEnd())")
                .font(.custom("Karla-Medium", size: 18, relativeTo: .headline))
                Spacer()
                if text != "Support Andreas" {
                
            }
                       
                    }
            }
                }
                Button(action: {
//                    if title == "Alarm" {
//                        storeManager.purchaseProduct(product: storeManager.myProducts[0])
//                        if storeManager.transactionState == .purchased {
//                        userData.alarm = true
//                        alarm = true
//                        }
//
//                    }
                    if !userData.usedFreeScan {
//                    if title == "One Free Scan" {
//                        userData.scans += 1
//                        upload = true
//                        
//                    }
                    }
                    
                    if title == "One Download" {
                        
                        SwiftyStoreKit.purchaseProduct("com.ai.model.one", quantity: 1, atomically: true) { result in
                            switch result {
                            case .success(let purchase):
                                print("Purchase Success: \(purchase.productId)")
                                #warning("add file with firebase")
                                success = true
                                userData.scans += 1
                            case .error(let error):
                                switch error.code {
                                case .unknown: print("Unknown error. Please contact support")
                                case .clientInvalid: print("Not allowed to make the payment")
                                case .paymentCancelled: break
                                case .paymentInvalid: print("The purchase identifier was invalid")
                                case .paymentNotAllowed: print("The device is not allowed to make the payment")
                                case .storeProductNotAvailable: print("The product is not available in the current storefront")
                                case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                                case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                                case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                                default: print((error as NSError).localizedDescription)
                                }
                            }
                        }
                       
                    }
                    if title == "Three Downloads" {
                        
                        SwiftyStoreKit.purchaseProduct("com.ai.model.three", quantity: 1, atomically: true) { result in
                            switch result {
                            case .success(let purchase):
                                print("Purchase Success: \(purchase.productId)")
                                #warning("add file with firebase")
                            
                                success = true
                                userData.scans += 3
                            case .error(let error):
                                switch error.code {
                                case .unknown: print("Unknown error. Please contact support")
                                case .clientInvalid: print("Not allowed to make the payment")
                                case .paymentCancelled: print("Not allowed to make the payment")
                                case .paymentInvalid: print("The purchase identifier was invalid")
                                case .paymentNotAllowed: print("The device is not allowed to make the payment")
                                case .storeProductNotAvailable: print("The product is not available in the current storefront")
                                case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                                case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                                case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                                default: print((error as NSError).localizedDescription)
                                }
                            }
                        }
                       
                    }
                    
                   
//                    if title == "Male Voice" {
//                        storeManager.purchaseProduct(product: storeManager.myProducts[3])
//                        if storeManager.transactionState == .purchased {
//                        userData.male = true
//                        male1 = true
//                        }
//                    }
//                    if title == "Male Voice 2" {
//                        storeManager.purchaseProduct(product: storeManager.myProducts[4])
//                        if storeManager.transactionState == .purchased {
//                        userData.male2 = true
//                        male2 = true
//                        }
//                    }
                    if text == "Support Andreas" {
                        
                        SwiftyStoreKit.purchaseProduct("com.ai.model.energydrink", quantity: 1, atomically: true) { result in
                            switch result {
                            case .success(let purchase):
                                print("Purchase Success: \(purchase.productId)")
                                success = true
                                userData.scans += 10
                            case .error(let error):
                                switch error.code {
                                case .unknown: print("Unknown error. Please contact support")
                                case .clientInvalid: print("Not allowed to make the payment")
                                case .paymentCancelled: break
                                case .paymentInvalid: print("The purchase identifier was invalid")
                                case .paymentNotAllowed: print("The device is not allowed to make the payment")
                                case .storeProductNotAvailable: print("The product is not available in the current storefront")
                                case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                                case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                                case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                                default: print((error as NSError).localizedDescription)
                                }
                            }
                        }
                        
                    }
                }) {
                    ZStack {
                        
                       
                        Text(text)
                            .font(.custom("Karla-Medium", size: 20, relativeTo: .headline))
                            
                    }
                } .buttonStyle(CTAButtonStyle2())
              
            } .padding()
               
                .sheet(isPresented: $success) {
                    ZStack {
                    VStack {
                        Spacer()
                        Text("Thank You!")
                            .font(.custom("Karla-Medium", size: 24, relativeTo: .headline))
                            .multilineTextAlignment(.center)
                            .padding()
                           
                        Text("You just helped a college student pay for university and you can now scan more objects!")
                            .font(.custom("Karla-Medium", size: 24, relativeTo: .headline))
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        if text == "Support Andreas" {
                            Text("Since you gave me an energy drink, here are ten downloads!")
                                .font(.custom("Karla-Medium", size: 32, relativeTo: .headline))
                                .multilineTextAlignment(.center)
                                .padding()
                               
                        }
                        Spacer()
                        
                        Button(action: {
                            success = false
                           
                            presentation.wrappedValue.dismiss()
                        }) {
                            ZStack {
                               
                              
                                Text("Back to Downloading!")
                                    .font(.custom("Karla-Medium", size: 20, relativeTo: .headline))
                                    
                            }
                        } .buttonStyle(CTAButtonStyle2())

                    }
                        ForEach(0 ..< 20) { number in
                                            ConfettiView()
                                            }
                    }
                }
           
        }
    }
   @State  var player: AVAudioPlayer?

    func playSound() {
        guard let url = Bundle.main.url(forResource: audioName, withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback,  options: .mixWithOthers)
            
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
       
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            do {
                
                
                try AVAudioSession.sharedInstance().setActive(false)
            } catch {
            }
            
        }
}
}

extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}
