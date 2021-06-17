//
//  Item.swift
//  Model
//
//  Created by Andreas on 6/8/21.
//

import SwiftUI
import RealityKit
struct Category: Codable, Hashable {
    var id: UUID
    var name: String
    var description: String
    var items: [Item]
    var colors: [String]
}

struct Item: Codable, Hashable {
    var id: UUID
    var name: String
    var description: String
    var progress: Float
    var result: Data
    
}
