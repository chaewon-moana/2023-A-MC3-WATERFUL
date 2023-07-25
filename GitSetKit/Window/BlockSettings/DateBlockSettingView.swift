//
//  DateBlockSettingView.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/21.
//

import SwiftUI

struct DateBlockSettingView: View {
    @Binding var field: Field?
    @State private var value = 0
    var dateFormat = ["YYYY-MM-DD", "YY-MM-DD", "MM-DD"]
    
    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(Colors.Gray.quaternary)
            .overlay(
                VStack(alignment: .leading) {
                    Text("date_block_field_text")
                        .foregroundColor(Colors.Gray.tertiary)
                        .padding(.leading, 16)
                        .padding(.top, 16)
                    
                    Picker(selection: $value) {
                        ForEach(0..<dateFormat.count, id: \.self) { idx in
                            Text("\(dateFormat[idx])")
                                .foregroundColor(Colors.Gray.primary)
                                .padding(.top)
                        }
                        .onChange(of: value) { newValue in
                            guard (field?.typeBasedString) != nil else { return }
                            
                            let newDate = dateFormatter(value: value)
                            PersistenceController.shared.updateField(field: field!, name: newDate, typeBasedString: newDate)
                        }
                    } label: { }
                        .pickerStyle(.radioGroup)
                        .padding(.leading, 8)
                }
                , alignment: .topLeading
            )
    }
    
    func dateFormatter(value: Int) -> String {
        let date = DateFormatter()
        date.locale = Locale(identifier: Locale.current.identifier)
        date.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        
        switch value {
        case 0:
            date.dateFormat = "YYYY-MM-dd"
        case 1:
            date.dateFormat = "YY-MM-dd"
        case 2:
            date.dateFormat = "MM-dd"
        default:
            date.dateFormat = "YYYY-MM-dd"
        }
        
        return date.string(from: Date())
    }
}
