//
//  ButtonView.swift
//  GitSetKit
//
//  Created by Cho Chaewon on 2023/07/27.
//

import Foundation
import SwiftUI

struct ButtonView: View {
    
    @Binding var selectedFieldIndex: Int
    @Binding var outputMessage: [String]
    @Binding var selectedFieldsCount: Int
    
    
    var body: some View {
        HStack{
            Text("\(Image(systemName: "keyboard")) [shift+방향키]로 다음으로 넘어갈 수 있어요!")
                .foregroundColor(Colors.Text.secondary)
                .font(.system(size: 11))
            
            Spacer()
            
            Button(action: {
                selectedFieldIndex -= 1
            }, label: {
                Text("이전")
                    .foregroundColor((selectedFieldIndex != 0 ? Color.white : Color.black))
            })
            .frame(width: 40, height: 24)
            .buttonStyle(.plain)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(selectedFieldIndex != 0 ? Color(red: 0, green: 122/255, blue: 1) : Color.white)
            )
            .disabled(selectedFieldIndex == 0)
            
            Button(action: {
                print(outputMessage)
                print(selectedFieldIndex)
                selectedFieldIndex += 1
            }, label: {
                Text("다음")
                    .foregroundColor((selectedFieldIndex != selectedFieldsCount ? Color.white : Color.black))
            })
            .frame(width: 40, height: 24)
            .buttonStyle(.plain)
            .disabled(selectedFieldIndex == (selectedFieldsCount-1))
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(selectedFieldIndex != (selectedFieldsCount-1) ? Color(red: 0, green: 122/255, blue: 1) : Color.white)
            )
            
        }//HStack - Previous, Next Button View
    }
    
}
