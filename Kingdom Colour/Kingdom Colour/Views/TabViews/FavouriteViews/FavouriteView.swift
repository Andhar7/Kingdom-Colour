//
//  FavouriteView.swift
//  Kingdom Colour
//
//  Created by Andrej Kling on 23.12.21.
//
 
import SwiftUI

struct FavouriteView: View {
    
    @EnvironmentObject var sharedData : KingdomViewModel
    
    @State var showDeleteOption : Bool = false
    
    var body: some View {
        
        NavigationView {
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack {
                    
                    top()
                        .padding(.top, 85)
                    
                    if sharedData.likedColours.isEmpty {
                        
                        firstFavouriteCondition()
                        
                    } else {
                        
                        secondFavouriteCondition()
                    }
                }
                .padding()
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BG").ignoresSafeArea())
        }
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView()
            .environmentObject(KingdomViewModel())
    }
}

extension FavouriteView {
    
    @ViewBuilder
    func secondFavouriteCondition() -> some View {
        
        VStack(spacing: 15) {
            
            ForEach(sharedData.likedColours){ product in
                
                HStack(spacing:0) {
                    
                    if showDeleteOption {
                        
                        Button(action: {
                            deleteProduct(product: product)
                        }, label: {
                            Image(systemName: "minus.circle.fill")
                                .imageScale(.large)
                                .foregroundColor(.red)
                        })
                            .padding(.trailing)
                    }
                    
                    CardView(product: product)
                }
            }
        }
        .padding(.top, 24)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    func firstFavouriteCondition() -> some View {
        
        Group {
            
            Image("nolike")
                .resizable()
                .scaledToFit()
                .padding()
                .padding(.top, 33)
                .shadow(color: Color.white, radius: 2, x: -2, y: -2)
            
            Text("No favourites yet")
                .font(.system(size: 24, weight: .semibold, design: .serif))
                .foregroundColor(.white)
            
            Text("Hit the like button on each product page to save favorite ones.")
               .font(.system(size: 18, weight: .regular, design: .serif))
               .foregroundColor(Color.white.opacity(0.7))
               .multilineTextAlignment(.center)
               .padding()
            
        }
    }
    
    @ViewBuilder
    func top() -> some View {
        
        
        HStack {
            
            Text("Favourites")
               .font(.system(size: 33, weight: .regular, design: .serif))
               .foregroundColor(.white)
            
            Spacer(minLength: 0)
            
            Button(action: {
                withAnimation{
                    showDeleteOption.toggle()
                }
            }, label: {
                Image("Delete")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 23, height: 23)
                    .padding(.trailing, 21)
            })
                .opacity(sharedData.likedColours.isEmpty ? 0 : 1)
        }
        
    }
    
    @ViewBuilder
    func CardView(product: Kingdom) -> some View {
        
        HStack(spacing: 15) {
            
            RoundedRectangle(cornerRadius: 21)
                .fill(product.color)
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text(product.name)
                   .font(.system(size: 18, weight: .regular, design: .serif))
                   .foregroundColor(.black)
                   .lineLimit(1)
                
                Text(product.poem)
                   .font(.system(size: 15, weight: .regular, design: .serif))
                   .foregroundColor(.black)
                
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.cornerRadius(12))
    }
    
    func deleteProduct(product: Kingdom){
        
        if let index = sharedData.likedColours.firstIndex(where: { currentProduct in
            
            return product.id == currentProduct.id
        }){
            
            let _ = withAnimation{
                
                sharedData.likedColours.remove(at: index)
            }
        }
    }
}
