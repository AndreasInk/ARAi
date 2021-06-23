//
//  SearchBarView.swift
//  Model
//
//  Created by Andreas on 6/8/21.
//

import SwiftUI
import Combine
struct SearchBarView: View {
    @State private var search: String = ""
    @Binding var categories: [Category]
    @Binding var category: Category
    private var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> {
    Publishers.Merge(
                NotificationCenter.default
                    .publisher(for: UIResponder.keyboardWillShowNotification)
                    .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
                    .map { $0.height },
                NotificationCenter.default
                    .publisher(for: UIResponder.keyboardWillHideNotification)
                    .map { _ in
        var items = [Item]()
        for i in categories.map({$0.items}) {
                        for item in i {
                            if item.name.lowercased().contains(search.lowercased()) {
                                items.append(item)
                            }
                        }
                        
                    }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        withAnimation(.easeInOut) {
        category = Category(id: UUID(), name: search, description: "", items: items, colors: ["blue", "purple"])
        }
        }
        return CGFloat(0)}
                
    ).eraseToAnyPublisher()
    }

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
        .onAppear() {
           
                   
        }
        .onReceive(keyboardHeightPublisher) {  $0 }
        
    
//        .onChange(of: search, perform: { value in
//
//
//        })
        
        } .padding(.horizontal)
        
    }
}
