//
//  InputBlockSettingView.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/21.
//

import SwiftUI

struct InputBlockSettingView: View {
    @Binding var field: Field?
    @State var value: String = "input_block_field_placeholder".localized
    @State var typeBasedString: String?
    @State var bindedField: Field?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("input_block_field_text")
                .foregroundColor(Colors.Text.tertiary)
                .padding(.leading, 16)
                .padding(.top, 16)
            RoundedRectangle(cornerRadius: 4)
                .fill(Colors.Gray.tertiary)
                .overlay {
                    TextEditor(text: $value)
                        .foregroundColor(Colors.Text.secondary)
                        .textFieldStyle(.plain)
                        .multilineTextAlignment(.leading)
                        .scrollContentBackground(.hidden)
                        .padding()
                }
                .padding(.leading, 16)
                .padding(.bottom)
                .padding(.trailing)
        }
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(Colors.Gray.quaternary)
        )
        .onAppear {
            bindedField = field
            guard let string = bindedField?.wrappedTypeBasedString else { return }
            value = string
        }
        .onDisappear {
            PersistenceController.shared.updateField(field: bindedField!, typeBasedString: value)
        }
    }
}
