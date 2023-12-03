//
//  SignUpView.swift
//  Veegil Bank
//
//  Created by Macintosh HD on 29/11/2023.
//

import SwiftUI



struct SignUpView: View {
    @State private var VerifyPassword = ""
    @State private var isTappedPhoneNumber: Bool = false
    @State private var isTappedPassword: Bool = false
    @State private var isTappedVerifyPassword: Bool = false
    @State private var showPassword: Bool = false
    @State private var showVerifyPassword: Bool = false
    @State private var isLoading: Bool = false
    @State private var LoadingViewColor: Color = Color.systemBackground
    @State private var LogoColor: Color = Color.NapsBlue1
    
    @State private var isPhoneNumberCorrect: Bool = true
    @State private var isPasswordCorrect: Bool = true
    @State private var initialWidth: CGFloat = 10.0
    
    @State private var showSignInView = true
    @Binding var showSignUpView: Bool
    @State private var isSigningIn: Bool = false
    @State private var showHomeView: Bool = false
    @State private var SignUpOpacity = 1.0
    @ObservedObject private var viewModel = SignUpViewModel()
    
    var body: some View {
        
            ZStack {
                ZStack {
                    let Password = viewModel.password
                    let PhoneNumber = viewModel.PhoneNumber
                    VStack {
                        
                        Text("Sign Up")
                            .font(.title)
                            .bold()
                            .foregroundColor(.NapsBlue1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 30)
                            .padding(.leading)
                        
//                        MARK: NAME
                        
                        HStack{
                            Text("Mobile Number")
                                .foregroundColor(.NapsBlue1)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                            if !isPhoneNumberCorrect {
                                Text("Mobile number can't be empty")
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
                        
                        isTappedView(isTapped: $isTappedPhoneNumber, isCorrectField: $isPhoneNumberCorrect, initialWidth: $initialWidth)
                            .padding(.bottom)
                        
                       
                        
                        VStack {
                            Text("password")
                                .foregroundColor(.NapsBlue1)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                            
                            HStack {
                                VStack{
                                    if showPassword {
                                        TextField("********", text: self.$viewModel.password)
                                            .onChange(of: Password, perform: { newValue in
                                                if Password == VerifyPassword && Password.count >= 4 {
                                                    isPasswordCorrect = true
                                                } else {
                                                    isPasswordCorrect = false
                                                }
                                            })
                                            .onSubmit {
                                                isTappedPassword = false
                                            }
                                        
                                            .onTapGesture {
                                                OnTapPassword()
                                            }
                                            .padding(.horizontal)
                                    } else {
                                        SecureField("********", text: self.$viewModel.password)
                                            .onChange(of: Password, perform: { newValue in
                                                if Password == VerifyPassword && Password.count >= 4 {
                                                    isPasswordCorrect = true
                                                } else {
                                                    isPasswordCorrect = false
                                                }
                                            })
                                            .onSubmit {
                                                isTappedPassword = false
                                            }
                                        
                                            .onTapGesture {
                                                OnTapPassword()
                                            }
                                            .padding(.horizontal)
                                    }
                                    
                                    ZStack {
                                        isTappedView(isTapped: $isTappedPassword, isCorrectField: $isPasswordCorrect, initialWidth: $initialWidth)
                                        Rectangle()
                                            .frame(height: 1)
                                            .opacity(isPasswordCorrect ? 0 : 1)
                                            .foregroundColor(.red)
                                    }
                                }
                                Button{
                                    self.showPassword.toggle()
                                } label: {
                                    Image(systemName: showPassword ? "eye" : "eye.slash")
                                        .foregroundColor(.Icon)
                                }
                                
                            }
                            .padding(.bottom)
                            
                            Text("Verify password")
                                .foregroundColor(.NapsBlue1)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                            
                            VStack {
                                HStack {
                                    VStack{
                                        if showVerifyPassword {
                                            TextField("********", text: self.$VerifyPassword)
                                                .onChange(of: VerifyPassword, perform: { newValue in
                                                    if VerifyPassword == Password && Password.count >= 4 {
                                                        isPasswordCorrect = true
                                                    } else {
                                                        isPasswordCorrect = false
                                                    }
                                                })
                                                .onSubmit {
                                                    isTappedPassword = false
                                                }
                                                .padding(.horizontal)
                                                .onTapGesture {
                                                    OnTapVerifyPassword()
                                                }
                                        } else {
                                            SecureField("********", text: self.$VerifyPassword)
                                                .onChange(of: VerifyPassword, perform: { newValue in
                                                    if VerifyPassword == Password && Password.count >= 4 {
                                                        isPasswordCorrect = true
                                                    } else {
                                                        isPasswordCorrect = false
                                                    }
                                                })
                                                .onSubmit {
                                                    isTappedVerifyPassword = false
                                                }
                                            
                                                .onTapGesture {
                                                    OnTapVerifyPassword()
                                                }
                                                .padding(.horizontal)
                                        }
                                        
                                        
                                        //
                                        ZStack {
                                            isTappedView(isTapped: $isTappedVerifyPassword, isCorrectField: $isPasswordCorrect, initialWidth: $initialWidth)
                                            
                                            Rectangle()
                                                .frame(height: 1)
                                                .opacity(isPasswordCorrect ? 0 : 1)
                                                .foregroundColor(.red)
                                        }
                                        
                                        
                                        
                                        
                                    }
                                    Button{
                                        self.showVerifyPassword.toggle()
                                    } label: {
                                        Image(systemName: showVerifyPassword ? "eye" : "eye.slash")
                                            .foregroundColor(.Icon)
                                    }
                                    
                                }
                                
                                
                                if !isPasswordCorrect {
                                    Text("Passwords should be atleast 4 characters and must match")
                                        .font(.subheadline)
                                        .foregroundColor(.red)
                                        .italic()
                                }
                                
                                
                            }
                            .padding(.bottom, isPasswordCorrect ? 50 : 0)
                            
                        }
                        
                        Button{
                            TrySigningUp()
                            
                        } label: {
                            ZStack{
                                
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .frame(height: 45)
                                    .foregroundColor(.NapsBlue1)
                                if isLoading {
                                    LoadingView(LoadingColor: $LoadingViewColor)
                                } else {
                                    Text("Sign Up")
                                        .font(.title3)
                                        .bold()
                                        .foregroundColor(.systemBackground)
                                }
                            }
                            .padding(.vertical)
                            .padding(.horizontal, 5)
                            
                        }
                        
                        Button{
                            isSigningIn = true
                        } label: {
                            Text("Already have an account?, Sign in here")
                                .font(.subheadline)
                                .underline()
                                .foregroundColor(.Icon)
                                .padding(.bottom)
                        }
                        
                       
                        
                        
                        
                        
                    }
                    .offset(y: -50)
                    
                    .background(Color.systemBackground)
                    
                    .padding()
                    
                    
                    .fullScreenCover(isPresented: $viewModel.authenticated) {
                        NavigationStack{
                            HomeView(Account: $viewModel.PhoneNumber)
                        }
                    }
                    
                    .fullScreenCover(isPresented: $isSigningIn, content: {
                        LogInView()
                    })
                    .onAppear{
                        isSigningIn = false
                        self.isLoading = false
                        showHomeView = false
                    }
                    
                    .toolbar {
                        //            MARK: Option Logo
                        
                        
                        
                        ToolbarItemGroup(placement: .principal){
                            LogoView(LogoColor: $LogoColor)
                        }
                        
                        
                    }
                    
                }
                
                if viewModel.SignUpError == true {
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
                        Text("Sign Up Error")
                            .bold()
                            .foregroundColor(.NapsBlue1)
                            .font(.title2)
                            .padding()
                            
                        Text("The User already exist \n      try logging in")
                            .foregroundColor(.NapsBlue1)
                            .font(.title3)
                            .padding()
                            .padding(.bottom)
                        
                        Button{
                            self.viewModel.SignUpError = false
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
//        }
        
        
    }
    //    MARK: TRY TO SIGN UP/ CHECK IF ALL CREDENTIALS ARE CORRECT
    private func TrySigningUp() {
        let PhoneNumber = viewModel.PhoneNumber
        let Password = viewModel.password
        if PhoneNumber.count <= 0 {
            isPhoneNumberCorrect = false
        }
        if isPasswordCorrect && isPhoneNumberCorrect {
            self.isLoading.toggle()
        }
        
        if Password == VerifyPassword && Password.count >= 4 {
            isPasswordCorrect = true
        }
        else {
            isPasswordCorrect = false
        }
        
        if isPasswordCorrect && isPhoneNumberCorrect {
            self.viewModel.checkDetails(phoneNumber: self.viewModel.PhoneNumber, password: self.viewModel.password)
    }
}

    
//    MARK: ON TAP ON EACH TEXTFIELD
    private func OnTapPhoneNumber() {
        isTappedPhoneNumber = true
        isTappedPassword = false
        isTappedVerifyPassword = false
        self.initialWidth = 10.0
        withAnimation(.linear(duration: 0.5)) {
            self.initialWidth += .infinity
        }
    }
    private func OnTapEmail() {
        isTappedPhoneNumber = false
        isTappedPassword = false
        isTappedVerifyPassword = false
        self.initialWidth = 10.0
        withAnimation(.linear(duration: 0.5)) {
            self.initialWidth += .infinity
        }
    }
    private func OnTapPassword() {
        let Password = viewModel.password
        isTappedPassword = true
        isTappedPhoneNumber = false
        isTappedVerifyPassword = false
        if Password == VerifyPassword && Password.count >= 8 {
            isPasswordCorrect = true
        } else {
            isPasswordCorrect = false
        }
        self.initialWidth = 10.0
        withAnimation(.linear(duration: 0.5)) {
            self.initialWidth += .infinity
        }
    }
    private func OnTapVerifyPassword() {
        let Password = viewModel.password
        isTappedVerifyPassword = true
        isTappedPhoneNumber = false
        isTappedPassword = false
        if Password == VerifyPassword && Password.count >= 8 {
            isPasswordCorrect = true
        } else {
            isPasswordCorrect = false
        }
        self.initialWidth = 10.0
        withAnimation(.linear(duration: 0.5)) {
            self.initialWidth += .infinity
        }
    }
    
    
    
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(showSignUpView: .constant(false))
    }
}
