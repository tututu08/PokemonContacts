//
//  ViewController.swift
//  PokemonContacts
//
//  Created by 강성훈 on 4/22/25.
//

import UIKit
import SnapKit
import CoreData

class PokemonListViewController: UIViewController  {
    //coredata에서 불러온 데이터를 배열에 저장
    private var profiles: [ProfileEntity] = []
    
    //라벨 생성
    private let friendListLabel : UILabel = {
        let label = UILabel()
        label.text = "친구 목록"
        label.textColor = .black
        label.backgroundColor = .clear
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    //테이블뷰 생성
    private let contactsTableView : UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = .white
        // 셀 구분선 좌우 여백
        tableview.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return tableview
    }()
    
    //버튼 생성
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //네비게이션 바 숨김(버튼 클릭 방해)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        //저장된 프로필 로드하기
        fetchProfiles()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        tableViewRegister()
        view.backgroundColor = .white
        
        // 버튼 액션 연결
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    // 추가 버튼 눌렀을 때 실행되는 함수 AddViewController로 이동
    @objc func addButtonTapped() {
        let addVC = AddViewController()
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    // 화면 레이아웃 구성
    func configureUI() {
        view.backgroundColor = .white
        view.addSubview(contactsTableView)
        view.addSubview(friendListLabel)
        view.addSubview(addButton)
        
        friendListLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(80)
        }
        addButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(friendListLabel.snp.centerY)
        }
        contactsTableView.snp.makeConstraints {
            $0.top.equalTo(friendListLabel.snp.bottom).offset(30)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    // 테이블 뷰 설정 및 등록
    func tableViewRegister(){
        contactsTableView.register(TableViewCell.self, forCellReuseIdentifier: "pokemon")
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
    }
    // coredata에서 프로필 데이터를 불러오는 함수
    func fetchProfiles() {
        // AppDelegate에서 CoreData context 가져오기
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        // 데이터 요청 객체 생성
        let request = NSFetchRequest<ProfileEntity>(entityName: "ProfileEntity")
        do {
            // fetch()로 데이터 가져오기
            profiles = try context.fetch(request)
            // 테이블뷰 갱신
            contactsTableView.reloadData()
        } catch {
            print(" 프로필 데이터 불러오기 실패: \(error.localizedDescription)")
        }
    }
}
extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource {
    //셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profiles.count
    }
    // 각 셀에 표시할 데이터
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contactsTableView.dequeueReusableCell(withIdentifier: "pokemon", for: indexPath) as! TableViewCell
        let profile = profiles[indexPath.row]
        cell.configureCell(profile: profile)
        return cell
    }
    //셀 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 //
    }
}
