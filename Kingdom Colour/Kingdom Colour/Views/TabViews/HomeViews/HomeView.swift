//
//  HomeView.swift
//  Kingdom Colour
//
//  Created by Andrej Kling on 22.12.21.
//

import SwiftUI

struct HomeView: View {
  
    @State var selectedTab : KingdomHome = data[0]
  
    init() {
        
        UIScrollView.appearance().bounces = false
    }
    
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    
    var body: some View {
        
        ZStack {
            
            VStack{
                Spacer()
            }
            .frame(  maxWidth: .infinity,   maxHeight: .infinity)
            .background(selectedTab.color)
            
            VStack  {
                
                scroll()
            }
            .padding()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
 
extension HomeView {
    
    @ViewBuilder
    func scroll() -> some View {
        
        ScrollView( .vertical, showsIndicators: false) {
            
            Text(selectedTab.poem)
                .font(.system(size: 21, weight: .regular, design: .serif))
                .textSelection(.enabled)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .padding()
                .background(.ultraThinMaterial).cornerRadius(15)
                .padding(.top, 85)
                .padding(.bottom, 15)
            
            VStack {
                
                VStack {
                    
                    TabView(selection: $selectedTab){
                    
                        ForEach(data){ item in
                            
                            GeometryReader { reader in
                                VStack {
                                    
                                }
                                .offset(x: -reader.frame(in: .global).minX)
                                .frame(width: width, height: height / 2)
                                .background(item.color)
                                
                            }
                            .tag(item)
                            .frame(height: height / 2)
                            .cornerRadius(15)
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: -5, y: -5)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
                .frame(height: UIScreen.main.bounds.height / 2.7)
                
                Text(selectedTab.name)
                    .font(.system(size: 33, weight: .regular, design: .serif))
                    .textSelection(.enabled)
                    .foregroundColor(.white)
                    .padding(.bottom, 5)
                
                PageControl(maxPages: data.count, currentPage: getIndex())
            }
            .padding(.top)
            .padding(.horizontal, 15)
            .padding(.bottom, 35)
            .background(.linearGradient(Gradient(colors: [Color.red, Color.green, Color.orange, Color.blue, Color.purple, Color.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .clipShape(CustomShape())
            .cornerRadius(12)
        }
        
    }
    
    func getIndex()->Int{
        
        let index = data.firstIndex { (indexData) -> Bool in
            return selectedTab.id == indexData.id
        } ?? 0
        
        return index
    }
}
