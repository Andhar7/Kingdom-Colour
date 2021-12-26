//
//  Kingdom.swift
//  Kingdom Colour
//
//  Created by Andrej Kling on 22.12.21.
//

import SwiftUI

struct Kingdom: Identifiable, Hashable {
    
    var id = UUID().uuidString
    var name : String
    var color : Color
    var poem : String
    var hex : String
   
}


