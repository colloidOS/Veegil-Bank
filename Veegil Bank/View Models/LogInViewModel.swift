//
//  LogInViewModel.swift
//  Veegil Bank
//
//  Created by Macintosh HD on 29/11/2023.
//

import SwiftUI
import Combine
 
final class LogInViewModel: ObservableObject {
    
    @Published var PhoneNumber = ""
    @Published var password = ""
    @Published var authenticated = false
    @Published var LogInError = false
        
    func checkDetails(phoneNumber: String, password: String) {
        guard let url = URL(string: "https://bankapi.veegil.com/auth/login") else { return }
        
        let body: [String: String] = ["phoneNumber": phoneNumber, "password": password]
        
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            let finalData = try! JSONDecoder().decode(ServerMessage.self, from: data)
            
            print(finalData)
            if finalData.status == "success" {
                DispatchQueue.main.async {
                    self.authenticated = true
//                    self.AccountNumber = self.PhoneNumber
                }
            } else if finalData.status == "error" {
                DispatchQueue.main.async {
                    self.LogInError = true
                }
            }
            
            
            print(self.authenticated)
        }.resume()
        
        
    }
        
        
//    }
}


