//
//  Field.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/09.
//

import Foundation

struct Field: Codable, Hashable {
    var fieldName: String
    var desc: String
    
    var string: String?
    var option: OptionField?
    var input: InputField?
    var script: ScriptField?
}

struct OptionField: Codable, Hashable {
    var options: [Option]
    var multiple: Bool = false
    
    struct Option: Identifiable, Codable, Hashable {
        var title: String
        var value: String
        
        var id: String {
            value
        }
    }
}

struct InputField: Codable, Hashable {
    var placeholder: String
    var inputStyle: InputStyle
    
    enum InputStyle: String, Codable, Hashable {
        case singleLine
        case multiLine
    }
}

struct ScriptField: Codable, Hashable {
    var script: Script
    
    enum Script: String, Codable, Hashable {
        case date
    }
}
