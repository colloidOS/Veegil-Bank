//
//  LogInView.swift
//  Veegil Bank
//
//  Created by Macintosh HD on 29/11/2023.
//

import SwiftUI

struct LogInView: View {
    
        @State private var isTappedPhoneNumber: Bool = false
        @State private var isTappedPassword: Bool = false
        @State private var showPassword: Bool = false
        @State private var isLoading: Bool = false
        @State private var LoadingViewColor: Color = Color.systemBackground
        @State private var LogoColor: Color = Color.NapsBlue1
        @State private var isSigningUp: Bool = false
        @State private var isPhoneNumberCorrect: Bool = true
        @State private var isPasswordCorrect: Bool = true
        @StateObject private var viewModel = LogInViewModel()
    @State private var initialWidth: CGFloat = 10.0
        @State private var showSignUpView: Bool = true
        @State private var showHomeView: Bool = false
    
        var body: some View {
            let PhoneNumber = viewModel.PhoneNumber
            let Password = viewModel.password
                ZStack {
                    ZStack {
                            VStack {
                                
                                Text("Log In")
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(.NapsBlue1)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.bottom, 30)
                                    .padding(.leading)
                                    

                                
                                HStack {
                                    Text("Mobile Number")
                                        .foregroundColor(.NapsBlue1)
                                        .bold()
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal)
                              
                                Spacer()
                                if !isPhoneNumberCorrect {
                                        Text("Number can't be empty")
                                            .font(.subheadline)
                                            .foregroundColor(.red)
                                            .italic()
                                }
                                }
                                TextField("eg. 09012345678", text: self.$viewModel.PhoneNumber)
                                    .onChange(of: PhoneNumber, perform: { newPhoneNumber in
                                        if newPhoneNumber.count > 0 {
                                            isPhoneNumberCorrect = true
                                        } else {
                                            isPhoneNumberCorrect = false
                                        }
                                    })
                                    .onSubmit {
                                        isTappedPhoneNumber = false
                                    }
                                    .padding(.horizontal)
                                    .onTapGesture {
                                        OnTapPhoneNumber()
                                    }
                                ZStack{
                                    
                               
                                    isTappedView(isTapped: $isTappedPhoneNumber, isCorrectField: $isPhoneNumberCorrect, initialWidth: $initialWidth)
                                   
                                }
                                

                                .padding(.bottom)
           
                                HStack {
                                    Text("password")
                                        .foregroundColor(.NapsBlue1)
                                        .bold()
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal)
                                    Spacer()
                                    if !isPasswordCorrect {
                                        if Password.count > 0 {
                                            Text("wrong password")
                                                .font(.subheadline)
                                                .foregroundColor(.red)
                                                .italic()
                                        } else {
                                            Text("password can't be empty")
                                                .font(.subheadline)
                                                .foregroundColor(.red)
                                                .italic()
                                        }
                                    }
                                }
                                HStack {
                                    VStack{
                                        if showPassword {
                                            TextField("********", text: self.$viewModel.password)
                                                .onChange(of: Password, perform: { newPassword in
                                                    if newPassword.count >= 4 {
                                                        isPasswordCorrect = true
                                                    }
                                                })
                                                .onSubmit {
                                                    isTappedPassword = false
                                                }
                                                .padding(.horizontal)
                                                .onTapGesture {
                                                   
                                                    OnTapPassword()
                                                }
                                        } else {
                                            SecureField("********", text: self.$viewModel.password)
                                                .onChange(of: Password, perform: { newPassword in
                                                    if newPassword.count >= 4 {
                                                        isPasswordCorrect = true
                                                    }
                                                })
                                                .onSubmit {
                                                    isTappedPassword = false
                                                }
                                                .padding(.horizontal)
                                                .onTapGesture {
                         
                                                    OnTapPassword()
                                                }
                                        }
                                        
                                        
                                        ZStack {
                                            
                                            
                                            isTappedView(isTapped: $isTappedPassword, isCorrectField: $isPasswordCorrect, initialWidth: $initialWidth)
                                        }
                                    }
                                    Button{
                                        self.showPassword.toggle()
                                    } label: {
                                        Image(systemName: showPassword ? "eye" : "eye.slash")
                                            .foregroundColor(.Icon)
                                    }
                                    
                                }
                                
                                Button{
                                    
                                } label: {
                                    Text("forgot password?")
                                        .font(.subheadline)
                                        .underline()
                                        .foregroundColor(.Icon)
                                        .padding(.bottom)
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                Button{
                                    TrySigningIn()
                                    
                                    } label: {
                                    ZStack{
                                        
                                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                                            .frame(height: 45)
                                            .foregroundColor(.NapsBlue1)
                                        if isLoading {
                                            LoadingView(LoadingColor: $LoadingViewColor)
                                        } else {
                                            Text("Sign In")
                                                .font(.title3)
                                                .bold()
                                                .foregroundColor(.systemBackground)
                                        }
                                        }
                                            .padding(.vertical)
                                            .padding(.horizontal, 5)
                                    
                                }
                                
                                Button{
                                    isSigningUp = true
                                } label: {
                                    Text("New to Veegil Bank?, Sign up here")
                                        .font(.subheadline)
                                        .underline()
                                        .foregroundColor(.Icon)
                                        .padding(.bottom)
                                }
                                .fullScreenCover(isPresented: $isSigningUp) {
                                    SignUpView(showSignUpView: $showSignUpView)
                                }
                                .fullScreenCover(isPresented: $viewModel.authenticated) {
                                    HomeView(Account: $viewModel.PhoneNumber)
                                }
                                .onAppear{
                                    isSigningUp = false
                                    showHomeView = false
                                }
                                
                                }
                            .offset(y: -50)
                            
                            .background(Color.systemBackground)

                            .padding()
                        .navigationBarTitleDisplayMode(.inline)
                        
                        .toolbar {
                //            MARK: Option Icon
                           
                            
                            
                            ToolbarItemGroup(placement: .principal){
                                LogoView(LogoColor: $LogoColor)
                            }
                            
                          
                        }
                        
                    }
                    
