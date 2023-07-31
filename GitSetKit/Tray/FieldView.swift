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
    //@Binding var selectTeam: Team?
    @Binding var selectedFields: [Field]
    @Binding var selectedField: Field?
    @Binding var outputMessage: [String]
    @Binding var selectedFieldIndex: Int
    @Binding var selectedOptions: [Option]
    @Binding var selectedDate: String
    
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
                        .onChange(of:selectedFieldIndex){ newValue in
                            if selectedFields[selectedFieldIndex].wrappedType.rawValue == 1 {
                                selectedFieldIndex += 1
//                     } else if selectedFields[selectedFieldIndex].wrappedType.rawValue == 2 {
//                           selectedOptions = selectedFields[selectedFieldIndex].wrappedOptions
//                           print(selectedOptions)
//                           }
                            }
                            
                        }
                }//ZStack
                .frame(width: 316, height: 104)
            } //VStack
        }//navigationView
        
    }
    
    func selectedFieldView(selectedFields: [Field], selectedFieldIndex: Int) -> some View {
        if selectedFieldIndex >= 0 && selectedFieldIndex < selectedFields.count {
            let currentField = selectedFields[selectedFieldIndex].wrappedType.rawValue
            
            switch currentField {
                //case 1: //constant
                //return AnyView(Text(""))
            case 2:
                return AnyView(OptionFieldView(outputMessage: $outputMessage, selectedFieldIndex: $selectedFieldIndex, selectedField: $selectedField, selectedOptions: $selectedOptions))
                
            case 3:
                return AnyView(InputFieldView(outputMessage: $outputMessage, selectedFieldIndex: $selectedFieldIndex))
            case 4:
                return AnyView(DateFieldView(outputMessage: $outputMessage, selectedFieldIndex: $selectedFieldIndex, selectedDate: $selectedDate))
            default:
                return AnyView(InputFieldView(outputMessage: $outputMessage, selectedFieldIndex: $selectedFieldIndex))
            }
        } else {
            return AnyView(Text("Field 찾을 수 없음"))
        }
    }//func - selectedFieldView
    
    
}





