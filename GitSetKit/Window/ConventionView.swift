//
//  ConventionView.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/09.
//

import SwiftUI

struct ConventionView: View {
    
    @Binding var selectedTeam: Team?
    @State var selectedField: Field?
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                // MARK: - Template View
                // Field들이 나열되는 View
                GroupBox {
                    TemplateView(team: $selectedTeam, selected: $selectedField)
                } label: {
                    Text("convention_section_template")
                        .font(.title2)
                }
                .groupBoxStyle(TransparentGroupBox())
                .padding()
                .frame(height: proxy.size.height / 2)
                // : - Template View
                
                // MARK: - Inspector View
                // 선택된 Field(= Block)을 수정하는 View
                GroupBox {
                    BlockSettingView(selected: $selectedField)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.black)
                        )
                    
                } label: {
                    Text("convention_section_block")
                        .font(.title2)
                }
                .groupBoxStyle(TransparentGroupBox())
                .padding()
                .frame(height: proxy.size.height / 2)
                // : - Inspector View
            }
        }
        .navigationTitle(Text("app_name"))
    }
}
