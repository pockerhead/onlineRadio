//
//  PlayerInteractor.swift
//  OnlineRadio
//
//  Created Артём Балашов on 19/01/2019.
//  Copyright © 2019 Артём Балашов. All rights reserved.
//
//  Template generated by Sakhabaev Egor @Banck
//  https://github.com/Banck/Swift-viper-template-for-xcode
//

import UIKit

class PlayerInteractor: PlayerInteractorInput {

    
    // MARK: - Properties
    weak var presenter: PlayerInteractorOutput?
    
    // MARK: - PlayerInteractorInput -
    
    func fetchStreamURL(with stationID: Int) {
        PlayerService.fetchStreamURL(with: stationID)
            .done {[weak self] (url) in
                self?.presenter?.fetched(with: url.replacingOccurrences(of: "\"", with: ""))
            }.catch {[weak self] (error) in
                self?.presenter?.fetched(with: error)
            }.finally {
                
        }
    }
    
}
