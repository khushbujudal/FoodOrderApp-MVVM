//
//  Dashboard.swift
//  SwiftUITrainingProject
//
//  Created by Khushbu Judal on 28/08/24.
//

import SwiftUI

struct Dashboard: View {
    
    @StateObject private var viewModel = DashboardViewModel()
    private let gridItems = [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)]
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationViewForDashboard(viewModel: viewModel)
                ScrollView {
                    LazyVGrid(columns: gridItems, spacing: 20) {
                        ForEach(viewModel.foodCategories) { category in
                            
                            NavigationLink(destination: ItemDetailsView(category: category)) {
                                
                                VStack {
                                    if let imageURLString = category.strCategoryThumb,
                                       let imageURL = URL(string: imageURLString) {
                                        AsyncImage(url: imageURL) { phase in
                                            switch phase {
                                            case .empty:
                                                ProgressView()
                                            case .success(let image):
                                                image
                                                    .customImageStyle()
                                            case .failure:
                                                Image(systemName: "photo")
                                                    .customImageStyle()
                                            @unknown default:
                                                Image(systemName: "photo")
                                                    .customImageStyle()
                                            }
                                        }
                                    } else {
                                        Image(systemName: "photo")
                                            .customImageStyle()
                                    }
                                    
                                    Text(category.strCategory ?? "Unknown")
                                        .font(.subheadline)
                                        .foregroundStyle(Color.black)
                                        .multilineTextAlignment(.center)
                                }
                                .padding()
                                .customContainerStyle()
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct NavigationViewForDashboard: View {
    @ObservedObject var viewModel: DashboardViewModel
    
    var body: some View {
        VStack {
            HStack {
                NavigationLink(destination: SideMenuView().transition(.move(edge: .trailing))) {
                    Image("menu")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                .navigationBarBackButtonHidden(true)
                Spacer()
                Text(viewModel.currenLocation ?? "Address not found")
                    .font(.caption)
                    .foregroundColor(.purple)
                Spacer()
                NavigationLink(destination: CartView()) {
                    Image("shopping-cart")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
            }
        }
        .padding([.leading, .trailing])
        .background(Color.white)
        .shadow(radius: 10)
        .onAppear {
            viewModel.getCurrentLocation()
            viewModel.getFoodItems()
        }
    }
}

#Preview {
    Dashboard()
}

