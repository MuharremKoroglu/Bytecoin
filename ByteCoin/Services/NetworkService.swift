//
//  NetworkService.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 21.02.2024.
//

import Foundation
import Alamofire

class NetworkService {
    
    func networkService <T : Codable > (request : APIRequestService, data : T.Type) async throws -> Result<T, Error>{
        do {
            let response = try await AF.request(
                request.url,
                method: .get,
                parameters: request.parameters,
                encoder: URLEncodedFormParameterEncoder.default,
                requestModifier: {$0.timeoutInterval = 60}
            ).serializingDecodable(data.self).value
            return .success(response)
        }catch  {
            return .failure(error)
        }
    }
}

