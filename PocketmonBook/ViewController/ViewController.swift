//
//  ViewController.swift
//  PocketmonBook
//
//  Created by soophie on 7/2/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    private let ballLogo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "pokemonBall")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let viewModel = ViewModel()
    private var disposeBag = DisposeBag()
    
    lazy var collection = UICollectionView(
        frame: .zero, collectionViewLayout: setCollection()
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        collection.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.id)
        setUpUI()
        bind()
    }
    
    private func setCollection() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 2, leading: 5, bottom: 3, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.33), heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize, repeatingSubitem: item, count: 3)
        
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func setUpUI() {
        view.backgroundColor = .mainRed
        collection.backgroundColor = UIColor(named: "cellBackground")
        [ballLogo, collection].forEach({view.addSubview($0)})
        
        ballLogo.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(80)
        }
        
        collection.snp.makeConstraints { make in
            make.top.equalTo(ballLogo.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
    }
    
    private func bind() {
        let input = ViewModel.Input(
            viewDidLoad: Observable.just(())
        )
        
        let output = viewModel.transform(input: input)
        output.imageInfo
            .bind(to: collection.rx.items(
                cellIdentifier: CollectionCell.id,
                cellType: CollectionCell.self
            )) { row, result, cell in
                cell.configure(id: row + 1)
            }
            .disposed(by: disposeBag)
        
        // 조원 코드 참고
        collection.rx.modelSelected(Detail.self)
            .subscribe(onNext: { [weak self] detail in
                let detailVC = DetailViewController(pokemonId: detail.id)
                self?.navigationController?.pushViewController(detailVC, animated: true)
            })
            .disposed(by: disposeBag)
        
//        collection.rx.itemSelected
//            .subscribe { [weak self] index in
//                self?.collection.reloadData()
//            }
//            .disposed(by: disposeBag)
    }

}

extension UIColor {
    static let mainRed = UIColor(red: 190/255, green: 30/255, blue: 40/255, alpha: 1.0)
    static let darkRed = UIColor(red: 120/255, green: 30/255, blue: 30/255, alpha: 1.0)
    static let cellBackground = UIColor(red: 245/255, green: 245/255, blue: 235/255, alpha: 1.0)
}


