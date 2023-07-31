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
            VStack(spacing: 20) {
                // MARK: - Template View
                // Field들이 나열되는 View
                GroupBox {
                    TemplateView(team: $selectedTeam, selected: $selectedField)
                } label: {
                    Text("convention_section_template")
                        .font(.title2.bold())
                }
                .groupBoxStyle(TransparentGroupBox())
                .frame(height: proxy.size.height / 10 * 3)
                // : - Template View
                
                // MARK: - Block Option View
                if selectedTeam != nil && selectedField != nil {
                    GroupBox {
                        VStack {
                            BlockOptionView(selectedTeam: $selectedTeam, selectedField: $selectedField)
                                .padding(.top, 16)
                            BlockSettingView(selected: $selectedField)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.black)
                                )
                        }
                    } label: {
                        Text("convention_section_block")
                            .font(.title2.bold())
                    }
                    .groupBoxStyle(TransparentGroupBox())
                    .frame(height: proxy.size.height / 10 * 6)
                }
                // : - Inspector View
            }
        }
        .padding()
        .navigationTitle(Text(selectedTeam?.wrappedName ?? "app_name".localized))
    }
}
