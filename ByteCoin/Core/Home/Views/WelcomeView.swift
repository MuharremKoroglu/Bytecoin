//
//  WelcomeView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 22.02.2024.
//

import SwiftUI

struct WelcomeView: View {
    
    @StateObject var viewModel : HomeViewViewModel
    
    var body: some View {
        VStack(spacing : 10) {
            
            UserWelcome()
            AccountBalance()
            
        }.padding(.horizontal, 15)
            
    }
}

