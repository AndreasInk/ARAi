//
//  LeadingTextView.swift
//  Model
//
//  Created by Andreas on 6/8/21.
//

import SwiftUI

struct LeadingTextView: View {
    @State  var text = ""
    @State  var font = "Karla-Medium"
    @State  var size: CGFloat = 18
    @State  var opacity = 1.0
    var body: some View {
        HStack {
           
        Text(text)
            .foregroundColor(Color("text"))
    .font(.custom(font, size: size, relativeTo: .headline))
            .opacity(opacity)
            Spacer()
    }
}
}
