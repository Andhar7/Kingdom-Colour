//
//  MainView.swift
//  Kingdom Colour
//
//  Created by Andrej Kling on 22.12.21.
//

import SwiftUI

struct MainView: View {
    
    @State var currentTab : String = "Home"
    @State var showMenu : Bool = false
    
    init() {
        
        UITabBar.appearance().isHidden = true
    }
    
    @EnvironmentObject var sharedData : KingdomViewModel
    
    var body: some View {
        
        ZStack {
            
            SlideMenuView(currentTab: $currentTab)
            
            CustomTabView(currentTab: $currentTab, showMenu: $showMenu)
                .cornerRadius(showMenu ? 27 : 0)
                .rotation3DEffect(.init(degrees: showMenu ? -15 : 0), axis: (x: 0, y: 1, z: 0), anchor: .trailing)
                .offset(x: showMenu ? getRect().width / 2 : 0)
                .shadow(color: Color.white, radius: 1, x: -0.21, y: -0.21)
                .ignoresSafeArea()
        }
        .preferredColorScheme(.dark)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(KingdomViewModel())
    }
}

