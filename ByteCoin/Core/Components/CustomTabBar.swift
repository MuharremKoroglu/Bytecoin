//
//  CustomTabBar.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 22.02.2024.
//

import SwiftUI

struct CustomTabBar: View {
    
    @Binding var selectedTab : Int

    var body: some View {
        VStack {
            HStack(alignment : .bottom) {
                ForEach(Tabs.allCases, id: \.rawValue) { tab in
                    Spacer()
                    VStack(spacing : 6) {
                        Image(systemName: selectedTab == tab.tagNumber ? tab.fillIconName : tab.iconName)
                            .font(.system(size: 22))
                            .foregroundStyle(selectedTab == tab.tagNumber ? .appMain : .gray)
                            .scaleEffect(selectedTab == tab.tagNumber ? 1.25 : 1.0)
                            .onTapGesture {
                                withAnimation(.easeIn(duration: 0.1)) {
                                    selectedTab = tab.tagNumber
                                }
                            }
                        Text(tab.rawValue)
                            .font(.caption)
                            .fontWeight(selectedTab == tab.tagNumber ? .bold : .regular)
                            .foregroundStyle(selectedTab == tab.tagNumber ? .appMain : .gray)
                            .scaleEffect(selectedTab == tab.tagNumber ? 1.25 : 1.0)
                        
                    }
                    Spacer()
                }
            }.padding()
            
        }.background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(.regularMaterial)
        )
        .padding(.leading,15)
        .padding(.trailing, 15)
        
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(1))
}
