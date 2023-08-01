//
//  NewOptionBlockSettingView.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/08/01.
//

import SwiftUI
import WrappingHStack

struct OptionBlockCell: View {
    var option: Option
    
    @Binding var selected: Option?
    
    var body: some View {
        VStack(spacing: 4) {
            if let value = option.value, let shortDesc = option.shortDesc {
                HStack {
                    Spacer()
                    Text(value)
                        .font(.body.bold())
                        .lineLimit(1)
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text(shortDesc)
                        .font(.system(size: 11))
                        .foregroundColor(Colors.Text.secondary)
                        .lineLimit(1)
                    Spacer()
                }
            }
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(selected?.id == option.id ? Color.accentColor : Colors.Background.primary)
                .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)
        )
    }
}

struct NewOptionBlockSettingView: View {
    @Binding var field: Field?
    
    @State private var selected: Option? = nil
    
    @State private var renderId: UUID = UUID()
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        if let field = field {
            VStack(spacing: 0) {
                ScrollView {
                    let item = GridItem(.adaptive(minimum: 120, maximum: 180), spacing: 8)
                    let column = [item]
                    LazyVGrid(columns: column, alignment: .leading, spacing: 8) {
                        ForEach(field.wrappedOptions) { option in
                            OptionBlockCell(option: option, selected: $selected)
                                .onTapGesture {
                                    selected = option
                                }
                        }
                        .id(renderId)
                    }
                    .padding()
                }
                .background(Colors.Background.secondary)
                
                Divider()
                
                toolbar
            }
            .background(Colors.Background.secondary)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 1)
        }
    }
    
    var toolbar: some View {
        HStack(spacing: 4) {
            Button {
                let newOption = Option(context: managedObjectContext)
                newOption.value = ""
                newOption.detailDesc = ""
                newOption.shortDesc = ""
                
                self.field?.addToOptions(newOption)
                
                PersistenceController.shared.saveContext()
                
                renderId = UUID()
                
            } label: {
                Image(systemName: "plus")
            }
            .buttonStyle(.plain)
            .frame(width: 24, height: 24)
            
            Divider()
                .frame(height: 24)
            
            Button {
                if let field = field, let options = field.options, let selected = selected {
                    let index = options.index(of: selected)
                    var options = field.wrappedOptions
                    options.remove(at: index)
                    
                    self.field!.options = NSOrderedSet(array: options)
                    
                    PersistenceController.shared.deleteOption(selected)
                    
                    renderId = UUID()
                }
            } label: {
                Image(systemName: "minus")
            }
            .buttonStyle(.plain)
            .frame(width: 24, height: 24)
            
            Spacer()
        }
        .padding(4)
        .background(
            Colors.Background.tertiary
        )
    }
}
