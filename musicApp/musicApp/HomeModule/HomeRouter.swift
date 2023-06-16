//
//  HomeRouter.swift
//  musicApp
//
//  Created by Asude Nisa Tıraş on 9.06.2023.
//

import Foundation
import musicAPI

protocol HomeRouterProtocol {
    func navigate(_ route: HomeRoutes)
}

enum HomeRoutes {
    case detail(source: Song?)
}

final class HomeRouter {
    private var isMusicPlaying: Bool {
        return SongsCellPresenter.isAnyCellPlaying
    }
    
    weak var viewController: HomeViewController?
    
    static func createModule() -> HomeViewController {
        let view = HomeViewController()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
    
}

extension HomeRouter: HomeRouterProtocol {
    
    func navigate(_ route: HomeRoutes) {
        switch route {
        case .detail(let source):
            if isMusicPlaying {
                viewController?.stopPlayingMusic()
            }
            
            let detailVC = DetailsRouter.createModule()
            detailVC.presenter.source = source
            viewController?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
}
