//
//  StatePResenter.swift
//  ThirdWayvChallenge
//
//  Created by Mostafa Samir on 06/02/2022.
//

import UIKit

enum State {
    case loading
    case loadingMore
    case error(Error)
    case empty
    case populated
    case refresh
}


protocol StatePresentable: UIViewController {
    func render(state: State)
}
