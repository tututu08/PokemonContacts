//
//  SaveProfile.swift
//  PokemonContacts
//
//  Created by 강성훈 on 4/23/25.
//

import CoreData
import UIKit
//연락처 저장하는 함수
func saveProfile(name: String, phone: String, image: UIImage?) {
    //AppDelegate에서 coredata 스택을 가져옴
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    //context에 임시로 데이터를 넣고 저장
    let context = appDelegate.persistentContainer.viewContext
    //ProfileEntity라는 Core Data 객체 생성
    let entity = ProfileEntity(context: context)
    //입력받은 이름과 전화번호를 엔티티에 할당
    entity.name = name
    entity.phone = phone
    //이미지가 있을 경우 -> jpeg데이터로 변환 후 저장
    if let image = image {
        //0.8은 압축률 (1.0 = 무압축, 0.0 = 최대압축)
        entity.imageData = image.jpegData(compressionQuality: 0.8)
    }
    //변경사항을 저장 (영구 저장소에 반영)
    do {
        try context.save()
        print("저장 성공 : \(name), \(phone)")
    } catch {
        print("저장 실패")
    }
}
