//
//  TransactionsViewModel.swift
//  Veegil Bank
//
//  Created by Macintosh HD on 01/12/2023.
//

import SwiftUI
import Combine

final class TransactionsViewModel: ObservableObject {
   @Published var transactions: [Data] = []
    
    func GetDetails() {
        guard let url = URL(string: "https://bankapi.veegil.com/transactions") else { return }
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            
           if let error = error {
               
               print("Error fetching data: \(error)")
               return
               }
          
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                return
            }
            
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(TransactionsServerMessage.self, from: data)
                    
                    
                    DispatchQueue.main.async {
                        self.transactions = decodedData.data
                        print(self.transactions)
                                        }
                    
                }
                catch {
                    print(error)
                }
            }
                
            }.resume()
    }
    
    
    
    
    
    
}

final class AuthUsersViewModel: ObservableObject {
   @Published var AuthUsers: [AuthUserData] = []

 
   
    func GetAuthUsersDetails() {
        guard let url = URL(string: "https://bankapi.veegil.com/auth/users") else { return }
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            
           if let error = error {
               
               print("Error fetching data: \(error)")
               return
               }
          
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                return
            }
            
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(AuthUsersServerMessage.self, from: data)
                    
                    
                    DispatchQueue.main.async {
                        self.AuthUsers = decodedData.data
                        
                        
                                        }
                    
                }
                catch {
                    print(error)
                }
            }
                
            }.resume()
    }
    
   }
    
    



