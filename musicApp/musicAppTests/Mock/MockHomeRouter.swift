//
//  MockHomeRouter.swift
//  musicAppTests
//
//  Created by Asude Nisa Tıraş on 15.06.2023.
//

import Foundation
@testable import musicApp

final class MockHomeRouter: HomeRouterProtocol {
    
    var isInvokedNavigate = false
    var invokedNavigateCount = 0
    var invokedNavigateParameters: (route: HomeRoutes, Void)?
    
    func navigate(_ route: musicApp.HomeRoutes) {
        isInvokedNavigate = true
        invokedNavigateCount += 1
        invokedNavigateParameters = (route, ())
    }
    
    
}
