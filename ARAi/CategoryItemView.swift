//
//  CategoryItemView.swift
//  Model
//
//  Created by Andreas on 6/8/21.
//

import SwiftUI

struct CategoryItemView: View {

    @State  var category: Category
    @Binding var pickedCategory: Category
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut) {
            pickedCategory = category
            }
        }) {
            
        ZStack {
            LinearGradient(gradient: Gradient(colors:  [Color(category.colors[0]), Color(category.colors[1])]), startPoint: .topLeading, endPoint: .bottom).clipShape(RoundedRectangle(cornerRadius: 25))
                .frame(maxWidth: 115, maxHeight: 150)
                .shadow(
                    color: Color(category.colors[0]).opacity( 0.2),
                  radius: 18,
                  x: -18,
                  y: -18)
                .shadow(
                    color: Color(category.colors[1]).opacity( 0.2),
                  radius: 14,
                  x: 14,
                  y: 14)
            VStack {
                if category.name == "2020 Classics" {
                    Text("2020")
                        .font(.custom("Karla-Medium", size: 22, relativeTo: .headline))
                        .foregroundColor(Color("altText"))
                        .frame(width: 75, height: 75)
                        .padding()
                        
                } else {
                (category.name == "Your Models" ? Image(systemName: "cube") : Image(category.name))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75)
                .foregroundColor(Color("altText"))
                .padding()
                }
            Text(category.name)
                .font(.custom("Karla-Medium", size: 12, relativeTo: .headline))
                .foregroundColor(Color("altText"))
                .padding()
                
            }
        }
        } .padding()
            .buttonStyle(CatButtonStyle())
           
    }
}
