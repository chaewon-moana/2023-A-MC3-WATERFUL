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
    case constant
}

struct TemplateView: View {
    var fields: [Field]
    
    @State var blockType: BlockType = .text
    @State var title: String = ""
    @State var desc: String = ""
    
    var body: some View {
        VStack {
            template
                .padding()
            Spacer()
            option
        }
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.black)
        )
    }
    
    // MARK: - Template View
    var template: some View {
#if DEBUG
        WrappingHStack(0..<30, id: \.self, alignment: .leading, spacing: .constant(8), lineSpacing: 8) { i in
            Text("\(i)")
        }
        .foregroundColor(.white)
#else
        ScrollView {
            LazyVStack {
                WrappingHStack(0..<300, id: \.self, alignment: .leading, spacing: .constant(8), lineSpacing: 8) { i in
                    Text("\(i)")
                }
                .foregroundColor(.white)
            }
        }
#endif
    }
    
//: - Template View
    
    // MARK: - Option View
    var option: some View {
        HStack {
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
            VStack(alignment: .leading) {
                Text("option_block_title")
                TextField("", text: $title)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                    )
            }
            VStack(alignment: .leading) {
                Text("option_block_desc")
                TextField("", text: $desc)
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
    //: - Option View
}

struct ConventionView_Preview1s: PreviewProvider {
    static func getTeams() -> [Team] {
        var teams: [Team] = Array()
        
        for i in 0..<5 {
            let team = Team(context: PersistenceController.shared.container.viewContext)
            team.id = UUID()
            team.name = "🍪 team \(i)"
            team.desc = "This is an example of team \(i)"
            teams.append(team)
        }
        
        return teams
    }
    
    static var previews: some View {
        NavigationSplitView {
            TeamView(teams: getTeams(), selected: .constant(getTeams()[0]), teamVM: TeamViewModel())
        } detail: {
            NavigationStack {
                ConventionView(selected: .constant(getTeams()[0]))
            }
        }
    }
}
