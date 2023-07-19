//
//  FieldView.swift
//  GitSetKit
//
//  Created by Cho Chaewon on 2023/07/18.
//

import Foundation
import SwiftUI

struct FieldView: View {
    
    //dummy data
    //block type에 따라서 다르게 나오도록 작성하기
    //block type - 고정텍스트, 텍스트, 선택, 날짜
    //block title -> 작업에 나오도록
    
    var body: some View {
        
        VStack{
            Text("작업")
                .frame(width: 344, alignment: .leading)
                .foregroundColor(.black)
                .font(.system(size:20))
                .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0))
            
            
            //FieldView로 빼기
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color(red:241/255 ,green:241/255 ,blue: 241/255))
                    .frame(width: 320,height: 101)
                    .opacity(0.9)
                
              
                
                
            }
        }
        
        
    }
}

struct FieldView_Previews: PreviewProvider {
    static var previews: some View {
        FieldView()
    }
}
