//
// MusicService.swift
//  
//
//  Created by Asude Nisa Tıraş on 9.06.2023.
//

import Foundation
import Alamofire

public protocol SongsServiceProtocol: AnyObject {
    func searchSongs(wordName: String, completion: @escaping (Result<[Song], Error>) -> Void)
}

public class MusicService: SongsServiceProtocol {
    public init() {}
    
    enum YourErrorType: Error {
        case nilSongsError
    }
    
    public func searchSongs(wordName: String, completion: @escaping (Result<[Song], Error>) -> Void) {
        let encodedTerm = wordName.replacingOccurrences(of: " ", with: "+")
        let urlString = "https://itunes.apple.com/search?term=\(encodedTerm)&country=tr&entity=song&attribute=mixTerm"
        AF.request(urlString).responseData { response in
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let searchResponse = try decoder.decode(SearchResponse.self, from: data)
                    if let songs = searchResponse.results {
                        completion(.success(songs))
                        print("Retrieved data: \(songs)")
                    } else {
                        
                        completion(.failure(YourErrorType.nilSongsError))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

