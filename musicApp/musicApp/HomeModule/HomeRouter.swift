//
//  HomeRouter.swift
//  musicApp
//
//  Created by Asude Nisa Tıraş on 9.06.2023.
//

//import UIKit
//import musicAPI
//
//
//protocol HomeRouterProtocol {
//    func navigateToDetail(with title: String)
//}
//
//final class HomeRouter {
////    weak var navigationController: UINavigationController?
//     var homeVC: HomeViewController?
//
////    init(navigationController: UINavigationController? = nil) {
////        self.navigationController = navigationController
////    }
//
//    static func createModule() -> HomeViewController? {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let view = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
//        let interactor = HomeInteractor()
//        let router = HomeRouter()
//        let presenter = HomePresenter(interactor: interactor, router: router, view: view!)
//        view?.presenter = presenter
//        interactor.presenter = presenter
//        router.homeVC = view
//        return view
//    }
//}
//
//extension HomeRouter: HomeRouterProtocol {
//
//    func navigateToDetail(with title: String) {
//        let detailVC = DetailsRouter.createModule()
//        homeVC?.navigationController!.pushViewController(detailVC, animated: true)
//       // homeVC?.present(detailVC, animated: true)
//        print("Şarkının adı: \(title)")
//    }
//}

import Foundation
import musicAPI

protocol HomeRouterProtocol {
    func navigate(_ route: HomeRoutes)
}

enum HomeRoutes {
    case detail(source: Song?)
}

final class HomeRouter {
    
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
            
            let detailVC = DetailsRouter.createModule()
            detailVC.presenter.source = source
            viewController?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
}
