//
//  ViewModel.swift
//  PocketmonBook
//
//  Created by soophie on 7/2/25.
//

import UIKit
import RxSwift
import RxCocoa

class ViewModel {
    
    let imageRelay = PublishRelay<[Result]>()
    var disposeBag = DisposeBag()
    
    struct Input {
        let viewDidLoad: Observable<Void>
    }
    
    struct Output {
        let imageInfo: Observable<[Result]>
    }
    
    func transform(input: Input) -> Output {
        let result = input.viewDidLoad
            .flatMap { _ in
                NetworkManager.shared.fetch(limit: 20, offset: 0)
            }
        result
            .bind(to: imageRelay)
            .disposed(by: disposeBag)
        
        return Output(
            imageInfo: imageRelay.asObservable()
        )
    }
}
