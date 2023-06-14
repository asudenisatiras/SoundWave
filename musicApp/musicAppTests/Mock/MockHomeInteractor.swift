//
//  MockHomeInteractor.swift
//  musicAppTests
//
//  Created by Asude Nisa Tıraş on 15.06.2023.
//

import Foundation
@testable import musicApp

final class MockHomeInteractor: HomeInteractorProtocol {
    
    var isInvokedFetchSearchSongs = false
    var invokedFetchSearchSongsCount = 0
    
    
    func fetchSearchSongs(_ word: String) {
        isInvokedFetchSearchSongs = true
        invokedFetchSearchSongsCount += 1
    }
    
    
}
