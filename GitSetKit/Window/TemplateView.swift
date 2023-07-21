//
//  TemplateView.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/16.
//

import SwiftUI
import WrappingHStack

fileprivate struct BlockCell: View {
    @StateObject var field: Field
    var selected: Bool = false
    
    var body: some View {
        Text(field.wrappedName)
            .padding(4)
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(selected ? Color.accentColor : Color.gray)
            )
    }
}

fileprivate struct TextCell: View {
    var text: String
    
    var body: some View {
        Text(text)
    }
}

fileprivate enum BlockType: String {
    case text
    case date
    case option
    case constant
}

// MARK: - TemplateView
struct TemplateView: View {
    var team: Team
    
    @State private var blockType: BlockType = .text
    @State private var title: String = ""
    
    @State private var selected: Field?
    
    @State private var renderId: UUID = UUID()
    
    var body: some View {
        VStack {
            blocksView
                .padding()
            Spacer()
            blockOptionView
        }
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.black)
        )
    }
    
    // MARK: - Blocks View
    var blocksView: some View {
        ScrollView {
            WrappingHStack(alignment: .leading, spacing: .constant(8), lineSpacing: 8) {
                // PlaceHolder
                TextCell(text: "git commit -m \"")
                
                // Actual Fields
                ForEach(team.wrappedFields.indices, id: \.self) { i in
                    // Block Cell
                    BlockCell(field: team.wrappedFields[i], selected: selected?.id == team.wrappedFields[i].id)
                        .padding(.horizontal, 4)
                        .onTapGesture {
                            selected = team.wrappedFields[i]
                        }
                        .contextMenu {
                            contextMenuBuilder(i)
                        }
                }
                .onLoad {
                    guard let first = team.wrappedFields.first else {
                        return
                    }
                    
                    selected = first
                }
                
                
                Button {
                    let field = PersistenceController.shared.createField(name: "block_new_field_name".localized, type: Field.FieldType.constant.rawValue, order: 0, typeBasedString: "")
                    PersistenceController.shared.addTeamField(team: team, field: field)
                    
                } label: {
                    Text("+")
                        .foregroundColor(.white)
                }
                .buttonStyle(.plain)
                .frame(width: 24, height: 24)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray)
                )

                TextCell(text: "\"")
            }
            .id(renderId)
            .foregroundColor(.white)
        }
    }
    //: - Blocks View
    
    // MARK: Context Menu
    @ViewBuilder
    func contextMenuBuilder(_ i: Int) -> some View {
        // Move Left Button
        Button(role: .none) {
            var newField = team.wrappedFields
            newField.move(fromOffsets: IndexSet(integer: i), toOffset: i - 1)
            PersistenceController.shared.updateTeam(team: team, fields: newField)
            
            renderId = UUID()
            
        } label: {
            Label("block_context_move_left", systemImage: "arrow.left")
        }
        .disabled(i <= 0)
        
        // Move Right Button
        Button(role: .none) {
            var newField = team.wrappedFields
            newField.move(fromOffsets: IndexSet(integer: i), toOffset: i + 1)
            PersistenceController.shared.updateTeam(team: team, fields: newField)
            
            renderId = UUID()
            
        } label: {
            Label("block_context_move_right", systemImage: "arrow.right")
        }
        .disabled(i >= team.wrappedFields.count - 1)
        
        // Delete Button
        Button(role: .none) {
            PersistenceController.shared.deleteField(team.wrappedFields[i])
            
            renderId = UUID()
            
        } label: {
            Label("block_context_delete", systemImage: "trash.fill")
        }
    }
    
    // MARK: - Block Option View
    var blockOptionView: some View {
        HStack {
            // MARK: Block Type
            VStack(alignment: .leading) {
                Text("option_block_type")
                Picker("", selection: $blockType) {
                    Text("option_block_type_constant")
                        .tag(BlockType.constant)
                    Text("option_block_type_text")
                        .tag(BlockType.text)
                    Text("option_block_type_date")
                        .tag(BlockType.date)
                    Text("option_block_type_option")
                        .tag(BlockType.option)
                }
            }
            // MARK: Block Title
            VStack(alignment: .leading) {
                Text("option_block_title")
                TextField("", text: $title)
                    .textFieldStyle(.plain)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                    )
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray)
        )
    }
    //: - Block Option View
}
//: - TemplateView

struct ConventionView_Previews1: PreviewProvider {
    static func getTeams() -> [Team] {
        var teams: [Team] = Array()
        
        for i in 0..<5 {
            let team = Team(context: PersistenceController.shared.container.viewContext)
            team.name = "team \(i)"
            team.emoticon = "🍪"
            team.touch = Date()
            team.pinned = false
            teams.append(team)
        }
        
        return teams
    }
    
    static var previews: some View {
        NavigationSplitView {
            TeamView(teams: getTeams(), selected: .constant(getTeams()[0]))
        } detail: {
            NavigationStack {
                ConventionView(selected: .constant(getTeams()[0]))
            }
        }
    }
}
