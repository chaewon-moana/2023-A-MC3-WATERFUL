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
    
    @Binding var selectedTeam: Team!
    @Binding var outputMessage: [Any]
    @State var selectedField: [Field] = []
    @State var currentField: Int = 2
    
    //@Binding var inputText: String
    
    var body: some View {
        
        VStack{
            //: = Field.name 받아와서 넣어야함
            Text("\(selectedField.count)")
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
                    OptionFieldView(outputMessage: $outputMessage, Fields: $selectedField)
                case 3:
                    InputFieldView(outputMessage: $outputMessage)
                case 4:
                    DateFieldView()
                default :
                    InputFieldView(outputMessage: $outputMessage)
                }
              
            }
        }
        .onAppear{
            selectedField = PersistenceController.shared.readField(selectedTeam)
        }
        
    }
}



