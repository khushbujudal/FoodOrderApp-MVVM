//
//  SideMenuView.swift
//  SwiftUITrainingProject
//
//  Created by Khushbu Judal on 04/09/24.
//
import SwiftUI

struct SideMenuView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var isLoggedOut = false
    @StateObject private var viewModel = SideMenuViewModel(viewContext: DataManager.shared.container.viewContext)
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            
            VStack(alignment: .leading) {
                ProfileImageView()
                    .padding(.bottom, 30)
                
                VStack(alignment: .leading, spacing: 20) {
                    NavigationLink(destination: Dashboard()) {
                        Text("Home")
                            .foregroundStyle(.purple)
                            .underline()
                            .font(.title3)
                    }
                    
                    NavigationLink(destination: OrderHistoryView()) {
                        Text("My Orders")
                            .foregroundStyle(.purple)
                            .underline()
                            .font(.title3)
                    }
                    
                    NavigationLink(destination: CartView()) {
                        Text("Cart")
                            .foregroundStyle(.purple)
                            .underline()
                            .font(.title3)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.logout()
                        isLoggedOut.toggle()
                    }, label: {
                        Text("Log Out")
                            .fontWeight(.heavy)
                            .font(.title3)
                            .padding()
                            .foregroundStyle(Color.white)
                    })
                    .navigationDestination(isPresented: $viewModel.isLoggedOut, destination: {
                        LoginView()
                    })
                    .frame(width: 200)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.pink, Color.purple]),
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    )
                    .cornerRadius(40)
                    .padding(.top, 50)
                }
                .padding(.top, 100)
            }
            .frame(width: 270)
            .background(Color.white)
            .shadow(color: .purple.opacity(0.1), radius: 5, x: 0, y: 3)
        }
    }
}

func ProfileImageView() -> some View{
    VStack(alignment: .center){
        
        Image(systemName: "person")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
            .frame(width: 100, height: 100)
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(.purple.opacity(0.5), lineWidth: 8)
            )
            .cornerRadius(50)
            .padding()
        
        Text(UserManager.shared.currentUser?.emailID ?? "")
            .font(.system(size: 18, weight: .bold))
            .foregroundColor(.black)
            .padding()
    }
}

struct SideMenu: View {
    @Binding var isShowing: Bool
    var content: AnyView
    var edgeTransition: AnyTransition = .move(edge: .leading)
    var body: some View {
        ZStack(alignment: .bottom) {
            if (isShowing) {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                    }
                content
                    .transition(edgeTransition)
                    .background(
                        Color.clear
                    )
            }
        }
        .frame(maxWidth: .infinity)
        .animation(.easeInOut, value: isShowing)
    }
}
