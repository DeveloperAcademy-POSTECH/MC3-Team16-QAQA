//
//  HardModal.swift
//  QAQA
//
//  Created by 김혜린 on 2023/07/11.
//

import SwiftUI

struct HardModal: View {
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack{
            Text("Hard Hint")
        }
    }
}

struct HardModal_Previews: PreviewProvider {
    static var previews: some View {
        HardModal()
    }
}
