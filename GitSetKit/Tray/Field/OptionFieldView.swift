//
//  OptionFieldView.swift
//  GitSetKit
//
//  Created by Cho Chaewon on 2023/07/24.
//

import Foundation
import SwiftUI
import CoreData
import WrappingHStack

struct OptionFieldView: View {
        
    @State var selectedOptionValue: String!
    @Binding var outputMessage: [Any]
    @Binding var selectedOptions: [Option]
    
    var body: some View {
        ScrollView {
            
            WrappingHStack(selectedOptions, id: \.self, alignment: .leading, spacing: .constant(4), lineSpacing: 8) { opt in
                Button(action: {
                    let selectedOptionValue = opt.value ?? "d"
                    print(opt.value)
                }, label: {
                    Text(opt.value ?? "d")
                })
                .padding(selectedOptions.count > 8 ? 2 : 3 )
                .buttonStyle(.plain)
                .frame(width: 72, height: 40)
                .background(Color.white)
                .cornerRadius(8)
                
            }//WrappingHstack
            .foregroundColor(.black)
        }//ScrollView
        .frame(width: 300, height: 88)
        .onAppear {
            selectedOptions = PersistenceController.shared.readOption()
        }
        
        
        
    }
}

