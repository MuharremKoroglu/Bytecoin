//
//  CustomProgressView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 14.03.2024.
//

import SwiftUI

struct CustomProgressView: View {
    var body: some View {
        ProgressView()
            .scaleEffect(1.8)
            .tint(.white)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 100, height: 100)
                    .foregroundStyle(Color.black.opacity(0.8))
            )
    }
}

#Preview {
    CustomProgressView()
}
