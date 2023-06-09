//
//  MusicModel.swift
//  
//
//  Created by Asude Nisa Tıraş on 9.06.2023.
//

import Foundation

public struct SearchResponse: Codable {
    public  let resultCount: Int?
    public    let results: [Song]?
}

public struct Song: Codable {
    public let wrapperType: String?
    public let kind: String?
    public let artistId: Int?
    public let collectionId: Int?
    public let trackId: Int?
    public let artistName: String?
    public let collectionName: String?
    public let trackName: String?
    public let collectionCensoredName: String?
    public let trackCensoredName: String?
    public let artistViewUrl: String?
    public let collectionViewUrl: String?
    public let trackViewUrl: String?
    public let previewUrl: String?
    public let artworkUrl30: String?
    public let artworkUrl60: String?
    public   let artworkUrl100: String?
    public   let collectionPrice: Float?
    public   let trackPrice: Float?
    public   let releaseDate: String?
    public   let collectionExplicitness: String?
    public  let trackExplicitness: String?
    public  let discCount: Int?
    public    let discNumber: Int?
    public    let trackCount: Int?
    public    let trackNumber: Int?
    public    let trackTimeMillis: Int?
    public    let country: String?
    public    let currency: String?
    public    let primaryGenreName: String?
    public    let isStreamable: Bool?
}

