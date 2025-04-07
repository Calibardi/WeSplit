//
//  Modifiers.swift
//  WeSplit
//
//  Created by Lorenzo Ilardi on 07/04/25.
//

import SwiftUI

struct AlertedText: ViewModifier {
    let alerted: Bool
    
    func body(content: Content) -> some View {
        if alerted {
            content
                .foregroundStyle(.red)
        } else {
            content
        }
    }
}
