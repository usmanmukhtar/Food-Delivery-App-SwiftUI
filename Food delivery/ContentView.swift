//
//  ContentView.swift
//  Food delivery
//
//  Created by Usman Mukhtar on 21/07/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        FoodDeliverView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FoodDeliverView: View {
    var columns = Array(repeating: GridItem(.flexible()), count: 2)
    @State var categoryIndex = 0
    @State var text = ""
    var body: some View {
        ZStack {
            VStack (alignment: .leading){
                HStack {
                    Image("menu")
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                    Spacer()
                    
                    Image(systemName: "cart")
                        .font(.system(size: 20))
                        .foregroundColor(Color("Color4"))
                }
                
                Text("Deliver to")
                    .font(.title)
                    .padding(.top, 30)
                    .foregroundColor(Color("mainfont"))
                
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
                    VStack (spacing: 0){
                        HStack {
                            DropDown().offset(y: -18)
                        }
                    }.zIndex(1)
                    
                    SearchBar(text: $text)
                        .padding(.top, 30)
                    
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 30){
                        ForEach(0..<categories.count, id: \.self){data in
                            
                            Categories(data: data, index: $categoryIndex)
                        }
                    }
                }
                .padding(.top, 30)
                
                ScrollView(.vertical, showsIndicators: false){
                    LazyVGrid(columns: columns, spacing: 20){
                        ForEach(fData.filter({ "\($0)".contains(text) || text.isEmpty})){ food in
                            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)){
                                VStack {
                                    Image("\(food.image)")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 150)
                                    
                                    HStack {
                                        VStack (alignment: .leading){
                                            Text(food.title)
                                                .font(.title3)
                                                .fontWeight(.bold)
                                                .foregroundColor(Color("mainfont"))
                                            
                                            Text(food.amount)
                                                .foregroundColor(Color("subfont"))
                                            
                                            Text(food.price)
                                                .font(.headline)
                                                .foregroundColor(Color("mainfont"))
                                                .fontWeight(.semibold)
                                        }
                                        
                                        Spacer()
                                    }
                                }
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                                    .frame(width: 45, height: 45)
                                    .overlay(
                                        Image(systemName: "cart")
                                            .resizable()
                                            .frame(width: 20, height: 20, alignment: .center)
                                            .foregroundColor(Color("mainfont"))
                                    )
                                    .shadow(color: Color("mainfont").opacity(0.05), radius: 8, x:0 , y: 5)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 20)
                            .background(Color(food.cardColor))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(color: Color(food.cardColor).opacity(0.5), radius: 10, x:0, y: 10)
                        }
                    }
                }
                .padding(.top, 30)
                
                Spacer()
            }.padding(.top, 20)
        }
        .padding(.horizontal, 20)
    }
}

struct Categories: View {

    var data: Int
    @Binding var index: Int
    
    var body: some View{
        VStack(spacing: 8 ){
            Text(categories[data])
                .font(.system(size: 22))
                .fontWeight(index == data ? .bold : .none)
                .foregroundColor(Color(index == data ? "mainfont" : "subfont"))
            
            Capsule()
                .fill(Color("mainfont"))
                .frame(width: 30, height: 4)
                .opacity(index == data ? 1 : 0)
        }.onTapGesture {
            withAnimation {
                index = data
            }
        }
    }
}


struct Food: Identifiable {
    var id = UUID()
    var title: String
    var image: String
    var amount: String
    var cardColor: String
    var price: String
}

var categories = ["Fruits", "Vegetables", "Dairy", "Meat"]

var fData = [
    Food(title: "Peaches", image: "1", amount: "1 lb", cardColor: "Color1", price: "$2.99"),
    Food(title: "Plant", image: "2", amount: "1 pc", cardColor: "Color2", price: "$0.99"),
    Food(title: "Apple", image: "3", amount: "1 lb", cardColor: "Color3", price: "$3.99"),
    Food(title: "Peaches", image: "1", amount: "1 lb", cardColor: "Color1", price: "$2.99"),

]

