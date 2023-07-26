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
    
    var body: some View {
        
        DatePicker(
            "\(Image(systemName: "calendar"))",
            selection: $date,
            displayedComponents: [.date]
        )
        .frame(width: 300, height: 88, alignment: .leading)
        .foregroundColor(.black)
        .datePickerStyle(.field)
        
        
        //date값 형식에 맞게 수정하는 코드
        
        //[DateBlockSettingView.swift] - [dateFormat], Date() 형식이 어떻게 이뤄지는지 알아서 format변환
        
        
    }
}
