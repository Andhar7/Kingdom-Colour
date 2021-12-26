//
//  SnapCarousel.swift
//  Kingdom Colour
//
//  Created by Andrej Kling on 24.12.21.
//

import SwiftUI

struct SnapCarousel<Content: View, T: Identifiable>: View {
    
    var content: (T) -> Content
    var list : [T]
    
    // PROPERTIES
    var spacing: CGFloat
    var trailingSpace: CGFloat
    @Binding var index : Int
    
    // OFFSET
    @GestureState var offset: CGFloat = 0
    @State var currentIndex : Int = 0
    
    init(spacing: CGFloat = 15, trailingSpace: CGFloat = 100, index: Binding<Int>, items: [T],
         @ViewBuilder content: @escaping (T) -> Content) {
        
        self.list = items
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self._index = index
        self.content = content
        
    }
    
    var body: some View {
        
        GeometryReader { proxy in
            
            // SETTING CORRECT WIDTH FOR SNAP CAROUSEL
            // ONE SIDE SNAP CAROUSEL
            
            let width = proxy.size.width - (trailingSpace - spacing)
            let adjustMentWidth = (trailingSpace / 2) - spacing
            
            HStack(spacing: spacing) {
                
                ForEach(list) { item in
                    
                    content(item)
                        .frame(width: proxy.size.width - trailingSpace)
                        .offset(y: getOffset(item: item, width: width))
                }
            }
            // SPACING WILL BE HORIZONTAL PADDING
            .padding(.horizontal, spacing)
            // SETTING ONLY AFTER 0TH INDEX...
            .offset(x: (CGFloat(currentIndex) * -width) + (currentIndex != 0 ? adjustMentWidth : 0) + offset)
            .gesture(
            
                DragGesture()
                    .updating($offset, body: { value, out, _ in
                        
                        out = value.translation.width
                    })
                    .onEnded({ value in
                        
                        // UPDATING CURRENT INDEX...
                        let offset = value.translation.width
                        
                        // WE ARE GOING CONVERT TRANSLATION INTO PROGRESS (0 - 1)
                        // AND ROUND THE VALUE
                        // BASED ON THE PROGRESS INCREASING OR DECREASING THE CURRENTINDEX
                        let progress = -offset / width
                        
                        let roundIndex = progress.rounded()
                        
                        // SETTING MIN
                        currentIndex = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                        
                        // UPDATING INDEX
                        currentIndex = index
                        
                    })
                    .onChanged({ value in
                        
                        // UPDATING ONLY INDEX
                        
                        // UPDATING CURRENT INDEX
                        let offsetX = value.translation.width
                        
                        // WE ARE GOING CONVERT TRANSLATION INTO PROGRESS (0 - 1)
                        // AND ROUND THE VALUE
                        // BASED ON THE PROGRESS INCREASING OR DECREASING THE CURRENTINDEX
                        let progress = -offsetX / width
                        
                        let roundIndex = progress.rounded()
                        
                        // SETTING MIN
                        index = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                        
                    })
            
            )
        }
        // ANIMATION WHEN OFFSET = 0
        .animation(.easeInOut, value: offset == 0)
    }
}

struct SnapCarousel_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}

extension SnapCarousel {
    
    func getOffset(item: T, width: CGFloat) -> CGFloat {
        
        // PROGRESS...
        // SHIFTING CURRENT ITEM TO TOP...
        let progress = ((offset < 0 ? offset : -offset) / width) * 60
        
        // MAX 60....
        // THEN AGAIN MINUS FROM 60...
        let topOffset = -progress < 60 ? progress : -(progress + 120)
        
        let previous = getIndex(item: item) - 1 == currentIndex ? (offset < 0 ? topOffset : -topOffset) : 0
        
        let next = getIndex(item: item) + 1 == currentIndex ? (offset < 0 ? -topOffset : topOffset) : 0
        
        // SAFELY CHECK BETWEEN 0 TO MAX LIST SIZE...
        let checkBetween = currentIndex >= 0 && currentIndex < list.count ? (getIndex(item: item) - 1 == currentIndex ? previous : next) : 0
        
        //  CHECKING CURRENT...
        // IF TO SHIFTING VIEW TO TOP
        return getIndex(item: item) == currentIndex ? -60 - topOffset : checkBetween
    }
    
    func getIndex(item : T) -> Int {
        
        let index = list.firstIndex { currentItem in
            
            return currentItem.id == item.id
            
        } ?? 0
        
        return index
    }
}
