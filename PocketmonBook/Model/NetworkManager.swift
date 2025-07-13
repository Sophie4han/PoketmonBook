//
//  NetworkManager.swift
//  PocketmonBook
//
//  Created by soophie on 7/2/25.
//

import Foundation
import RxSwift
import RxCocoa

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetch(limit: Int, offset: Int) -> Observable<[Result]> {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)") else {
            return .empty()
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let urlSession = URLSession.shared.rx.response(request: request)
        let response = urlSession.flatMap { response, data -> Observable<[Result]> in
            let successArrange = (200..<300)
            guard successArrange.contains(response.statusCode) else { return .empty() }
            guard let responseData = try? JSONDecoder().decode(Model.self, from: data) else {
                return .empty()
            }
            return Observable.just(responseData.results)
        }
        return response
    }
    
    func fetchDetail(pokemon_id: Int) -> Observable<Detail> {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemon_id)/") else {
            return .empty()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let urlSession = URLSession.shared.rx.response(request: request)
        let response = urlSession.flatMap { response, data -> Observable<Detail> in
            let successArrange = (200..<300)
            guard successArrange.contains(response.statusCode) else { return .empty() }
            guard let rseponseData = try? JSONDecoder().decode(Detail.self, from: data) else {
                print("❌ 디코딩 실패: \(String(data: data, encoding: .utf8) ?? "No data")")
                return .empty()
            }
            return Observable.just(rseponseData)
        }
        return response
    }
}
