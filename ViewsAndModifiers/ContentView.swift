//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Dmitry Reshetnik on 20.01.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
//    @State private var useRedText = false
//    let motto1 = Text("Draco dormiens")
//    let motto2 = Text("nunquam titillandus")
    
    var body: some View {
//        Text("Hello, World!").frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.red).edgesIgnoringSafeArea(.all)
//        Button("Hello World") {
//            print(type(of: self.body))
//        }.frame(width: 200, height: 200).background(Color.red)
//        Text("Hello World").padding().background(Color.red).padding().background(Color.blue).padding().background(Color.green).padding().background(Color.yellow)
//        TupleView<(C0, C1, C2, C3, C4, C5, C6, C7, C8, C9)>
//        Button("Hello World") {
//            // flip the Boolean between true and false
//            self.useRedText.toggle()
//        }.foregroundColor(useRedText ? .red : .blue)
//        VStack {
//            Text("Gryffindor").font(.largeTitle).blur(radius: 0)
//            Text("Hufflepuff")
//            Text("Ravenclaw")
//            Text("Slytherin")
//            }.font(.title).blur(radius: 5)
//        VStack {
//            motto1.foregroundColor(.red)
//            motto2.foregroundColor(.blue)
//        }
//        VStack(spacing: 10) {
//            CapsuleText(text: "First")
//                .foregroundColor(.white)
//            CapsuleText(text: "Second")
//                .foregroundColor(.yellow)
//            Text("Hello World")
//                .titleStyle()
//            Color.blue
//                .frame(width: 300, height: 200)
//            .watermark(with: "Hacking with Swift")
//        }
        GridStack(rows: 4, columns: 4) { row, col in
            //HStack {
                Image(systemName: "\(row * 4 + col).circle")
                Text("R\(row) C\(col)")
            //}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            //.foregroundColor(.white)
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
    
    func watermark(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}

struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows) { row in
                HStack {
                    ForEach(0..<self.columns) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
    
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}
