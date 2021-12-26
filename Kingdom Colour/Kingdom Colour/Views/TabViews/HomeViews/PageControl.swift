//
//  PageControl.swift
//  Kingdom Colour
//
//  Created by Andrej Kling on 22.12.21.
//

import SwiftUI

struct PageControl: UIViewRepresentable{
 
    var maxPages: Int
    var currentPage : Int
    
    func makeUIView(context: Context) -> some UIPageControl {
        
        let control = UIPageControl()
        control.backgroundStyle = .minimal
        control.numberOfPages = maxPages
        control.currentPage = currentPage
        
        return control
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.currentPage = currentPage
    }
    
}

 
