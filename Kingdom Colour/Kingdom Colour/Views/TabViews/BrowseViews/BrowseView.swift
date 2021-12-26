//
//  BrowseView.swift
//  Kingdom Colour
//
//  Created by Andrej Kling on 22.12.21.
//

import SwiftUI

struct BrowseView: View {
    
    @State var index : Int = 0
    @State var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
    
    @EnvironmentObject var sharedData : KingdomViewModel
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            LazyVStack {
                
                tabButtonView()
                
                LazyVGrid(columns: self.columns, spacing: 24) {
                    
                    ForEach(sharedData.dataModel) { kingdom in
                        
                        GridView(kingdom: kingdom, columns: self.$columns)
                          //  .environmentObject(sharedData)
                        
                    }
                }
                .padding([.horizontal, .top])
            }
            .padding(.vertical)
        }
        .padding(.top, 55)
        .background(Color("BG").ignoresSafeArea())
    }
}

struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        BrowseView()
            .environmentObject(KingdomViewModel())
    }
}

extension BrowseView {
    
    @ViewBuilder
    func tabButtonView() -> some View {
        
        TabView(selection: self.$index) {
            
            ForEach(data, id:\.self) { item in
                
                Rectangle()
                    .fill(item.color)
                    .frame(height: 210)
                    .cornerRadius(15)
                    .padding(5)
                    .overlay(
                        
                        VStack(spacing: 21) {
                            Text(item.name)
                                .font(.system(size: 55, weight: .regular, design: .serif))
                                .kerning(0.8)
                                .textSelection(.enabled)
                                .shadow(color: Color.white, radius: 2, x: 1, y: 1)
                            
                            Text(item.hex)
                               .font(.system(size: 24, weight: .regular, design: .serif))
                               .textSelection(.enabled)
                        }
                            .foregroundColor(.white)
                    )
                    .tag(item)
                
            }
        }
        .frame(height: 210)
        .padding(.top, 24)
        .tabViewStyle(PageTabViewStyle())
        .animation(.easeOut, value: index)
        
        Button(action: {
            withAnimation(.easeOut){
                
                if self.columns.count == 2 {
                    
                    self.columns.removeLast()
                    
                } else {
                    
                    self.columns.append(GridItem(.flexible(), spacing: 15))
                }
                
            }
            
        }, label: {
            Image(systemName: self.columns.count == 2 ? "rectangle.grid.1x2" : "square.grid.2x2")
               .font(.system(size: 24, weight: .regular, design: .serif))
               .foregroundColor(.white)
        })
            .padding()
            .padding(.trailing, 23)
            .frame(maxWidth: .infinity, alignment: .trailing)
        
    }
}
