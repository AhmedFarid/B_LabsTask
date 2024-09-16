//
//  RateView.swift
//  IOSTask
//
//  Created by Farido on 16/09/2024.
//

import SwiftUI

struct RateView: View {

    @Binding var rating: Int
    var maximumRating = 5

    var offImage: Image?
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow

    var body: some View {
        HStack {
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(for: number)
                    .foregroundStyle(number > rating ? offColor : onColor)
            }
        }
    }

    func image(for number: Int) -> Image {
        if number > rating {
            offImage ?? onImage
        } else {
            onImage
        }
    }
}

struct RateView_Previews: PreviewProvider {
    static var previews: some View {
        RateView(rating: .constant(2))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
