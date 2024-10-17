//
//  RecipeListModel.swift
//  fetch
//
//  Created by Arturo on 10/16/24.
//

import Foundation

struct Recipe: Codable {
    @DecodableDefault<DefaultEmptyString> var cuisine: String
    @DecodableDefault<DefaultEmptyString> var name: String
    @DecodableDefault<DefaultEmptyString> var photoURLLarge: String
    @DecodableDefault<DefaultEmptyString> var photoURLSmall: String
    @DecodableDefault<DefaultEmptyString> var sourceURL: String
    @DecodableDefault<DefaultEmptyString> var uuid: String
    @DecodableDefault<DefaultEmptyString> var youtubeURL: String

    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case uuid
        case youtubeURL = "youtube_url"
    }
}

struct RecipesResponse: Codable {
    @DecodableDefault<DefaultEmptyArray<Recipe>> var recipes: [Recipe]
}
