//
//  DepositView.swift
//  Veegil Bank
//
//  Created by Macintosh HD on 30/11/2023.
//

import SwiftUI

struct DepositView: View {
    @StateObject private var viewModel = DepositViewModel()
    @State private var InitialNumber = ""
    @State private var isLoading = false
    @State private var isAmountCorrect = true
    @State private var isPhoneNumberCorrect = true
    @State private var LoadingViewColor: Color = Color.systemBackground
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.BackGround
                    .ignoresSafeArea()
                
                VStack {
  
                    
                    HStack {
                        Text("Account Number")
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        
                        if !isPhoneNumberCorrect {
                            Text("Add phone Number")
                                .foregroundColor(.red)
                                .padding(.trailing)
                                .italic()
                        }
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.systemBackground)
                            .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
                           
                        
                        HStack(spacing: 5) {
                           
                            TextField("eg: 09012345678", text: $viewModel.PhoneNumber)
                                .onChange(of: viewModel.PhoneNumber) { newValue in
                                  viewModel.PhoneNumber = newValue
                                    if viewModel.PhoneNumber != "" {
                                        isPhoneNumberCorrect = true
                                    }
                                    
                                }
                                .onSubmit {
                                    if viewModel.PhoneNumber != "" {
                                        isPhoneNumberCorrect = true
                                    } else {
                                        isPhoneNumberCorrect = false
                                    }
                                    
                                }
                                
                        }
                        .font(.title)
                    .padding()
                    }
                    .frame(height: 80)
                    .padding(.horizontal)
                    .padding(.bottom)
                    
                    HStack {
                        Text("Amount")
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        
                        if !isAmountCorrect {
                            Text("Add amount")
                                .foregroundColor(.red)
                                .padding(.trailing)
                                .italic()
                        }
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.systemBackground)
                            .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
                           
                        
                        HStack(spacing: 5) {
                            Text("NGN")
                                .padding(.trailing, 4)
                            TextField("0", text: $InitialNumber)
                                .keyboardType(.numberPad)
                                .onChange(of: InitialNumber) { newValue in
                                    viewModel.DepositAmount = Int(newValue) ?? 0
                                    if viewModel.DepositAmount != 0 {
                                        isAmountCorrect = true
                                    }
                                    
                                }
                                .onSubmit {
                                    viewModel.DepositAmount = Int(InitialNumber) ?? 0
                                }
                                
                        }
                        .font(.title)
                    .padding()
                    }
                    .frame(height: 80)
                    .padding(.horizontal)
                    .padding(.bottom, 80)
                    
                   
                        
                        
                        Button{
                            if viewModel.DepositAmount != 0 && viewModel.PhoneNumber != "" {
                                viewModel.DepositRequest()
                                self.isLoading = true
                            } else if viewModel.DepositAmount == 0 {
                                isAmountCorrect = false
                            }
                            if viewModel.PhoneNumber == "" {
                                isPhoneNumberCorrect = false
                            }
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.NapsBlue1)
                                    .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
                                    .frame(width: 150, height: 60)
                                if isLoading {
                                    LoadingView(LoadingColor: $LoadingViewColor)
                                } else {
                                    Text("Deposit")
                                        .foregroundColor(.systemBackground)
                                        .bold()
                                        .font(.title2)
                                }
                            }
                        
                    }
                }
                
                if viewModel.isDepositFailed == true {
                ZStack {
                    Color.primary
                        .opacity(0.3)
                        .ignoresSafeArea()
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.systemBackground)
                                .padding(.horizontal, 30)
                                .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
                            
                        
                    
                    VStack{
                        Text("Deposit Failed!")
                            .bold()
                            .foregroundColor(.NapsBlue1)
                            .font(.title2)
                            .padding()
                            
                        Text("please check that the account\n number is valid and try again")
                            .foregroundColor(.NapsBlue1)
                            .font(.title3)
                            .padding()
                            .padding(.bottom)
                        
                        Button{
                            self.viewModel.isDepositFailed = false
                            self.isLoading = false
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.NapsBlue1)
                                    .frame(width: 130, height: 50)
                                    
                                Text("Okay")
                                    .foregroundColor(.systemBackground)
                                    .font(.title3)
                            }
                            .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                            .padding(.trailing, 50)
                            .padding(.bottom)
                        }
                    }
                    
                    }
                    .offset(y: -30)
                    .frame(height: 250)
                }
                } else if viewModel.isDepositSuccessful == true {
                    ZStack {
                        Color.primary
                            .opacity(0.3)
                            .ignoresSafeArea()
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(.systemBackground)
                                    .padding(.horizontal, 30)
                                    .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
                                
                            
                        
                        VStack{
                            Text("Deposit Successful!")
                                .bold()
                                .foregroundColor(.NapsBlue1)
                                .font(.title2)
                                .padding()
                                
                            Text("you deposited \(viewModel.DepositAmount) \n acc number: \(viewModel.PhoneNumber)")
                                .foregroundColor(.NapsBlue1)
                                .font(.title3)
                                .padding()
                                .padding(.bottom)
                            
                            Button{
                                self.viewModel.isDepositSuccessful = false
                                self.isLoading = false
                                self.presentationMode.wrappedValue.dismiss()
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(.NapsBlue1)
                                        .frame(width: 130, height: 50)
                                        
                                    Text("Okay")
                                        .foregroundColor(.systemBackground)
                                        .font(.title3)
                                }
                                .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                                .padding(.trailing, 50)
                                .padding(.bottom)
                            }
                        }
                        
                        }
                        .offset(y: -30)
                        .frame(height: 250)
                    }
                    }
                
                
                
                
                
            }
            .navigationTitle("Deposit")
        }
    }
}

struct DepositView_Previews: PreviewProvider {
    static var previews: some View {
        DepositView()
    }
}
