//
//  FieldView.swift
//  GitSetKit
//
//  Created by Cho Chaewon on 2023/07/18.
//

import Foundation
import SwiftUI
import WrappingHStack
import CoreData

struct FieldView: View {
    @Binding var selectTeam: Team?
    @Binding var outputMessage: [Any]
    @Binding var selectedField: [Field]
    @State var currentField: Int = 3
    
    //@Binding var inputText: String
    
    var body: some View {
        
        NavigationView{
            VStack{
                //: = Field.name 받아와서 넣어야함
                Text("작업")
                    .frame(width: 344, alignment: .leading)
                    .foregroundColor(.black)
                    .font(.system(size:20))
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0))
                
                //FieldView로 빼기
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 320, height: 101)
                        .background(.blue)
                    
                    
                    switch currentField {
                    case 1:
                        InputFieldView(outputMessage: $outputMessage)
                    case 2:
                        OptionFieldView(outputMessage: $outputMessage)
                    case 3:
                        InputFieldView(outputMessage: $outputMessage)
                    case 4:
                        DateFieldView()
                    default :
                        InputFieldView(outputMessage: $outputMessage)
                    }
                    
                }//ZStack
                
                HStack{
                    
                    Spacer()
                    
                    Button("이전"){
                        print("이전 화면으로 넘어가기")
                    }
                    
                    Button("다음"){
                        print("다음 화면으로 넘어가기")

                    }
                    
                }
                .frame(width: 320)
                .tint(.blue)
            } //VStack
            
            
        }//NavigationView
    }
}



