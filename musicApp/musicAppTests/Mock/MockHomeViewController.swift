//
//  MockHomeViewController.swift
//  musicAppTests
//
//  Created by Asude Nisa Tıraş on 15.06.2023.
//

import Foundation
@testable import musicApp

final class MockHomeViewController: HomeViewControllerProtocol {
    
    var isInvokedShowLoading = false
    var invokedShowLoadingCount = 0
    
    var isInvokedHideLoading = false
    var invokedHideLoadingCount = 0
    
    var isInvokedSetupTableView = false
    var invokedSetupTableViewCount = 0
    
    var isInvokedReloadData = false
    var invokedReloadDataCount = 0
    
    var isInvokedError = false
    var invokedErrorCount = 0

    func setupTableView() {
        isInvokedSetupTableView = true
        invokedSetupTableViewCount += 1
    }
    
    func reloadData() {
        isInvokedReloadData = true
        invokedReloadDataCount += 1
    }
    
    func showLoadingView() {
        isInvokedShowLoading = true
        invokedShowLoadingCount += 1
    }
    
    func hideLoadingView() {
        isInvokedHideLoading = true
        invokedHideLoadingCount += 1
    }
    
    func showError(_ message: String) {
        isInvokedError = true
        invokedErrorCount += 1
    }
    
    
    
}

