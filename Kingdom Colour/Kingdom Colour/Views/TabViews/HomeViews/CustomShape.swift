//
//  CustomShape.swift
//  Kingdom Colour
//
//  Created by Andrej Kling on 22.12.21.
//

import SwiftUI

struct CustomShape: Shape {
 
    func path(in rect: CGRect) -> Path {
        
        return Path{path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            // Custom Inner Rectangle Shape...
            let midWidth = rect.width / 2
            
            path.addLine(to: CGPoint(x: midWidth - 80, y: rect.height))
            path.addLine(to: CGPoint(x: midWidth - 70, y: rect.height - 25))
            
            path.addLine(to: CGPoint(x: midWidth + 70, y: rect.height - 25))
            
            path.addLine(to: CGPoint(x: midWidth + 80, y: rect.height))
            
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            
        }
    }
}

struct CustomShape_Previews: PreviewProvider {
    static var previews: some View {
        CustomShape()
    }
}
