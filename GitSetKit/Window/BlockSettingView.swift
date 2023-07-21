//
//  BlockSettingView.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/16.
//

import SwiftUI

struct OptionBlockView: View {
    var body: some View {
        ScrollView(.vertical) {
            // MARK: d
            inputField
        }
        .padding()
    }
    
    @State private var value: String = ""
    @State private var short: String = ""
    @State private var detail: String = ""
    var inputField: some View {
        HStack {
            TextField("", text: $value, prompt: Text("option_block_field_value"))
                .textFieldStyle(.plain)
                .multilineTextAlignment(.center)
            Divider()
            TextField("", text: $value, prompt: Text("option_block_field_short"))
                .textFieldStyle(.plain)
                .multilineTextAlignment(.center)
            Divider()
            TextField("", text: $value, prompt: Text("option_block_field_detail"))
                .textFieldStyle(.plain)
                .multilineTextAlignment(.center)
            Button {
                
            } label: {
                Image(systemName: "plus")
            }
            .buttonStyle(.plain)
            .frame(width: 24, height: 24)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.accentColor)
            )
        }
        .padding(4)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray)
        )
    }
}

struct BlockSettingView: View {
    var body: some View {
        OptionBlockView()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.black)
            )
    }
}

struct BlockSettingView_Previews: PreviewProvider {
    static var previews: some View {
        GroupBox {
            BlockSettingView()
        } label: {
            Text("convention_section_block")
                .font(.title3.bold())
        }
        .groupBoxStyle(TransparentGroupBox())
        .padding()
    }
}
