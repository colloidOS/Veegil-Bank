//
//  WithdrawalViewModel.swift
//  Veegil Bank
//
//  Created by Macintosh HD on 02/12/2023.
//

import SwiftUI
import Combine


final class WithdrawalViewModel: ObservableObject {
    @Published var WithdrawalAmount: Int = 0
    @Published var PhoneNumber = ""
    @Published var isWithdrawalSuccessful = false
    @Published var isWithdrawalFailed = false
    
    func WithdrawalRequest() {
        let urlString = "https://bankapi.veegil.com/accounts/withdraw"

        let depositData = DepositOrWithdrawalRequest(phoneNumber: PhoneNumber, amount: WithdrawalAmount)

        guard let jsonData = try? JSONEncoder().encode(depositData) else {
            print("Error encoding data")
            return
        }

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
                if httpResponse.statusCode == 200 {
                    DispatchQueue.main.async {
                        self.isWithdrawalSuccessful = true
                    }
                } else if httpResponse.statusCode == 404 {
                    DispatchQueue.main.async {
                        self.isWithdrawalFailed = true
                    }
                }
                
            }
        }

        task.resume()
    }
    
    
}
