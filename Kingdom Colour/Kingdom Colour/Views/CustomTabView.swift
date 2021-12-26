//
//  CustomTabView.swift
//  Kingdom Colour
//
//  Created by Andrej Kling on 22.12.21.
//

import SwiftUI

struct CustomTabView: View {
    
    @Binding var currentTab : String
    @Binding var showMenu : Bool
    
    @StateObject var sharedData : KingdomViewModel = KingdomViewModel()
    
    var body: some View {
        
        VStack {
            
            TabView(selection: $currentTab) {
                
                HomeView()
                    .tag("Home")
                
                BrowseView()
                    .environmentObject(sharedData)
                    .tag("Browse")
                
                SearchView()
                    .environmentObject(sharedData)
                    .tag("Search")
                
                FavouriteView()
                    .environmentObject(sharedData)
                    .tag("Favourite")
                
                AboutView()
                    .tag("About")
            }
        }
        .disabled(showMenu)
        .frame( maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaInset(edge: .top ){
            
            safeAreaView()
     
        }
        .overlay(button(), alignment: .topLeading)
        .background(Color("BG"))
   
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView(currentTab: .constant("Home"), showMenu: .constant(false))
          //  .environmentObject(KingdomViewModel())
    }
}

extension CustomTabView {
    
    @ViewBuilder
    func button() -> some View {
        
        Button(action: {
            withAnimation(.spring()){
                showMenu = false
            }
        }, label: {
            
            Image(systemName: "xmark")
               .font(.system(size: 27, weight: .regular, design: .serif))
               .foregroundColor(.white)
        })
            .opacity(showMenu ? 1 : 0)
            .padding()
            .padding(.top, 25)
        
    }
    
    @ViewBuilder
    func safeAreaView() -> some View {
        
        HStack {
            
            Button(action: {
                withAnimation(.spring()){
                    showMenu = true
                }
            }, label: {
                Image(systemName: "line.3.horizontal.decrease")
                    .font(.system(size: 33, weight: .regular, design: .serif))
                    .foregroundColor(.white)
            })
                .opacity(showMenu ? 0 : 1)
            
            Spacer(minLength: 0)
            
            Text(currentTab)
                .font(.system(size: 18, weight: .regular, design: .serif))
                .foregroundColor(.white)
           
            
            Spacer(minLength: 0)
            
            Image("logo")
                .resizable()
                .scaledToFill()
                .frame(width: 31, height: 31)
                .clipShape(Circle())
                .padding(5)
                .overlay(
                    
                    Circle()
                        .strokeBorder(Color("confidence"),lineWidth: 1)
                )
        }
        .padding([.horizontal, .top])
        .padding(.bottom, 10)
        .padding(.top, getSaveArea().top)
        .background(.linearGradient(Gradient(colors: [Color("confidence").opacity(0.5), Color("consciousness").opacity(0.5), Color("determination").opacity(0.5)]), startPoint: .leading, endPoint: .trailing))
 
    }
}
