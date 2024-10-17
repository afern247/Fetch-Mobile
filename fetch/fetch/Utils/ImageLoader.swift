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
    
    /// Loads the image from the provided URL asynchronously and updates the view.
    /// If the image is cached, it will be loaded from the cache.
    /// If the image is not cached, it will be fetched from the network.
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
    
    /// Cancels the image loading task if it's still running.
    private func cancelLoading() {
        task?.cancel()
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
    
    /// Loads an image from the cache, disk, or network asynchronously.
    /// - Parameter url: The URL of the image to load.
    /// - Returns: The loaded `Image`, or a placeholder if the image cannot be loaded.
    func loadImage(from url: URL) async -> Image {
        clearExpiredEntries()
        
        // Check if the image is cached in memory
        if let cachedUIImage = cache.object(forKey: url as NSURL),
           let expirationDate = queue.sync(execute: { expirationDates[url] }), expirationDate > Date() {
            return Image(uiImage: cachedUIImage)
        }
        
        // Check if the image is cached on disk
        if let diskImage = loadImageFromDisk(for: url) {
            cache.setObject(diskImage, forKey: url as NSURL) // Cache it in memory
            return Image(uiImage: diskImage)
        }
        
        // Fetch the image from the network
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return placeholderImage
            }
            
            guard let uiImage = UIImage(data: data) else {
                return placeholderImage
            }
            
            // Cache the image in memory and on disk
            cache.setObject(uiImage, forKey: url as NSURL)
            saveImageToDisk(uiImage, for: url)
            queue.sync {
                expirationDates[url] = Date().addingTimeInterval(cacheDuration)
            }
            
            return Image(uiImage: uiImage)
        } catch {
            return placeholderImage
        }
    }
    
    /// Saves the image to disk.
    private func saveImageToDisk(_ image: UIImage, for url: URL) {
        guard let data = image.pngData() else { return }
        let fileURL = getDiskCacheURL(for: url)
        try? data.write(to: fileURL)
    }
    
    /// Loads the image from disk if available.
    private func loadImageFromDisk(for url: URL) -> UIImage? {
        let fileURL = getDiskCacheURL(for: url)
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        return UIImage(data: data)
    }
    
    /// Returns the file URL for the cached image on disk.
    private func getDiskCacheURL(for url: URL) -> URL {
        let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let hashedFileName = url.absoluteString.sha256() // Generates a unique hash for the URL
        return cacheDirectory.appendingPathComponent(hashedFileName)
    }
    
    /// Clears expired entries from the cache.
    private func clearExpiredEntries() {
        let now = Date()
        queue.sync {
            expirationDates = expirationDates.filter { $0.value > now }
        }
    }
}
