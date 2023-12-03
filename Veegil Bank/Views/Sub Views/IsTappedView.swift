//
//  isTappedView.swift
//  Veegil Bank
//
//  Created by Macintosh HD on 29/11/2023.
//

import SwiftUI

struct isTappedView: View {
    @Binding var isTapped: Bool
    @Binding var isCorrectField: Bool
    @State private var animate = false
    @Binding var initialWidth: CGFloat
    var body: some View {
        ZStack{
            
            
            Rectangle()
                .frame(height: 1.5)
                .opacity(0.2)
            
            if isTapped {
                Rectangle()
                    .frame(width: initialWidth, height: 1.0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(isCorrectField ? .NapsBlue1 : .red)
                    
            }
                
        }
  
    }
}

struct isTappedView_Previews: PreviewProvider {
    static var previews: some View {
        isTappedView(isTapped: .constant(true), isCorrectField: .constant(true), initialWidth: .constant(2))
    }
}
