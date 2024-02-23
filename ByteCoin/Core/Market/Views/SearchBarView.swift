//
//  SearchBarView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 23.02.2024.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchedText : String
    var body: some View {
        VStack {
            
            SearchBar(searchText: $searchedText)
            
        }
    }
}

#Preview {
    SearchBarView(searchedText: .constant(""))
}
