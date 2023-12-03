//
//  LoadingView.swift
//  Veegil Bank
//
//  Created by Macintosh HD on 29/11/2023.
//

import SwiftUI

struct LoadingView: View {
    
    @State private var UpperOffsetBig = 0.0
    @State private var UpperOffsetSmall = 0.0
    @State private var LowerOffsetBig = 0.0
    @State private var LowerOffsetSmall = 0.0
    @Binding var LoadingColor: Color
    @State private var animate = false

    var body: some View {
        VStack(spacing: 4){
            HStack{
                Circle()
                    .offset(x: UpperOffsetBig)
                    .frame(width: 10, height: 10)
                Circle()
                    .offset(x: UpperOffsetSmall)

                    .frame(width: 4, height: 4)
            }
            .foregroundColor(LoadingColor)
            HStack{
                Circle()
                    .offset(x: LowerOffsetSmall)

                    .frame(width: 4, height: 4)
                Circle()
                    .frame(width: 10, height: 10)
//                    .background(Color.red)
                    .offset(x: LowerOffsetBig)

            }
            .foregroundColor(LoadingColor)
            .offset(x: -12)
            .onAppear{
                animate =  true
                if animate {
                        UpperOffsetBig = 8.0
                        UpperOffsetSmall = -20.0
                        LowerOffsetBig =  -20.0
                        LowerOffsetSmall = 8.0
                }
            }
        }

        .animation(.linear(duration: 1).repeatForever(autoreverses: true), value: animate)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(LoadingColor: .constant(Color.primary))
    }
}
