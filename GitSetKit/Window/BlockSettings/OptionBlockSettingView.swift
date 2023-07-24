//
//  OptionBlockSettingView.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/21.
//

import SwiftUI

struct OptionBlockSettingView: View {
    @Binding var field: Field?
    @State private var optionList: [Option] = []
    @State private var value: [String] = [""]
    @State private var shortDesc: [String] = [""]
    @State private var detailDesc: [String] = [""]
    @State private var isHover: [Bool] = [false]
    
    var body: some View {
        ScrollView(.vertical) {
            inputField(idx: 0)
            Spacer()
            Spacer()
            ForEach(1..<optionList.count + 1, id: \.self) { idx in
                inputField(idx: idx)
            }
        }
        .scrollIndicators(.hidden)
        .shadow(radius: 1)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(Colors.Gray.quaternary)
        )
        .onAppear {
            if let options = field?.wrappedOptions {
                optionList = options
                
                for idx in 0..<optionList.count {
                    value.append(optionList[idx].value ?? "")
                    shortDesc.append(optionList[idx].shortDesc ?? "")
                    detailDesc.append(optionList[idx].detailDesc ?? "")
                    isHover.append(false)
                }
            }
        }
    }
    
    func inputField(idx: Int) -> some View {
        return HStack {
            Group {
                TextField("", text: $value[idx], prompt: Text("option_block_field_value"))
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.center)
                    .onChange(of: value[idx]) { newValue in
                        if idx != 0 {
                            optionList[idx - 1].value = newValue
                            PersistenceController.shared.updateField(field: field!, options: optionList)
                        }
                    }
                Divider()
                TextField("", text: $shortDesc[idx], prompt: Text("option_block_field_short"))
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.center)
                    .onChange(of: shortDesc[idx]) { newValue in
                        if idx != 0 {
                            optionList[idx - 1].shortDesc = newValue
                            PersistenceController.shared.updateField(field: field!, options: optionList)
                        }
                    }
                Divider()
                TextField("", text: $detailDesc[idx], prompt: Text("option_block_field_detail"))
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.center)
                    .onChange(of: detailDesc[idx]) { newValue in
                        if idx != 0 {
                            optionList[idx - 1].detailDesc = newValue
                            PersistenceController.shared.updateField(field: field!, options: optionList)
                        }
                    }
            }
            
            
            if idx == 0 {
                Button {
                    createOption(idx)
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                }
                .buttonStyle(.plain)
                .frame(width: 24, height: 24)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.accentColor)
                        .onTapGesture {
                            createOption(idx)
                        }
                )
            }
            else {
                Button {
                    deleteOption(idx)
                } label: {
                    Image(systemName: "minus")
                        .foregroundColor(isHover[idx] ? .white : .red)
                }
                .buttonStyle(.plain)
                .frame(width: 24, height: 24)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(isHover[idx] ? .red : Colors.Gray.quaternary)
                        .onTapGesture {
                            deleteOption(idx)
                        }
                )
                .onHover { newHover in
                    if idx != optionList.count + 1 {
                        isHover[idx] = newHover
                    }
                }
            }
        }
        .padding(4)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
        )
    }
    
    func createOption(_ idx: Int) {
        let count = optionList.count
        let newOption = PersistenceController.shared.createOption(value: value[0], shortDesc: shortDesc[0], detailDesc: detailDesc[0])
        
        optionList.append(newOption)
        
        value.append(optionList[count].value ?? "")
        shortDesc.append(optionList[count].shortDesc ?? "")
        detailDesc.append(optionList[count].detailDesc ?? "")
        isHover.append(false)
        
        PersistenceController.shared.updateField(field: field!, options: optionList)
    }
    
    func deleteOption(_ idx: Int) {
        DispatchQueue.main.async {
            optionList.remove(at: idx - 1)
            
            value.remove(at: idx)
            shortDesc.remove(at: idx)
            detailDesc.remove(at: idx)
            isHover.remove(at: idx)
            
            PersistenceController.shared.updateField(field: field!, options: optionList)
        }
    }
}

struct OptionBlockSettingView_Previews: PreviewProvider {
    static var previews: some View {
        OptionBlockSettingView()
    }
}
