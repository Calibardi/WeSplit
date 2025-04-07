//
//  View+.swift
//  WeSplit
//
//  Created by Lorenzo Ilardi on 07/04/25.
//

import SwiftUI

extension View {
    func alerted(_ condition: Bool) -> some View {
        modifier(AlertedText(alerted: condition))
    }
}
