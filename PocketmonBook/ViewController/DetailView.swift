//
//  DetailView.swift
//  PocketmonBook
//
//  Created by soophie on 7/4/25.
//

import UIKit
import SnapKit
import Kingfisher

class DetailView: UIView {
    
    private let detailImage: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30)
        label.textColor = .white
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private let weightLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private let heightLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private let infoBG: UIView = {
       let label = UIView()
        label.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        label.layer.cornerRadius = 10
        return label
    }()
    
    private lazy var infoStack: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                nameLabel, typeLabel, weightLabel, heightLabel]
        )
        stack.axis = .vertical
        stack.spacing = 2
        stack.alignment = .center
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        addSubview(infoBG)
        [detailImage, infoStack].forEach({infoBG.addSubview($0)})
        
        infoBG.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        detailImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(40)
            make.bottom.equalTo(infoStack.snp.top).offset(-10)
            make.height.equalTo(detailImage.snp.width).multipliedBy(0.8)
        }
        
        infoStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(infoBG.snp.bottom).inset(20)
        }
    }
    
    func configure(data: Detail) {
        nameLabel.text = data.name
        typeLabel.text = "\(data.types)"
        weightLabel.text = "무게 : \(data.weight)"
        heightLabel.text = "키 : \(data.height)"
        setUpImage(id: data.id)
    }
    
    func setUpImage(id: Int) {
        guard let url = URL(
            string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png"
        ) else {
            return
        }
        detailImage.kf.setImage(with: url)
    }
}
