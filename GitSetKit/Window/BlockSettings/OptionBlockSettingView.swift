//
//  OptionBlockSettingView.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/21.
//

import SwiftUI

struct OptionBlockSettingView: View {
    var body: some View {
        ScrollView(.vertical) {
            // MARK: d
            ForEach(0..<optionCount, id: \.self) { idx in
                inputField(idx: idx)
            }
        }
        .shadow(radius: 1)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(Colors.Gray.quaternary)
        )
    }
    @State private var optionCount = 1
    
    @State private var value: String = ""
    @State private var short: String = ""
    @State private var detail: String = ""
    
    func inputField(idx: Int) -> some View {
        return HStack {
            Group {
                TextField("", text: $value, prompt: Text("option_block_field_value"))
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.center)
                Divider()
                TextField("", text: $short, prompt: Text("option_block_field_short"))
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.center)
                Divider()
                TextField("", text: $detail, prompt: Text("option_block_field_detail"))
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.center)
            }
            
            if idx == 0 {
                Button {
                    optionCount += 1
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(Colors.Text.primary)
                }
                .buttonStyle(.plain)
                .frame(width: 24, height: 24)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.accentColor)
                )
            }
            else {
                Rectangle()
                    .fill(.clear)
                    .frame(width: 24, height: 24)
            }
        }
        .padding(4)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
        )
    }
}
