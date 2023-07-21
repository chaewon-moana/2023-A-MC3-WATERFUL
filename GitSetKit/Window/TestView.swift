//
//  TestView.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/21.
//

import SwiftUI
import WrappingHStack


struct TestView: View {
    var body: some View {
        ScrollView {
            WrappingHStack(0..<300) { i in
                Text("text \(i)")
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
