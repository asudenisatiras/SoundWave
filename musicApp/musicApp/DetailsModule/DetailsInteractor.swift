//
//  DetailsInteractor.swift
//  musicApp
//
//  Created by Asude Nisa Tıraş on 9.06.2023.
//

import Foundation

protocol DetailsInteractorProtocol {
    func saveTrackId(_ trackId: Int64, artistName: String, trackName: String)
}

class DetailsInteractor: DetailsInteractorProtocol {
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    func saveTrackId(_ trackId: Int64, artistName: String, trackName: String) {
        coreDataManager.saveAudioData(trackId: trackId, artistName: artistName, trackName: trackName)
    }
}
