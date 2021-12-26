//
//  KingdomHome.swift
//  Kingdom Colour
//
//  Created by Andrej Kling on 25.12.21.
//

import SwiftUI

struct KingdomHome: Identifiable, Hashable {
   
    var id = UUID().uuidString
    var name : String
    var color : Color
    var poem : String
    var hex : String
    
}

var data  = [

  KingdomHome(name: "Joy", color: Color("joy"), poem: "Joy alone has the capacity to shorten our way to God-realisation.", hex: "F5B29B"),
  KingdomHome(name: "Enthusiasm", color: Color("enthusiasm"), poem: "God's Dreamboat treasures a man of soaring enthusiasm.", hex: "6CB31C"),
  KingdomHome(name: "Consciousness", color: Color("consciousness"), poem: "The role of consciousness is to deepen silence and expand sound.", hex:"4C7DB1"),
  KingdomHome(name: "Victory", color: Color("victory"), poem: "The victory of human love is confusing.\nThe victory of divine love is illumining.\nThe victory of supreme love is fulfilling.", hex: "FEAC38"),
  KingdomHome(name: "Beauty", color: Color("beauty"), poem: "A life of constant duty is a life of supernal beauty.", hex: "D669CB"),
  KingdomHome(name: "Confidence", color: Color("confidence"), poem: "Confidence is not in doing or becoming but in being.", hex: "51A931"),
  KingdomHome(name: "Confusion",  color:  Color("confusion"),  poem: "How far is confusion-night from Illumination-light?\nIt is as far as man’s doubting mind and man’s loving heart.", hex: "464854"),
  KingdomHome(name: "Delight", color: Color("delight"), poem: "Human surrender is slavery, perpetual slavery.\nDivine surrender is delight, constant delight.", hex: "FE571D"),
  KingdomHome(name: "Destination", color: Color("destination"), poem: "Love divine is the destination of the ever-transcending Beyond.", hex: "B9E5E8"),
  KingdomHome(name: "Destruction", color: Color("destruction"), poem: "The destruction of the vital is at times necessary for the purification of the heart and for the perfection of life.", hex: "5E2D01"),
  KingdomHome(name: "Determination", color: Color("determination"), poem: "A heart of determination is a son of God’s achievement-glorification.", hex: "E48F42"),
  KingdomHome(name: "Devotion", color: Color("devotion"), poem: "Attachment illumined, love intensified, devotion divinised: surrender immortalised.", hex: "8E9E01"),
  KingdomHome(name: "Glory", color: Color("glory"), poem: "Man’s human glory begins when his animal story ends.\nHis divine glory begins when his human story ends.\nHis supreme Glory has neither birth nor death.", hex: "DC6CB8")

]

 
