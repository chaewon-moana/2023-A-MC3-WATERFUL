//
//  TemplateView.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/16.
//

import SwiftUI
import WrappingHStack

struct TemplateCell: View {
    var field: Field
    
    var body: some View {
        Text(field.fieldName ?? "")
    }
}

enum BlockType: String {
    case text
    case date
    case option
}

struct TemplateView: View {
    var fields: [Field]
    
    @State var blockType: BlockType = .text
    @State var title: String = ""
    @State var desc: String = ""
    
    var body: some View {
        VStack {
            template
            option
        }
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.black)
        )
    }
    
    var template: some View {
        VStack {
            WrappingHStack {
                Text("git commit -m \"")
                Text("\"")
            }
            .padding()
        }
        .foregroundColor(.white)
    }
    
    var option: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("option_block_type")
                Picker("", selection: $blockType) {
                    Text("option_block_type_text")
                        .tag(BlockType.text)
                    Text("option_block_type_date")
                        .tag(BlockType.date)
                    Text("option_block_type_option")
                        .tag(BlockType.option)
                }
            }
            VStack(alignment: .leading) {
                Text("option_block_title")
                TextField("", text: $title)
            }
            VStack(alignment: .leading) {
                Text("option_block_desc")
                TextField("", text: $desc)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray)
        )
    }
}
