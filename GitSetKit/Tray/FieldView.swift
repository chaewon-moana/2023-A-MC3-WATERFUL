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
    
    //dummy data
    //block type에 따라서 다르게 나오도록 작성하기
    //block type - 텍스트, 선택, 날짜
    //block title -> 작업에 나오도록

    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var selected: Team?
    
    
    var body: some View {
        
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
                
               
                DateFieldView()
                    .frame(width: 304 ,height: 85, alignment: .topLeading)
//
//                if let selected = selectedField {
//                    switch selectedField!.wrappedType {
//                    case .constant:
//                        OptionFieldView() //ConstantBlockSettingView 어디갔,,,
//
//                    case .option:
//                        OptionFieldView()
//
//                    case .input:
//                        InputFieldView()
//
//                    case .date:
//                        DateFieldView()
//
//                    }
//
//
//                }
                
            }
        }
//        .onAppear{
//            let generator = DefaultDataGenerator(managedObjectContext)
//            let fields = generator.generateFields()
//            let team = generator.generateTeam(fields)
//            
//            self.selected = team
//            
//            
//            
//            PersistenceController.shared.saveContext()
//        }
    }
}





struct FieldView_Previews: PreviewProvider {
    static var previews: some View {
        FieldView()
    }
}
