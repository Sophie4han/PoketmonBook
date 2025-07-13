//
//  CollectionViewCell.swift
//  PocketmonBook
//
//  Created by soophie on 7/2/25.
//

import UIKit
import SnapKit
import Kingfisher

class CollectionCell: UICollectionViewCell {
    
    static let id = "CollectionCell"
    
    let poketmonImg: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 4
        image.clipsToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        contentView.addSubview(poketmonImg)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        poketmonImg.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(id: Int) {
        
        guard let url = URL(
            string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png"
        ) else {
            return
        }
        poketmonImg.kf.setImage(with: url)

    }
}
