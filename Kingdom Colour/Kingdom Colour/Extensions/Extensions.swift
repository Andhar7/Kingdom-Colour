//
//  Extensions.swift
//  Kingdom Colour
//
//  Created by Andrej Kling on 22.12.21.
//

import SwiftUI

extension View {
    
    func getSaveArea() -> UIEdgeInsets {
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            
            return .zero
        }
        
        return safeArea
    }
    
    
    func getRect() -> CGRect {
        
        return UIScreen.main.bounds
    }
}

