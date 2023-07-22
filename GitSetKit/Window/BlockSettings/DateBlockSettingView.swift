//
//  DateBlockSettingView.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/21.
//

import SwiftUI

struct DateBlockSettingView: View {
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
                    } label: { }
                        .pickerStyle(.radioGroup)
                        .padding(.leading, 8)
                }
                , alignment: .topLeading
            )
    }
    
    @State private var value = 0
    private var dateFormat = ["YYYY-MM-DD", "YY-MM-DD", "MM-DD"]
}

struct DateBlockSettingView_Previews: PreviewProvider {
    static var previews: some View {
        DateBlockSettingView()
    }
}
