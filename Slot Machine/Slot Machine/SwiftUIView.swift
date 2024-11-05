//
//  SwiftUIView.swift
//  Slot Machine
//
//  Created by english on 2024-09-16.
//

import SwiftUI


struct Hexagonal: Shape {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
   func path(in rect: CGRect) -> Path {
       // p1 -> p6
       return Path { // callback function
           path in
           // six point of the hexagon
           let p1 = CGPoint(x: 0, y: 20)
           let p2 = CGPoint(x: 0, y: rect.height - 20)
           let p3 = CGPoint(x: rect.width/2, y: rect.height)
           let p4 = CGPoint(x: rect.width, y: rect.height - 20)
           let p5 = CGPoint(x: rect.width, y: 20)
           let p6 = CGPoint(x: rect.width/2, y: 0)
           
           // cursor for our path to move
           path.move(to: p6) // either the first p1 or last p6
           
           // move the cursor
           path.addArc(tangent1End: p1, tangent2End: p2, radius: 15)
           path.addArc(tangent1End: p2, tangent2End: p3, radius: 15)
           path.addArc(tangent1End: p3, tangent2End: p4, radius: 15)
           path.addArc(tangent1End: p4, tangent2End: p5, radius: 15)
           path.addArc(tangent1End: p5, tangent2End: p6, radius: 15)
           path.addArc(tangent1End: p6, tangent2End: p1, radius: 15)

           
       }
   }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Hexagonal()
            .frame(width:100, height:120,alignment: .center)
    }
}
