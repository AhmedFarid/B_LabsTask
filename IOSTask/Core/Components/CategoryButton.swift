//
//  CategoryButton.swift
//  IOSTask
//
//  Created by Farido on 16/09/2024.
//

import SwiftUI

struct CategoryButton: View {

    var text: String
    var isSelected: Bool

    var body: some View {
        Text(text)
            .font(.headline)
            .foregroundStyle(isSelected ? .primary : .secondary)
            .frame(maxHeight: 40)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray, lineWidth: 1)
                    .fill(isSelected ? .gray : .clear)
            )
    }
}

#Preview {
    CategoryButton(text: "Category", isSelected: false)
}
