//
//  DetailsRouter.swift
//  musicApp
//
//  Created by Asude Nisa Tıraş on 9.06.2023.
//

import Foundation

protocol DetailsRouterProtocol {
    
}

final class DetailsRouter: DetailsRouterProtocol {
    
    weak var viewController: DetailsViewController?
    
    static func createModule() -> DetailsViewController {
        let view = DetailsViewController()
        let router = DetailsRouter()
        let presenter = DetailsPresenter(view: view, router: router)
        view.presenter = presenter
        router.viewController = view
        return view
    }
    
}
