//
//  KingdomViewModel.swift
//  Kingdom Colour
//
//  Created by Andrej Kling on 22.12.21.
//

import SwiftUI
import Combine

class KingdomViewModel: ObservableObject {
    
    @Published var searchText : String = ""
    @Published var searchActivated : Bool = false
    @Published var fromSearchPage: Bool = false
    @Published var searchProduct : [Kingdom]?
    
    var searchCancellable : AnyCancellable?
    
    init() {
        
        searchCancellable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                
                if str != "" {
                    
                    self.filterProductBySearch()
                    
                } else {
                    
                    self.searchProduct = nil
                    
                }
            })
        
    }
    
    func filterProductBySearch() {
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let results = self.dataModel
                .lazy
                .filter { product in
                    
                    return product.name.lowercased().contains(self.searchText.lowercased())
                }
            
            DispatchQueue.main.async {
                
                self.searchProduct = results.compactMap({ product in
                    
                    return product
                })
            }
        }
    }
    
    @Published var likedColours : [Kingdom] = []
    
    @Published var dataModel : [Kingdom] = [
    
        Kingdom(name: "Joy", color: Color("joy"), poem: "Joy alone has the capacity to shorten our way to God-realisation.", hex: "F5B29B"),
        Kingdom(name: "Enthusiasm", color: Color("enthusiasm"), poem: "God's Dreamboat treasures a man of soaring enthusiasm.", hex: "6CB31C"),
        Kingdom(name: "Consciousness", color: Color("consciousness"), poem: "The role of consciousness is to deepen silence and expand sound.", hex:"4C7DB1"),
        Kingdom(name: "Victory", color: Color("victory"), poem: "The victory of human love is confusing.The victory of divine love is illumining.\nThe victory of supreme love is fulfilling.", hex: "FEAC38"),
        Kingdom(name: "Beauty", color: Color("beauty"), poem: "A life of constant duty is a life of supernal beauty.", hex: "D669CB"),
        Kingdom(name: "Confidence", color: Color("confidence"), poem: "Confidence is not in doing or becoming but in being.", hex: "51A931"),
        Kingdom(name: "Confusion",  color:  Color("confusion"),  poem: "How far is confusion-night from Illumination-light?\nIt is as far as man’s doubting mind and man’s loving heart.", hex: "464854"),
        Kingdom(name: "Delight", color: Color("delight"), poem: "Human surrender is slavery, perpetual slavery.\nDivine surrender is delight, constant delight.", hex: "FE571D"),
        Kingdom(name: "Destination", color: Color("destination"), poem: "Love divine is the destination of the ever-transcending Beyond.", hex: "B9E5E8"),
        Kingdom(name: "Destruction", color: Color("destruction"), poem: "The destruction of the vital is at times necessary for the purification of the heart and for the perfection of life.", hex: "5E2D01"),
        Kingdom(name: "Determination", color: Color("determination"), poem: "A heart of determination is a son of God’s achievement-glorification.", hex: "E48F42"),
        Kingdom(name: "Devotion", color: Color("devotion"), poem: "Attachment illumined, love intensified, devotion divinised: surrender immortalised.", hex: "8E9E01"),
        Kingdom(name: "Glory", color: Color("glory"), poem: "Man’s human glory begins when his animal story ends.\nHis divine glory begins when his human story ends.\nHis supreme Glory has neither birth nor death.", hex: "DC6CB8")
    
    ]
}
 
