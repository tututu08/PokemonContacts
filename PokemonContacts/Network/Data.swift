//
//  Untitled.swift
//  PokemonContacts
//
//  Created by 강성훈 on 4/23/25.
//

import Foundation
//데이터 가져와서 디코딩하는 함수
func fetchData (url: URL, completion: @escaping (PokemonModel?) -> Void) {
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        
        guard error == nil else{
            print("에러 발생")
            completion(nil)
            return
        }
        
        guard let data = data else{
            print("데이터 없음")
            completion(nil)
            return
        }
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            print("응답 없음")
            completion(nil)
            return
        }
        do {
            let decode = try JSONDecoder().decode(PokemonModel.self, from: data)
            print("디코딩 성공")
            completion(decode)
        } catch {
            print("디코딩 오류")
            completion(nil)
        }
    }.resume()
}
