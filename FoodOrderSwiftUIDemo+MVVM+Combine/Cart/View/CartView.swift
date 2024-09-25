//
//  CartView.swift
//  SwiftUITrainingProject
//
//  Created by Khushbu Judal on 02/09/24.
//

import SwiftUI


struct CartView: View {
    
    @StateObject private var viewModel: ItemDetailViewModel
    private let gridItems = [GridItem(.flexible(), spacing: 20, alignment: .leading)]
    
    init() {
        _viewModel = StateObject(wrappedValue: ItemDetailViewModel(viewContext: DataManager.shared.container.viewContext))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    LazyVGrid(columns: gridItems, spacing: 20) {
                        ForEach(viewModel.cartItems) { cartItem in
                            HStack {
                                if let imageURLString = cartItem.itemImage,
                                   let imageURL = URL(string: imageURLString) {
                                    AsyncImage(url: imageURL) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                        case .success(let image):
                                            image.customImageStyle()
                                                .frame(width: 120)
                                        case .failure:
                                            Image(systemName: "photo").customImageStyle()
                                        @unknown default:
                                            Image(systemName: "photo").customImageStyle()
                                        }
                                    }
                                } else {
                                    Image(systemName: "photo").customImageStyle()
                                }
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(cartItem.itemName ?? "")
                                        .font(.title3)
                                    
                                    Text("\(cartItem.price, specifier: "%.2f")")
                                        .font(.caption)
                                }
                                .padding([.top, .bottom, .leading])
                                
                                Spacer()
                                
                                Text("\(cartItem.quanity)")
                                    .foregroundStyle(Color.purple)
                                    .font(.title3)
                                    .padding(.trailing, 30)
                            }
                            .frame(maxWidth: .infinity)
                            .customContainerStyle()
                        }
                    }
                    .padding()
                }
                
                if viewModel.cartItems.isEmpty {
                    Text("Cart is Empty, add products!").emptyMessageStyle()
                }
            }
            
            Spacer()
            
            VStack {
                Button(action: {
                    viewModel.placeOrder()
                }) {
                    Text("Place Order")
                        .customButtonStyle(isEnabled: !viewModel.cartItems.isEmpty, backgroundColor: Color.purple)
                }
                .navigationDestination(isPresented: $viewModel.orderPlaced, destination: {
                    Dashboard()
                }).padding(.top, 50)
                
            }
            .padding()
        }
        .navigationTitle("Cart")
        .onAppear {
            viewModel.fetchCartItems()
        }
    }
}

#Preview {
    CartView()
}
