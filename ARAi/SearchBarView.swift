//
//  SearchBarView.swift
//  Model
//
//  Created by Andreas on 6/8/21.
//

import SwiftUI

struct SearchBarView: View {
    @State private var search: String = ""
    @Binding var categories: [Category]
    @Binding var category: Category
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(Color("blue").opacity(0.2))
                .frame(height: 65)
                .shadow(
                    color: Color("blue").opacity( 0.6),
                  radius: 18,
                  x: -18,
                  y: -18)
                .shadow(
                    color: Color("blue").opacity( 0.6),
                  radius: 14,
                  x: 14,
                  y: 14)
        HStack {
            Image(systemName: "magnifyingglass")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.leading)
        TextField("Search", text: $search)
                .foregroundColor(.white)
                .textFieldStyle(PlainTextFieldStyle())
        }
       
        .onChange(of: search, perform: { value in
           
            var items = [Item]()
            for i in categories.map({$0.items}) {
                for item in i {
                if item.name.lowercased().contains(search.lowercased()) {
                    items.append(item)
                }
                }
          
              }
            category = Category(id: UUID(), name: search, description: "", items: items, colors: ["blue", "purple"])
        })
        
        } .padding(.horizontal)
        
    }
}
