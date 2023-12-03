//
//  HomeView.swift
//  Veegil Bank
//
//  Created by Macintosh HD on 29/11/2023.
//

import SwiftUI

struct HomeView: View {
    @State private var LogoColor: Color = Color.systemBackground
    @StateObject private var viewModel = AuthUsersViewModel()
    @Binding var Account: String
    var body: some View {
        NavigationStack{
            
           ZStack {
                    Color.BackGround
                        .ignoresSafeArea()
                    
                    ScrollView {
                    VStack {
                        
//                    MARK: Total Balance SubView
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.NapsBlue1)
                                .padding(.horizontal, 30)
                                .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
                            .frame(height: 150)
                            .padding(.top)
                            
                            HStack(spacing: 25){
                                ForEach(0..<7) { logos in
                                    VStack(spacing: 25){
                                        ForEach(0..<3) { logo in
                                            LogoView(LogoColor: $LogoColor)
                                                .opacity(0.15)
                                        }
                                    }
                                    
                                }
                            }
                            
                            VStack {
                                Text("Total Balance")
                                    .foregroundColor(.systemBackground)
                                    .bold()
                                .font(.title3)
                                .padding(.bottom, 10)
                                
//                                MARK: THIS DISPLAYS THE AUTHENTICATED USER'S ACCOUNT BALANCE
                                ForEach(viewModel.AuthUsers) { userData in
                                        switch userData.phoneNumber {
                                            case .string(let stringValue):
                                                if stringValue == Account {
                                                    let balance = userData.balance
                                                        Text("NGN \(balance ?? 0)")
                                                            .foregroundColor(.systemBackground)
                                                            .bold()
                                                    
                                                }
                                            case .number(let intValue):
                                               
                                            if String(intValue) == Account {
                                                let balance = userData.balance
                                                    Text("NGN \(balance ?? 0)")
                                                        .foregroundColor(.systemBackground)
                                                        .bold()
                                                
                                            }
                                                
                                        }
                                }
                                
                                

                            }
                            }
                        
//                    MARK: Deposit and Withdrawal View
                        HStack {
                            NavigationLink{
                                DepositView()
                            } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(.systemBackground)
                                    .padding(.trailing, 10)
                                    .frame(width: 165, height: 150)
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(lineWidth: 2)
                                    .foregroundColor(.NapsBlue1)
                                    .padding(.trailing, 10)
                                    .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
                                    .frame(width: 165, height: 150)
                                    .opacity(0.4)
                                VStack(spacing: 20){
                                    Image(systemName: "paperplane.fill")
                                        .foregroundColor(.NapsBlue1)
                                        .font(.system(size: 40))
                                        .rotationEffect(Angle(degrees: 180))
                                    
                                    
                                    Text("Deposit")
                                        .foregroundColor(.NapsBlue1)
                                        .font(.title3)
                                }
                            }
                        }
                    
                             NavigationLink{
                                withdrawalView()
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .foregroundColor(.systemBackground)
                                        .padding(.trailing, 10)
                                        .frame(width: 165, height: 150)
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(lineWidth: 2)
                                        .foregroundColor(.red)
                                        .padding(.trailing, 10)
                                        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
                                    .frame(width: 165, height: 150)
                                    .opacity(0.4)
                                    VStack(spacing: 20){
                                        Image(systemName: "paperplane.fill")
                                            .foregroundColor(.pink)
                                            .font(.system(size: 40))
                                        
                                        
                                        Text("Withdraw")
                                            .foregroundColor(.pink)
                                            .font(.title3)
                                    }
                                }
                            }
                            }
                        
//                        MARK: DEPOSIT HISTORY SUBVIEW
                    NavigationLink {
                            DepositHistoryView()
                           }  label: {
                                ZStack {
                                        RoundedRectangle(cornerRadius: 15)
                                            .foregroundColor(.systemBackground)
                                            .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
                                            .padding(.horizontal)
                                            .frame(height: 100)
                                        VStack {
                                            HStack {
                                                Image(systemName: "paperplane.fill")
                                                    .foregroundColor(.NapsBlue1)
                                                    .font(.system(size: 25))
                                                    .rotationEffect(Angle(degrees: 180))
                                                Text("Deposit History")
                                                    .foregroundColor(.NapsBlue1)
                                                    .bold()
                                                
                                                Spacer()
                                                
                                                
                                                ZStack {
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .foregroundColor(.cyan)
                                                        .opacity(0.5)
                                                        .frame(width: 60, height: 80)
                                                    Image(systemName: "chevron.right")
                                                        .foregroundColor(.NapsBlue1)
                                                        .font(.system(size: 30))
                                                }
                                                
                                            }
                                                            .padding(.horizontal)
                                                            .padding()
                                                           
                                                        }
                                                    }
                                                }
                                .padding(.horizontal)
//                        MARK: TRANSACTION HISTORY SUBVIEW
                        NavigationLink {
                            TransactionsView()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(.systemBackground)
                                    .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
                                    .padding(.horizontal)
                                    .frame(height: 100)
                                VStack {
                                    HStack {
                                        Image(systemName: "newspaper")
                                            .foregroundColor(.orange)
                                            .font(.system(size: 25))
                                        Text("Transaction History")
                                            .foregroundColor(.orange)
                                            .bold()
                                        
                                        Spacer()
                                        
                                        
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 8)
                                                .foregroundColor(.orange)
                                                .opacity(0.3)
                                                .frame(width: 60, height: 80)
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.orange)
                                                .font(.system(size: 30))
                                        }
                                     
                                    }
                                    .padding(.horizontal)
                                    .padding()
                                 
                                }
                            }
                        }
                        .padding(.horizontal)
                        
//                        MARK: WITHDRAWAL HISTORY SUBVIEW
                        NavigationLink {
                            WithdrawalHistoryView()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(.systemBackground)
                                    .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
                                    .padding(.horizontal)
                                    .frame(height: 100)
                                VStack {
                                    HStack {
                                        Image(systemName: "paperplane.fill")
                                            .foregroundColor(.pink)
                                            .font(.system(size: 25))
                                        Text("Withdrawal History")
                                            .foregroundColor(.pink)
                                            .bold()
                                        
                                        Spacer()
                                        
                                        
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 8)
                                                .foregroundColor(.pink)
                                                .opacity(0.3)
                                                .frame(width: 60, height: 80)
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.red)
                                                .font(.system(size: 30))
                                        }
                                    
                                    }
                                    .padding(.horizontal)
                                    .padding()
                              
                                }
                            }
                        }
                        .padding(.horizontal)
                        

                        
                        
                        
                    }
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Text(Account)
                                    .foregroundColor(Color.primary)
                                    .font(.title2)
                            }
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Image(systemName: "bell")
                                    .foregroundColor(Color.primary)
                                    .font(.title2)
                                    .padding(.trailing, 10)
                                      
                            }
                            
      
                    }
                        .onAppear{
                            print("Account Number = \(Account)")
                            viewModel.GetAuthUsersDetails()
                            
                        }
                }
            }
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        HomeView(Account: .constant("xx123344444"))
    }
}
