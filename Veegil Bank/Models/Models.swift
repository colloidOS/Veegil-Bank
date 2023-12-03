//
//  Models.swift
//  Veegil Bank
//
//  Created by Macintosh HD on 29/11/2023.
//

import SwiftUI
import Combine

struct ServerMessage: Decodable {
    
    
    let status, message: String
}


struct TransactionsServerMessage: Codable {
    
    let status: String
    let data: [Data]
    
}

struct Data: Codable, Identifiable {
    
    let id = UUID()
    let type: String
    let amount: Int?
    let balance: Int?
    let created: String
    let phoneNumber: String
}

struct AuthUsersServerMessage: Decodable {
    
    let status: String
    let message: String
    let data: [AuthUserData]
    
}




struct AuthUserData: Decodable, Identifiable {
    
    
    let id = UUID()
    let phoneNumber: codingKeys
    let balance: Int?
    let created: String
    
   
    enum codingKeys: Decodable {
        case string(String)
        case number(Int)


    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            self = try ((try? container.decode(String.self)).map(codingKeys.string))
                .or((try? container.decode(Int.self)).map(codingKeys.number))
                .resolve(with: DecodingError.typeMismatch(codingKeys.self, DecodingError.Context(codingPath: container.codingPath, debugDescription: "Not A JSON")))
                    

        }
        
        
        
            }
        
    }
    
}



extension Optional {
    func or(_ other: Optional) -> Optional {
        switch self {
        case .none: return other
        case .some: return self
        }
    }
}

extension Optional {
    func resolve(with error: @autoclosure () -> Error) throws -> Wrapped {
        switch self {
        case .none: throw error()
        case .some(let wrapped): return wrapped
        }
    }
}

struct DepositOrWithdrawalRequest: Codable {
    let phoneNumber: String
    let amount: Int
}


