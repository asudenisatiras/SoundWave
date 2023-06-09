//
//  Response.swift
//  
//
//  Created by Asude Nisa Tıraş on 9.06.2023.
//

import Foundation

public struct SongsResponse: Decodable {
    public let results: [SearchResponse]
   
    
    private enum RootCodingKeys: String, CodingKey {
        case results
        
        
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootCodingKeys.self)
        self.results = try container.decode([SearchResponse].self, forKey: .results)
       
    }
    
}
