//
//  SignUpViewModel.swift
//  Veegil Bank
//
//  Created by Macintosh HD on 29/11/2023.
//

import Foundation

final class SignUpViewModel: ObservableObject {
    
    @Published var PhoneNumber = ""
    @Published var password = ""
    @Published var authenticated = false
    @Published var SignUpError = false
    
    
    func checkDetails(phoneNumber: String, password: String) {
          guard let url = URL(string: "https://bankapi.veegil.com/auth/signup") else { return }
          
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
                  }
              } else if finalData.status == "error" {
                  DispatchQueue.main.async {
                      self.SignUpError = true
                  }
              }
              

              
              print(self.authenticated)
          }.resume()
          
          
      }
}
