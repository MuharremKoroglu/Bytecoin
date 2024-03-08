//
//  AddWatchListButtonItem.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 7.03.2024.
//

import SwiftUI

struct AddWatchListButtonItem: View {
    
    let isInWatchList : Bool
    let buttonAction : (()->Void)?
    
    init(isInWatchList : Bool,buttonAction: (() -> Void)?) {
        self.isInWatchList = isInWatchList
        self.buttonAction = buttonAction
    }
    
    var body: some View {
        VStack {
            Button {
                buttonAction?()
            } label: {
                Image(systemName: isInWatchList ? "star.fill" : "star")
                    .font(.system(size: 20))
                    .foregroundStyle(.appMain)
                    .scaledToFit()
            }

        }
    }
}

