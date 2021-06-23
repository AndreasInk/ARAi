//
//  UserData.swift
//  Model
//
//  Created by Andreas on 6/8/21.
//

import Foundation
import SwiftUI
import Combine

final class UserData: ObservableObject {
    
    public static let shared = UserData()
    
    @Published(key: "firstRun")
    var firstRun: Bool = true
    
    @Published(key: "showOnboarding")
    var showOnboarding: Bool = true
    
    @Published(key: "usedFreeScan")
    var usedFreeScan: Bool = false
    
    @Published(key: "scans")
    var scans: Int = 5
    
    @Published(key: "userID")
    var userID: String = UUID().uuidString
    
    @Published(key: "savedPaths")
    var savedPaths: [String] = [String]()
    
    @Published(key: "category")
    var category = "Fruits"
    
    @Published(key: "fcm")
    var fcm = ""
    
    
    var tapped = false
    
    @Published(key: "itemIDs")
    var itemIDs = [String]()
    
  
    var reload = 0
    
    var instruct = true
    
    var loading = false
    
    var isYourModels = false
    
}

import Foundation
import CryptoKit

extension UserDefaults {
    
    public struct Key {
        public static let lastFetchDate = "lastFetchDate"
    }
    
    @objc dynamic public var lastFetchDate: Date? {
        return object(forKey: Key.lastFetchDate) as? Date
    }
}

import Foundation
import Combine

extension Published {
    
    init(wrappedValue defaultValue: Value, key: String) {
        let value = UserDefaults.standard.object(forKey: key) as? Value ?? defaultValue
        self.init(initialValue: value)
        projectedValue.receive(subscriber: Subscribers.Sink(receiveCompletion: { (_) in
            ()
        }, receiveValue: { (value) in
            UserDefaults.standard.set(value, forKey: key)
        }))
    }
    
}
