//
//  ImageLoader.swift
//  fetch
//
//  Created by Arturo on 10/16/24.
//

import SwiftUI

struct LoadImageFromUrl: View {
    let urlString: String
    @State private var image: Image = Image(illustration: .spinnerImage)
    @State private var isLoading = false
    @State private var task: Task<Void, Never>? // Tracks the task for cancellation
    
    var body: some View {
        image
            .resizable()
            .scaledToFill()
            .clipped() // To ensure the image is clipped to the container's bounds
            .onAppear {
                if !isLoading {
                    loadImage()
                }
            }
            .onDisappear {
                cancelLoading() // Cancel the task when the view disappears
            }
    }
    
    private func loadImage() {
        guard let url = URL(string: urlString) else { return }
        isLoading = true
        
        task = Task {
            let loadedImage = await ImageCache.shared.loadImage(from: url)
            DispatchQueue.main.async {
                self.image = loadedImage
                self.isLoading = false
            }
        }
    }
    
    private func cancelLoading() {
        task?.cancel() // Cancel the task if it's still running
        isLoading = false
    }
}

class ImageCache {
    static let shared = ImageCache()
    
    private let cache = NSCache<NSURL, UIImage>()
    private var expirationDates = [URL: Date]()
    private let cacheDuration: TimeInterval = 86400 // 1 day in seconds
    private let queue = DispatchQueue(label: "com.imageCache.expirationDatesQueue") // Serial queue for thread safety
    let placeholderImage: Image = Image(systemName: "photo") // Placeholder image
    
    func loadImage(from url: URL) async -> Image {
        clearExpiredEntries()
        
        if let cachedUIImage = cache.object(forKey: url as NSURL),
           let expirationDate = queue.sync(execute: { expirationDates[url] }), expirationDate > Date() {
            return Image(uiImage: cachedUIImage)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return placeholderImage
            }
            
            guard let uiImage = UIImage(data: data) else {
                return placeholderImage
            }
            
            cache.setObject(uiImage, forKey: url as NSURL)
            queue.sync {
                expirationDates[url] = Date().addingTimeInterval(cacheDuration)
            }
            
            return Image(uiImage: uiImage)
        } catch {
            return placeholderImage
        }
    }
    
    private func clearExpiredEntries() {
        let now = Date()
        queue.sync {
            expirationDates = expirationDates.filter { $0.value > now }
        }
    }
}
