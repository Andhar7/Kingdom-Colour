//
//  SearchView.swift
//  Kingdom Colour
//
//  Created by Andrej Kling on 23.12.21.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var sharedData : KingdomViewModel
 
    var body: some View {
        
        VStack(spacing: 0) {
            
            topSearchView()
            
            if let colours = sharedData.searchProduct{
                
                if colours.isEmpty {
                    
                    firstSearchCondition()
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        VStack(spacing: 0) {
                            
                            Text("Found \(colours.count) results")
                                .font(.system(size: 24, weight: .regular, design: .serif))
                                .padding(.vertical)
                            
                            StaggeredGrid(columns: 2,  spacing: 18, list: colours ){ colour in
                                
                                CardSearchView(colour: colour)
                                
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .frame(  maxWidth: .infinity,   maxHeight: .infinity, alignment: .top)
        .background(Color("BG").ignoresSafeArea())
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(KingdomViewModel())
    }
}

extension SearchView {
  
    
    @ViewBuilder
    func firstSearchCondition() -> some View {
        
        VStack(spacing: 12) {
            
            Image("nofound")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.top, 61)
            
            Text("Colour not found")
               .font(.system(size: 23, weight: .regular, design: .serif))
               .foregroundColor(.white)
            
            Text("Try a more generic search term or try looking for alternative products.")
               .font(.system(size: 18, weight: .regular, design: .serif))
               .foregroundColor(.white)
               .multilineTextAlignment(.center)
               .padding(.horizontal, 33)
        }
        .padding()
    }
    
    @ViewBuilder
    func topSearchView() -> some View {
        
        
        HStack(spacing: 21) {
            
            Button(action: {
                withAnimation {
                    sharedData.searchActivated = false
                }
                sharedData.searchText = ""
                sharedData.fromSearchPage = false
            }, label: {
                Image(systemName: "arrow.left")
                    .imageScale(.large)
                    .foregroundColor(.white)
            })
            
            HStack(spacing: 15) {
                
                Image(systemName: "magnifyingglass")
                    .imageScale(.large)
                    .foregroundColor(.white)
                
                TextField("Search", text: $sharedData.searchText)
                    .textCase(.lowercase)
                    .disableAutocorrection(true)
                    .foregroundColor(Color.white)
                
            }
            .padding(.vertical, 12)
            .padding(.horizontal)
            .background(
            
                Capsule()
                    .strokeBorder(Color.white, lineWidth: 1.5)
            )
            .padding(.trailing, 21)
        }
        .padding([ .horizontal ])
        .padding(.top, 85)
        .padding(.bottom, 12)
        
    }
    
    @ViewBuilder
    func CardSearchView(colour: Kingdom) -> some View {
        
        VStack(spacing: 12) {
            
            RoundedRectangle(cornerRadius: 21)
                .fill(colour.color)
                .frame(width: 180, height: getRect().height / 4)
                .overlay(
                    
                    VStack(spacing: 12) {
                        
                        Text(colour.name)
                            .font(.system(size: 21, weight: .bold, design: .serif))
                        
                        Text(colour.hex)
                            .font(.system(size: 18, weight: .regular, design: .serif))
                            .textSelection(.enabled)
                        
                        Text(colour.poem)
                            .font(.system(size: 15, weight: .regular, design: .serif))
                        
                    }
                        .padding(8)
                        .foregroundColor(.white)
                )
            
        }
        .shadow(color: Color.white, radius: 3, x: 1, y: 1)
    }
}
