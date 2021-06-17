//
//  ConfettiView.swift
//  Model
//
//  Created by Andreas on 6/9/21.
//

import SwiftUI
struct ConfettiView: View {
    @State private var animate = false
    @State private var xSpeed = Double.random(in: 0.7...2)
    @State private var zSpeed = Double.random(in: 1...2)
    @State private var anchor = CGFloat.random(in: -1...1).rounded()
    @State private var color = UIColor(red: 0.608, green: 0.349, blue: 0.714, alpha: 1.0)
    let purple = UIColor(red: 0.608, green: 0.349, blue: 0.714, alpha: 1.0)
    let blue = UIColor(red: 0.906, green: 0.302, blue: 0.243, alpha: 1.0)
    let red = UIColor(red: 0.204, green: 0.596, blue: 0.859, alpha: 1.0)
    @State private var stop = false
    @State private var x: CGFloat = CGFloat.random(in: 0...500).rounded()
    @State private var y: CGFloat = -1000
    var body: some View {
        ZStack {
            Color(.clear)
                .onAppear() {
                    
                    let colors = Int.random(in: 0..<3)
                    if colors == 0 {
                        color = purple
                    } else if colors == 1 {
                        color = red
                    } else if colors == 2 {
                        color = blue
                    }
                    
                        withAnimation(.easeOut(duration: Double.random(in: 2..<4))) {
                            y = 1000
                            
                        }
                        
                    
                    }
                }
                
            Rectangle()
                .foregroundColor(Color(color))
                .frame(width: 20, height: 20, alignment: .center)
                .onAppear(perform: { animate = true })
                .rotation3DEffect(.degrees(animate ? 360:0), axis: (x: 1, y: 0, z: 0))
                .animation(Animation.linear(duration: xSpeed).repeatForever(autoreverses: false))
                .rotation3DEffect(.degrees(animate ? 360:0), axis: (x: 0, y: 0, z: 1), anchor: UnitPoint(x: anchor, y: anchor))
                .animation(Animation.linear(duration: zSpeed).repeatForever(autoreverses: false))
                .position(CGPoint(x: x, y: y))
        //.opacity(stop ? 0 : 1)
                
        }
    }

