//
//  TransactionsView.swift
//  Veegil Bank
//
//  Created by Macintosh HD on 30/11/2023.
//

import SwiftUI

struct TransactionsView: View {
    @StateObject private var viewModel = TransactionsViewModel()
    @State private var LoadingViewColor: Color = Color.NapsBlue1
    var body: some View {
       
        ZStack {
            LoadingView(LoadingColor: $LoadingViewColor)
            ScrollView {
                    ForEach(viewModel.transactions, id: \.self.id) { transaction in
                        let truncatedDate = String(transaction.created.prefix(10))
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 3)
                                .padding()
                            
                            VStack(spacing: 3){
                                HStack{
                                    Text("Acc Number")
                                        .bold()
                                        .foregroundColor(.NapsBlue1)
                                        .font(.title3)
                                    Spacer()
                                    Text("Transaction")
                                        .bold()
                                        .foregroundColor(.NapsBlue1)
                                        .font(.title3)
                                   }
                                .padding(.top)
                                .padding(.horizontal)
                                HStack{
                                    Text(transaction.phoneNumber)
                                        .foregroundColor(transaction.type == "debit" ? .red : .cyan)
                                    
                                    Spacer()
                                    Text(transaction.type)
                                        .foregroundColor(transaction.type == "debit" ? .red : .cyan)
                                }
                                .padding(.horizontal)
    //                            Spacer()
                                HStack{
                                    Text("Date")
                                        .bold()
                                        .foregroundColor(.NapsBlue1)
                                        .font(.title3)
                                    Spacer()
                                    Text("Amount")
                                        .bold()
                                        .foregroundColor(.NapsBlue1)
                                        .font(.title3)
                                   }
                                .padding(.top)
                                .padding(.horizontal)
                                HStack{
                                    Text(truncatedDate)
                                        .foregroundColor(transaction.type == "debit" ? .red : .cyan)
                                    Spacer()
                                    Text("NGN \(transaction.amount ?? 0)")
                                        .bold()
                                        .foregroundColor(transaction.type == "debit" ? .red : .cyan)
                                }
                                .padding(.horizontal)
                                .padding(.bottom)
                            }
                            .padding()
                        }
                        
                        
                        
                    }
                }
                .navigationBarTitle("Transaction History")
            .onAppear{
                viewModel.GetDetails()
        }
        }
    }
    
    
    
  
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
    }
}
