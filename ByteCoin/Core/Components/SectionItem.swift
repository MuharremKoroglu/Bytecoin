//
//  SectionItem.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 8.03.2024.
//

import SwiftUI

struct SectionItem: View {
    
    let sectionType : SettingsViewSectionModel
    let imageWidth : CGFloat?
    let imageHeight : CGFloat
    
    init(sectionType : SettingsViewSectionModel,imageWidth: CGFloat? = nil, imageHeight: CGFloat) {
        self.sectionType = sectionType
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
    }
    
    
    var body: some View {
        Section {
            VStack(alignment: .leading) {
                Image(sectionType.sectionImage)
                    .resizable()
                    .frame(width: imageWidth, height: imageHeight)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.bottom,10)
                Text(sectionType.sectionContent)
                    .font(.caption)
                    .fontWeight(.semibold)
                    
            }.padding(.vertical)
            Link(sectionType.linkTitle, destination: URL(string: sectionType.linkUrl) ?? URL(string: "https://www.google.com/")!)
        } header: {
            Text(sectionType.sectionTitle)
                
        }
    }
}

