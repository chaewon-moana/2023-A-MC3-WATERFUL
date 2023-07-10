//
//  Team.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/09.
//

import Foundation

struct Team: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var name: String
    var desc: String?
    var template: String
    var fields: [Field]
}
