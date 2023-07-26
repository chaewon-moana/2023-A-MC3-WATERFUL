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
    @Binding var selectedFields: [Field]
    @Binding var selectedField: Field?
    @Binding var outputMessage: [Any]
    @Binding var selectedFieldIndex: Int
    @Binding var selectedOptions: [Option]
    
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: 320, height: 104)
                        .background(Color(red: 246/255, green: 246/255, blue: 246/255))
                        .opacity(0.48)
                    
                    selectedFieldView(selectedFields: selectedFields, selectedFieldIndex: selectedFieldIndex)
                        .frame(width: 300, height: 88)
                    
                }//ZStack
                .frame(width: 316, height: 104)
            } //VStack
        }
        
    }
    
    
    func selectedFieldView(selectedFields: [Field], selectedFieldIndex: Int) -> some View {
        if selectedFieldIndex >= 0 && selectedFieldIndex < selectedFields.count {
            let currentField = selectedFields[selectedFieldIndex].wrappedType.rawValue
            
            switch currentField {
            case 1: //constant
                return AnyView(Text(""))
            case 2:
                return AnyView(OptionFieldView(outputMessage: $outputMessage, selectedOptions: $selectedOptions))
            case 3:
                return AnyView(InputFieldView(outputMessage: $outputMessage))
            case 4:
                return AnyView(DateFieldView())
            default:
                return AnyView(InputFieldView(outputMessage: $outputMessage))
            }
        } else {
            return AnyView(Text("Field 찾을 수 없음"))
        }
    }//func - selectedFieldView


}





