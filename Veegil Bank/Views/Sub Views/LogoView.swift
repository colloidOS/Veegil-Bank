//
//  LogoView.swift
//  Veegil Bank
//
//  Created by Macintosh HD on 29/11/2023.
//

import SwiftUI

struct LogoView: View {
    @Binding var LogoColor: Color
    var body: some View {
        VStack(spacing: 4){
            HStack{
                Circle()
                    .frame(height: 10)
                Circle()
                    .frame(height: 4)
            }
            .foregroundColor(LogoColor)
            HStack{
                Circle()
                    .frame(height: 4)
                Circle()
                    .frame(height: 10)
            }
            .foregroundColor(LogoColor)
            .offset(x: -12)
        }
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView(LogoColor: .constant(.blue))
    }
}
