//
//  SlideMenuView.swift
//  Kingdom Colour
//
//  Created by Andrej Kling on 22.12.21.
//

import SwiftUI

struct SlideMenuView: View {
    
    @Binding var currentTab : String
    
    @Namespace var animation
    
    var body: some View {
        
        VStack {
            
            topView()
            
            Divider()
                .background(.white)
            
            ScrollView(getRect().height < 750 ? .vertical : .init(), showsIndicators: false){
                
                VStack(alignment: .leading, spacing: 21) {
                    
                    CustomButton(icon: "house", title: "Home")
                    
                    Divider()
                        .background(.white)
                    
                    CustomButton(icon: "eyedropper.full", title: "Browse")
                    
                    Divider()
                        .background(.white)
                    
                    CustomButton(icon: "sparkle.magnifyingglass", title: "Search")
                    
                    Divider()
                        .background(.white)
                    
                    CustomButton(icon: "heart.fill", title: "Favourite")
                    
                    Divider()
                        .background(.white)
                    
                    CustomButton(icon: "person.fill", title: "About")
                    
                    Divider()
                        .background(.white)
                    
                }
                .padding()
                .padding(.top, 42)
            }
            .frame(width: getRect().width / 2.1 , alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame( maxWidth: .infinity,   maxHeight: .infinity, alignment: .top)
        .background(Color("BG"))
    }
}

struct SlideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SlideMenuView(currentTab: .constant("Home"))
    }
}

extension SlideMenuView {
    
    @ViewBuilder
    func CustomButton(icon: String, title: String) -> some View {
        
        Button(action: {
            withAnimation{
                currentTab = title
            }
        }, label: {
            
            HStack(spacing: 12) {
                
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .regular, design: .serif))
                    .frame(width: currentTab == title ? 38 : nil, height: 28)
                    .foregroundColor(currentTab == title ? Color.orange : Color.white)
                    .background(
                        
                        ZStack{
                            
                            if currentTab == title {
                                Color.white
                                    .clipShape(Circle())
                                    .matchedGeometryEffect(id: "circle", in: animation)
                            }
                        }
                    )
                
                Text(title)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
            }
            .padding(.trailing, 18)
            .background(
                
                ZStack{
                    
                    if currentTab == title {
                        Color.orange.opacity(0.5)
                            .clipShape(Capsule())
                            .matchedGeometryEffect(id: "capsule", in: animation)
                    }
                }
            )
        })
            .offset(x: currentTab == title ? 18 : 0)
    }
    
    @ViewBuilder
    func topView() -> some View {
        
        HStack(alignment: .top, spacing: 12) {
            
            Image("logo")
                .resizable()
                .scaledToFill()
                .frame(width: 55, height: 55)
                .clipShape(Circle())
            
            Text("Kingdom\nColour".uppercased())
               .font(.system(size: 21, weight: .regular, design: .serif))
               .foregroundColor(.white)
               .kerning(3.3)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .shadow(color: Color.white, radius: 5, x: 1, y: -1)
        
    }
}

 
