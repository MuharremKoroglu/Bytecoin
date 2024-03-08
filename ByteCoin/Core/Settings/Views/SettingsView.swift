//
//  SettingsView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 8.03.2024.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        
        NavigationStack {
            GeometryReader{ geometry in
                let size = geometry.size
                List {
                    SectionItem(sectionType: .project, imageWidth: size.width * 0.25, imageHeight: size.height * 0.15)
                    SectionItem(sectionType: .firebase, imageHeight: size.height * 0.15)
                    SectionItem(sectionType: .coinApi, imageHeight: size.height * 0.15)
                    SectionItem(sectionType: .kafein, imageHeight: size.height * 0.15)
                    

                }.navigationTitle("Settings")
            }

            
        }
    }
}

#Preview {
    SettingsView()
}
