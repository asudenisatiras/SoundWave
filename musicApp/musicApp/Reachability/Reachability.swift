//
//  Reachability.swift
//  musicApp
//
//  Created by Asude Nisa Tıraş on 9.06.2023.
//

import Alamofire

final class Reachability {
    class func isConnectedToInternet() -> Bool {
        NetworkReachabilityManager()?.isReachable ?? false
    }
}
