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
    
        //OptionField -> Option 받아오기
        let workBlock = ["feat", "fix", "refactor", "docs", "style", "test", "chore"]
    
        @State var selectedOptionValue: String = ""
    
        var body: some View {
            ScrollView {
                LazyVStack {
                    WrappingHStack(workBlock, id: \.self, alignment: .leading, spacing: .constant(4), lineSpacing: 8) { block in
                        Button(action: {
                            selectedOptionValue = block
                            print(selectedOptionValue)
                        }, label: {
                            Text(block)
                        })
                        .buttonStyle(.plain)
                        .frame(width: 72, height: 40)
                        .background(Color.yellow)
                        .cornerRadius(8)
                                                
                    }
                    .foregroundColor(.black)
                }
                .frame(width: 304, height: 96)
                //.padding(.top, 24) -> workBlock 8개 이상되면 추가 필요함
                
            }
            
        }
    }

struct Previews_OptionFieldView: PreviewProvider {
    static var previews: some View {
        OptionFieldView()
    }
}