                    if viewModel.LogInError == true {
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
                            Text("Log in Error")
                                .bold()
                                .foregroundColor(.NapsBlue1)
                                .font(.title2)
                                .padding()
                                
                            Text("Invalid Mobile number or password \n                     try again")
                                .foregroundColor(.NapsBlue1)
                                .font(.title3)
                                .padding()
                                .padding(.bottom)
                            
                            Button{
                                self.viewModel.LogInError = false
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
                        .frame(height: 250)
                    }
                    }
                }

//            }
            
        }
        private func TrySigningIn() {
            let PhoneNumber = viewModel.PhoneNumber
            let password = viewModel.password
            if password.count >= 4 {
                isPasswordCorrect = true
            } else {
                isPasswordCorrect = false
            }
            
            if isPhoneNumberCorrect && isPasswordCorrect {
                self.isLoading = true
            }
            if PhoneNumber.count > 0 {
                isPhoneNumberCorrect = true
            } else {
                isPhoneNumberCorrect = false
            }
            if isPhoneNumberCorrect && isPasswordCorrect {
                
                self.viewModel.checkDetails(phoneNumber: self.viewModel.PhoneNumber, password: self.viewModel.password)
            }
        }
    private func OnTapPhoneNumber() {
        isTappedPhoneNumber = true
        isTappedPassword = false
        self.initialWidth = 10.0
        withAnimation(.linear(duration: 0.5)) {
            self.initialWidth += .infinity
        }
    }
    private func OnTapPassword() {
        isTappedPassword = true
        isTappedPhoneNumber = false

        self.initialWidth = 10.0
        withAnimation(.linear(duration: 0.5)) {
            self.initialWidth += .infinity
        }
    }
    
    }



struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
