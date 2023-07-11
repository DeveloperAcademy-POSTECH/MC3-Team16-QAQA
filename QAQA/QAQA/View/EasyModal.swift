//
//  EasyModal.swift
//  QAQA
//
//  Created by 김혜린 on 2023/07/11.
//

import SwiftUI

struct EasyModal: View {
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack{
            Text("Easy Hint")
        }
    }
}

struct EasyModal_Previews: PreviewProvider {
    static var previews: some View {
        EasyModal()
    }
}
