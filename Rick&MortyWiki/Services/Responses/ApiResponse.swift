//
//  ApiResponse.swift
//  Rick&MortyWiki
//
//  Created by Daniel Baquedano on 15/3/23.
//

import Foundation

struct ApiResponse<DataType: Decodable>: Decodable {
    let info: Info
    let results: [DataType]
}
