//
//  CircularProgressView.swift
//  Model
//
//  Created by Andreas on 6/8/21.
//

import SwiftUI


struct CircularProgressView: View {
    @Binding var progress: Float
    @State private var width: CGFloat = 2.0
    @State private var width2: CGFloat = 55.0
    @State private var size: CGFloat = 10.0
    var body: some View {
        VStack {
        ZStack {
            Circle()
                .stroke(lineWidth: width)
                .opacity(0.3)
                .foregroundColor(Color("teal"))
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: width, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color("teal"))
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)

            
           
            Text(String(Int(progress*100)) + "%")
                .font(.custom("Karla-Medium", size: size, relativeTo: .headline))
                .multilineTextAlignment(.center)
              .padding()
        } .frame(width: width2, height: width2)
//            
        }
    }
}
