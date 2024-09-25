//
//  ItemDetailsView.swift
//  SwiftUITrainingProject
//
//  Created by Khushbu Judal on 30/08/24.
//

import SwiftUI

struct ItemDetailsView: View {
    
    let category: Category
    @State var quantity: Int = 1
    @StateObject private var viewModel = ItemDetailViewModel(viewContext: DataManager.shared.container.viewContext)

    var body: some View {
        GeometryReader { geo in
            VStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        if let imageURLString = category.strCategoryThumb,
                           let imageURL = URL(string: imageURLString) {
                            AsyncImage(url: imageURL) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .customImageStyle()
                                        .frame(height: geo.size.height * 0.3)
                                        .clipped()
                                case .failure:
                                    Image(systemName: "photo")
                                        .customImageStyle()
                                        .frame(height: geo.size.height * 0.3)
                                        .clipped()
                                @unknown default:
                                    Image(systemName: "photo")
                                        .customImageStyle()
                                        .frame(height: geo.size.height * 0.3)
                                        .clipped()
                                }
                            }
                        } else {
                            Image(systemName: "photo")
                                .customImageStyle()
                                .frame(height: geo.size.height * 0.3)
                                .clipped()
                        }
                        Divider()
                            .frame(height: 2)
                            .shadow(color: .gray, radius: 5, x: 0, y: 3)
                            .padding(.bottom, 10)
                        
                        Text(category.strCategory ?? "")
                            .font(.largeTitle)
                            .padding(.bottom, 10)
                        Text(category.strCategoryDescription ?? "")
                            .font(.subheadline)
                    }
                    .background(Color.white)
                    Spacer()
                }
                HStack {
                    HStack {
                        Button("-") {
                            if quantity > 0 {
                                quantity -= 1
                                viewModel.quantity = quantity
                            }
                        }
                        .foregroundStyle(Color.purple)
                        .font(.title)
                        .padding(.leading)
                        Spacer()
                        Text("\(quantity)")
                            .foregroundStyle(Color.purple)
                            .font(.title2)
                        Spacer()
                        Button("+") {
                            quantity += 1
                            viewModel.quantity = quantity
                        }
                        .foregroundStyle(Color.purple)
                        .font(.title)
                        .padding(.trailing)
                    }
                    .frame(width: 130, height: 50, alignment: .leading)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.purple, lineWidth: 2)
                    )
                    
                    
                    Button("Add To Bag") {
                        let cartItem = CartItem(context: DataManager.shared.container.viewContext)
                        cartItem.cartID = category.idCategory
                        cartItem.itemDescription = category.strCategoryDescription
                        cartItem.itemName = category.strCategory
                        cartItem.itemImage = category.strCategoryThumb
                        cartItem.quanity = Int16(self.quantity)
                        
                        viewModel.addToCard(cartItem: cartItem)
                    }
                    .navigationDestination(isPresented: $viewModel.isItemAdded, destination: {
                        CartView()
                    })
                    .customButtonStyle()
                    
                }
            }
            .padding()
        }
    }
}

