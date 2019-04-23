//
//  PresenterProtocol.swift
//  Drinky
//
//  Created by Thijs van der Heijden on 23/04/2019.
//  Copyright © 2019 Thijs van der Heijden. All rights reserved.
//

import Foundation

protocol PresenterProtocol {
    
    associatedtype viewControllerProtocol
    var view: viewControllerProtocol { get set }
    
    init(view: viewControllerProtocol)
    func viewDidLoad()
}
