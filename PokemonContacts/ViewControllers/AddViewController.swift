//
//  AddViewController.swift
//  PokemonContacts
//
//  Created by 강성훈 on 4/22/25.
//

import UIKit
import CoreData

class AddViewController: UIViewController {
    
    //이미지 뷰 생성
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named: "namaewa")
        imageView.image = nil
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 100
        imageView.layer.borderWidth = 4
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    //랜덤 이미지 버튼 생성
    private lazy var randomButton: UIButton = {
        let button = UIButton()
        button.setTitle("랜덤 이미지 생성", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.addTarget(self, action: #selector(randomImageClicked), for: .touchUpInside)
        return button
    }()
    //랜덤 이미지 버튼 액션 함수 만들기
    @objc func randomImageClicked() {
        print("랜덤 이미지 생성")
        //랜덤 번호를 생성해서 URL에 넣어주기.
        let randomNum = Int.random(in: 1...1000)
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(randomNum)") else{
            print("잘못된 URL")
            return
        }
        //위에서 만든 URL 실어서 요청하고 데이터 받아오기
        fetchData(url: url) { PokemonModel in
            guard let pokemon = PokemonModel else {
                print("포켓몬 데이터를 불러오지 못했습니다")
                return
            }
            print("포켓몬 이름 : \(pokemon.name)")
            print("포켓몬 이미지 : \(pokemon.sprites.frontDefault)")
            
            //데이터
            guard let imageUrl = URL(string: pokemon.sprites.frontDefault) else {
                print("이미지 URL이 잘못되었습니다")
                return
            }
            //백그라운드 스레드에서 이미지 다운로드
            DispatchQueue.global().async {
                guard let data = try? Data(contentsOf: imageUrl),
                let image = UIImage(data: data) else {
                print("다운로드 실패")
                    return
                }
                //메인 스레드에서 UI 업데이트
                DispatchQueue.main.async{
                    self.profileImageView.image = image
                }
            }
        }
    }
    //텍스트필드는 두개 만들어서 함수로 처리함.
    func makeTextField() -> UITextField {
        let tf = UITextField()
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.gray.cgColor
//        tf.borderStyle = .roundedRect
        tf.backgroundColor = .white
        tf.textColor = .black
        return tf
    }
    //함수 실행
    private lazy var nameTextField = makeTextField()
    private lazy var phonenumTextField = makeTextField()
    
    //네비게이션바 다시 생성.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavibar()
        layoutUI()
        view.backgroundColor = .white
    }
    //네비게이션바 라벨, 버튼 생성 및 속성부여
    func configureNavibar() {
        let addFriendListLabel = UILabel()
        addFriendListLabel.text = "연락처 추가"
        addFriendListLabel.textColor = .black
        addFriendListLabel.backgroundColor = .clear
        addFriendListLabel.font = .boldSystemFont(ofSize: 20)
        self.navigationItem.titleView = addFriendListLabel
        
        let applyButton = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(applyButtonTapped))
        self.navigationItem.rightBarButtonItem = applyButton
        
    }
    //적용 버튼 액션함수
    @objc func applyButtonTapped() {
        //정보가 안들어온게 있으면 알럿띄워서 예외처리.
        guard let name = nameTextField.text, !name.isEmpty,
              let phone = phonenumTextField.text, !phone.isEmpty,
              let image = profileImageView.image else {
            print("이름 또는 전화번호 입력")
            let alert = UIAlertController(title: "입력 오류", message: "필수 입력 값이 없습니다", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            present(alert, animated: true)
            return
        }
        //데이터 저장하기.
        saveProfile(name: name, phone: phone, image: image)
        navigationController?.popViewController(animated: true)
    }
    //레이아웃
    func layoutUI() {
        [
            profileImageView,
            randomButton,
            nameTextField,
            phonenumTextField
        ].forEach { view.addSubview($0) }
        
        profileImageView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(130)
            $0.height.width.equalTo(200)
        }
        randomButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(profileImageView.snp.bottom).offset(30)
        }
        nameTextField.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(randomButton.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        phonenumTextField.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(nameTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
    }
}
