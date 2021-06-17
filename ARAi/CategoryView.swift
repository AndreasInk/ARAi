//
//  CategoryView.swift
//  Model
//
//  Created by Andreas on 6/8/21.
//

import SwiftUI

struct CategoryView: View {

    @Binding var categories: [Category]
    @Binding var pickedCategory: Category
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
            ForEach(categories, id: \.self) { category in
            
                
                CategoryItemView( category: category, pickedCategory: $pickedCategory)
                   
            }
        } 
              
        }
       
}
    
}
