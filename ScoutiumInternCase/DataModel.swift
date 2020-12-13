//
//  DataModel.swift
//  ScoutiumInternCase
//
//  Created by Huseyn Valiyev on 13.12.2020.
//

import Foundation

struct DataModel: Codable {
    let items: [DataStruct]
}

struct DataStruct: Codable {
    let title: String
    let url: String
}
