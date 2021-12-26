//
//  AboutView.swift
//  Kingdom Colour
//
//  Created by Andrej Kling on 23.12.21.
//

import SwiftUI

struct AboutView: View {
    
    @State var currentIndex : Int = 0
    
    var body: some View {
        
        ZStack {
            
            TabView(selection: $currentIndex) {
                
                ForEach(person.indices, id:\.self) { index in
                    
                    GeometryReader { proxy in
                        
                        Image(person[index].imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: proxy.size.width, height: proxy.size.height)
                            .cornerRadius(1)
                        
                    }
                    .ignoresSafeArea()
                    .offset(y: -100)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
         //   .blur(radius: 5)
            .overlay(
            
                LinearGradient(colors: [
                    
                  
                    Color.blue.opacity(0.7),
                    Color.blue.opacity(0.6),
                    Color.blue.opacity(0.5),
                    Color.white,
                    Color.white,
                ],
                               startPoint: .top,
                               endPoint: .bottom)
                    .background(Color.blue.opacity(0.12))
            
            )
            .ignoresSafeArea()
            
            SnapCarousel(spacing: getRect().height < 750 ? 33 : 41, trailingSpace: getRect().height < 750 ? 90 : 120, index: $currentIndex, items: person, content: { post in
                
                CardView(post: post)
                
            })
                .offset(y: getRect().height / 4.2)
                
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}

extension AboutView {
    
    @ViewBuilder
    func CardView(post: About) -> some View {
        
        VStack(spacing: 8) {
   
                GeometryReader { proxy in
                    
                    Image(post.imageName)
                        .resizable()
                        .aspectRatio(2/3, contentMode: .fill)
                        .frame(width: proxy.size.width, height: proxy.size.height)
                        .cornerRadius(23)
                }
                .padding(10)
                .background(Color.blue.opacity(0.3))
                .cornerRadius(24)
                .frame(height: getRect().height / 2.0)
                .padding(.bottom, 5)
                
                Text(post.name)
                    .font(.title2.bold())
                    .foregroundColor(.black)
  
            ScrollView(.vertical, showsIndicators: false) {
                
                Text(post.description)
                    .font(getRect().height < 750 ? .caption : .callout)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.top, 5)
                    .padding(.horizontal, 5)
                    .padding(.bottom, 185)
      
            }
        }
    }
}
