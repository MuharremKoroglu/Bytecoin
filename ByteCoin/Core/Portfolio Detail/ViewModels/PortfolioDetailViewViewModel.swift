//
//  PortfolioDetailViewViewModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 10.03.2024.
//

import Foundation

@MainActor
class PortfolioDetailViewViewModel : ObservableObject {
    
    @Published var allUsers : [UserResult] = []
    
    private let networkService = NetworkService()
    
    func getAllUser () {
        
        Task {
            let response = await networkService.networkService(request: APIRequestService.allUsers, data: AllUserDataResponseModel.self)
            
            switch response {
            case .success(let allUsers):
                self.allUsers = allUsers.results ?? []
            case .failure(let failure):
                print("KULLANICI VERİLERİ GETİRİLEMEDİ : \(failure)")
            }

        }
    }
    
    
}
