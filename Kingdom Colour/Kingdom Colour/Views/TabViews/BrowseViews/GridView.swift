//
//  GridView.swift
//  Kingdom Colour
//
//  Created by Andrej Kling on 23.12.21.
//

import SwiftUI

struct GridView : View {
    
    var kingdom : Kingdom
    
    @Binding var columns : [GridItem]
    
    @EnvironmentObject var sharedData : KingdomViewModel
    
    @Namespace var names
    
    var body: some View {
        
        VStack {
            
            if self.columns.count == 2 {
                
                firstCondition()
  
            } else {
                
                secondCondition()
        
            }
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        BrowseView()
            .environmentObject(KingdomViewModel())
    }
}

extension GridView {
    
    func isLiked() -> Bool {
        
        return sharedData.likedColours.contains { product in
            
            return self.kingdom.id == product.id
        }
    }

    
    func addToLike() {
        
        if let index = sharedData.likedColours.firstIndex(where: { product in
            
            return self.kingdom.id == product.id
            
        }){
            
            sharedData.likedColours.remove(at: index)
            
        } else {
            
            sharedData.likedColours.append(kingdom)
        }
    }
    
    @ViewBuilder
    func firstCondition() -> some View {
        
        VStack(spacing: 15) {
            
            ZStack(alignment: .topTrailing) {
                
                Rectangle()
                    .fill(kingdom.color)
                    .frame(height: 240)
                    .cornerRadius(15)
                
                Button(action: {
                    addToLike()
                }, label: {
                    Image("like")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "heart.fill", in: self.names)
                        .frame(width: 22, height: 22)
                        .foregroundColor(isLiked() ? Color.red : Color.white.opacity(0.8))
                        .padding(.all, 12)
                        .background(Color.white.opacity(0.2))
                        .clipShape(Circle())
                })
                    .padding(.all, 12)
            }
            .matchedGeometryEffect(id: "color", in: self.names)
            
            Text(kingdom.name)
               .font(.system(size: 21, weight: .regular, design: .serif))
               .foregroundColor(.white)
               .textSelection(.enabled)
               .matchedGeometryEffect(id: "name", in: self.names)
               .lineLimit(1)
               .shadow(color: Color.white, radius: 3, x: 2, y: 2)
        }
        
    }
    
    @ViewBuilder
    func secondCondition() -> some View {
        
        HStack(spacing: 15) {
            
            ZStack(alignment: .topTrailing) {
                
                ZStack(alignment: .center) {
                    
                    Rectangle()
                        .fill(kingdom.color)
                        .frame(width: (UIScreen.main.bounds.width) / 2.1, height: 240)
                        .cornerRadius(15)
                    
                    Text(kingdom.poem)
                        .font(.system(size: 14, weight: .regular, design: .serif))
                        .foregroundColor(.white)
                        .textSelection(.enabled)
                        .multilineTextAlignment(.center)
                        .padding(12)
                    
                    
                }
                .matchedGeometryEffect(id: "color", in: self.names)
                
                Button(action: {
                    addToLike()
                }, label: {
                    Image("like")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "heart.fill", in: self.names)
                        .frame(width: 18, height: 18)
                        .foregroundColor(isLiked() ? Color.red : Color.white.opacity(0.8))
                        .padding(.all, 8)
                        .background(Color.white.opacity(0.2))
                        .clipShape(Circle())
                })
                    .padding(.all, 12)
            }
            
            VStack(spacing: 5) {
                
                Text(kingdom.name)
                   .font(.system(size: 18, weight: .regular, design: .serif))
                   .foregroundColor(.white)
                   .textSelection(.enabled)
                   .matchedGeometryEffect(id: "name", in: self.names)
                   .lineLimit(1)
                   .shadow(color: Color.white, radius: 3, x: 2, y: 2)
                
                HStack(spacing: 10){
                    
                    ForEach(1...5,id: \.self){rating in
                        
                        Image(systemName: "star.fill")
                            .imageScale(.small)
                            .foregroundColor(.yellow )
                    }
                    
                    Spacer(minLength: 0)
                }
                .padding(.leading, 5)
                
//                Text(kingdom.poem)
//                   .font(.system(size: 14, weight: .regular, design: .serif))
//                   .foregroundColor(.white)
//                   .textSelection(.enabled)
            }
        }
        .padding(.trailing)
        .background(Color.blue)
        .cornerRadius(15)
    }
}
