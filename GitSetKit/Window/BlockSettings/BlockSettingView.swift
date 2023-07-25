//
//  BlockSettingView.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/16.
//

import SwiftUI

struct BlockSettingView: View {
    @Binding var selected: Field?
    
    var body: some View {
        if let selected = selected {
            switch selected.wrappedType {
            case .option:
                OptionBlockSettingView(field: $selected)
                
            case .input:
                InputBlockSettingView(field: $selected)
                
            case .date:
                DateBlockSettingView(field: $selected)
                
            default:
                Spacer()
                
            }
        } else {
            Spacer()
        }
    }
}
