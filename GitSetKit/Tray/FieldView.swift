//
//  FieldView.swift
//  GitSetKit
//
//  Created by Cho Chaewon on 2023/07/18.
//

import Foundation
import SwiftUI
import WrappingHStack
import CoreData

struct FieldView: View {
    

//    @Binding var team: Team?
//    @State var selectedField: Field?
    
    var body: some View {
        
        VStack{
            //: = Field.name 받아와서 넣어야함
            Text("작업")
                .frame(width: 344, alignment: .leading)
                .foregroundColor(.black)
                .font(.system(size:20))
                .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0))
            
            
            //FieldView로 빼기
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 320, height: 101)
                    .background(.blue)
                
               
                //Field type에 따라서 View 다르게 불러와야하는데,,,
                DateFieldView()
                    .frame(width: 304 ,height: 85, alignment: .topLeading)


                
            }
        }
     
    }
}





//struct FieldView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        FieldView()
//    }
//}
