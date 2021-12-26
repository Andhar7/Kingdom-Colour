//
//  About.swift
//  Kingdom Colour
//
//  Created by Andrej Kling on 23.12.21.
//

import SwiftUI

struct About: Codable, Identifiable, Hashable {
    
    var id  : String  { name }
    var imageName: String
    var name: String
    var description: String
    
}

var person: [About] = load("about.json")
 
func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
