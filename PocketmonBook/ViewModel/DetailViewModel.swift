//
//  DetailViewModel.swift
//  PocketmonBook
//
//  Created by soophie on 7/4/25.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewModel {
    let avatarRelay = PublishRelay<Detail>()
    var disposeBag = DisposeBag()
    
    struct Input {
        let avatarProfile: Observable<Int>
    }
    
    struct Output {
        let detailInfo: Observable<Detail>
    }
    
    func transform(input: Input) -> Output {
        let profile = input.avatarProfile
            .flatMap { id in
                NetworkManager.shared.fetchDetail(pokemon_id: id)
            }
        profile
            .bind(to: avatarRelay)
            .disposed(by: disposeBag)
        return Output(detailInfo: avatarRelay.asObservable())
    }
}
