//
//  PocketmonModel.swift
//  PocketmonBook
//
//  Created by soophie on 7/2/25.
//

import Foundation

struct Model: Decodable {
    let results: [Result]
}

struct Result: Decodable {
    let name: String
    let url: String
}

struct Detail: Decodable {
    let name: String
    let types: [TypeElement]
    let id: Int
    let weight: Int
    let height: Int
}

struct TypeElement: Decodable {
    let slot: Int
    let type: Species
}

struct Species: Decodable {
    let name: String
    let url: String
}

