//
//  DateFieldView.swift
//  GitSetKit
//
//  Created by Cho Chaewon on 2023/07/24.
//

import Foundation
import SwiftUI
import CoreData

struct DateFieldView: View {
    
    @State var date = Date()
    @Binding var outputMessage: [String]
    @Binding var selectedFieldIndex: Int
    
    //@Binding var value: Int
    var dateFormatArray = ["YYYY-MM-dd", "YY-MM-dd", "MM-dd"]

    
    var body: some View {
        
        DatePicker(
            "\(Image(systemName: "calendar"))",
            selection: $date,
            displayedComponents: [.date]
        )
        .frame(width: 300, height: 88, alignment: .leading)
        .foregroundColor(.black)
        .datePickerStyle(.field)
        .onChange(of: date) { newValue in
            //DateBlockSetting 형식에 맞게 출력할 수 있도록 챱챱
//            let dateFormat = DateFormatter()
//            dateFormat.dateFormat = dateFormatArray[value]
//            let dateString = dateFormatter.string(from: newValue)
//            outputMessage[selectedFieldIndex] = dateString
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            let formattedDate = dateFormatter.string(from: newValue)
            outputMessage[selectedFieldIndex] = formattedDate
            
//            dateFormatter.dateFormat = "YYYY-MM-dd"
//            let dateString = dateFormatter.string(from: today)
            
        }
        
        
        
    }
}
