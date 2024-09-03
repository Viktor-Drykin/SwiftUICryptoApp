//
//  XmarkButton.swift
//  SwiftUICryptoApp
//
//  Created by Viktor Drykin on 03.09.2024.
//

import SwiftUI

struct XmarkButton: View {

    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button(action: {
            dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

#Preview {
    XmarkButton()
}
