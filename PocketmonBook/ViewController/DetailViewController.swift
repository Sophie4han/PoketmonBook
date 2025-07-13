//
//  DetailViewController.swift
//  PocketmonBook
//
//  Created by soophie on 7/4/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {
    
    private let rootView = DetailView()
    private let viewModel = DetailViewModel()
    private let infoRelay = PublishRelay<Int>()
    private let pokemonId: Int
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        bind()
    }
    
    init(pokemonId: Int) {
        self.pokemonId = pokemonId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        view.backgroundColor = .mainRed
        view.addSubview(rootView)
        
        rootView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    // 프로젝트 참고
    private func bind() {
        let input = DetailViewModel.Input(avatarProfile: infoRelay.asObservable())
        
        let output = viewModel.transform(input: input)
        output.detailInfo
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] detail in
                self?.rootView.configure(data: detail)
            }
            .disposed(by: disposeBag)
        infoRelay.accept(pokemonId) // 없으면 네트워크 매니저가 실행 안함..?
    }
}
