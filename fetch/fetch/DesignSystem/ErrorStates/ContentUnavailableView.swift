//
//  ContentUnavailableView.swift
//  fetch
//
//  Created by Arturo on 10/16/24.
//

import SwiftUI

enum ContentUnavailableType {
    case error
}
/// `ContentUnavailableView` is a view component designed to display a customizable message when content is unavailable.
/// It supports customization for general errors, with options to specify images, titles, and messages.
/// A button can be optionally included for actions like retrying a failed operation.
///
/// Usage:
/// ```swift
/// ContentUnavailableView(type: .error,
///                        buttonTitle: "Retry",
///                        onButtonTap: { /* Handle retry action */ })
/// ```
///
/// or
///
/// ```swift
/// ContentUnavailableView(type: .error,
///                        image: "exclamationmark.triangle",
///                        title: "Error",
///                        message: "An unexpected error occurred.",
///                        buttonTitle: "Retry",
///                        onButtonTap: { /* Handle retry action */ })
/// ```
///
/// - Parameters:
///   - type: The type of content unavailable scenario, e.g., `.error`.
///   - image: An optional image name for displaying a specific icon. Uses system images.
///   - title: An optional title for the message. Defaults to "Error" if not provided.
///   - message: An optional detailed message. Defaults to "Something went wrong." if not provided.
///   - buttonTitle: An optional title for the button. If not provided, the button is not displayed.
///   - onButtonTap: An optional closure to be executed when the button is tapped. If `nil`, the button is not displayed.
struct ContentUnavailableView: View {
    
    var type: ContentUnavailableType = .error
    
    // Optionals for better flexibility
    var image: String?
    var title: String?
    var message: String?
    var buttonTitle: String?
    var onButtonTap: (() -> Void)?
    var isRetryLoading: Bool?
    
    var body: some View {
        VStack(alignment: .center) {
            content
            if let onButtonTap = onButtonTap {
                Button(action: onButtonTap) {
                    if isRetryLoading ?? false {
                        ProgressView()
                    } else {
                        Text(buttonTitle ?? "Retry")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 150)
                            .background(Color.brandPrimary)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        Image(systemName: image ?? "exclamationmark.triangle")
            .resizable()
            .scaledToFit()
            .foregroundColor(.fillSecondary)
            .frame(height: 50)
        Text(title ?? "Error")
            .font(.title)
            .multilineTextAlignment(.center)
            .padding(.top, 10)
        Text(message ?? "Something went wrong.")
            .font(.body)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
            .padding(.top, 2)
    }
}

#Preview {
    Group {
        ContentUnavailableView(type: .error)
        ContentUnavailableView(type: .error, image: "flame.fill", title: "Ups", message: "Something's burning")
        ContentUnavailableView(type: .error, buttonTitle: "Retry", onButtonTap: {})
        ContentUnavailableView(type: .error, buttonTitle: "Retry", onButtonTap: {}, isRetryLoading: true)
    }
}
