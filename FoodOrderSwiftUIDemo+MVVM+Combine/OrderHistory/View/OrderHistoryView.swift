//
//  OrderHistoryView.swift
//  SwiftUITrainingProject
//
//  Created by Khushbu Judal on 05/09/24.
//

import SwiftUI


struct OrderHistoryView: View {
    @StateObject private var viewModel: OrderHistoryViewModel
    
    private let gridItems = [GridItem(.flexible(), spacing: 20, alignment: .leading)]
    
    init() {
        _viewModel = StateObject(wrappedValue: OrderHistoryViewModel(viewContext: DataManager.shared.container.viewContext))
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
                                            Image(systemName: "photo").customImageStyleNoImage()
                                        @unknown default:
                                            Image(systemName: "photo").customImageStyleNoImage()
                                        }
                                    }
                                } else {
                                    Image(systemName: "photo").customImageStyleNoImage()
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
                    Text("No order!").emptyMessageStyle()
                }
            }
        }
        .navigationTitle("Order History")
        .onAppear {
            viewModel.fetchOrders()
        }
    }
}

#Preview {
    OrderHistoryView()
}
