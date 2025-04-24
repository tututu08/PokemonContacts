//
//  TableViewCell.swift
//  PokemonContacts
//
//  Created by 강성훈 on 4/22/25.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    //셀 ID 선언
    static let id = "Pokemon"

    //셀 요소 선언해주기
    var profileImageView = UIImageView()
    let name = UILabel()
    let number = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
        
    }
    func configureCell(profile: ProfileEntity)  {
        contentView.backgroundColor = .white
        
        profileImageView.image = {
            if let data = profile.imageData {
                return UIImage(data: data)
            } else {
                return UIImage(named: "namaewa")
            }
        }()
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor.gray.cgColor
        profileImageView.layer.cornerRadius = 30
        profileImageView.clipsToBounds = true
        
        name.textColor = .black
        name.text = profile.name
        
        number.textColor = .black
        number.text = profile.phone
        
    }
    func cellLayout() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(name)
        contentView.addSubview(number)
        
        profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(40)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(60)
        }
        name.snp.makeConstraints{
            $0.leading.equalTo(profileImageView.snp.trailing).offset(20)
            $0.centerY.equalToSuperview()
        }
        number.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(40)
            $0.centerY.equalToSuperview()
        }
    }
}
