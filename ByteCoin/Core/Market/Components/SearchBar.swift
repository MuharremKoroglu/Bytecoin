//
//  SearchBar.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 23.02.2024.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchText : String
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(.appMain)
                .font(.system(size: 20,weight: .bold))
            
            TextField("Search by name or symbol", text: $searchText)
                .tint(.primary)
                .autocorrectionDisabled(true)
                .overlay (
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 20,weight: .bold))
                        .foregroundColor(.appMain)
                        .padding()
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    
                    ,alignment: .trailing
                )
            
        }.font(.headline)
            .padding(15)
            .background{
               RoundedRectangle(cornerRadius: 20)
                    .fill(.regularMaterial)
            }
            .padding(.horizontal,10)
            .padding(.bottom,5)
    }
}

#Preview {
    SearchBar(searchText: .constant(""))
}
