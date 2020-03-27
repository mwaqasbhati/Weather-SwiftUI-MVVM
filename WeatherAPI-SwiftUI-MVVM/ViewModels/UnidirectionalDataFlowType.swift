//
//  UnidirectionalDataFlowType.swift
//  SwiftUI-MVVM
//
//  Created by M.Waqas on 3/25/20.
//  Copyright © 2020 M.Waqas. All rights reserved.
//

import Foundation

protocol UnidirectionalDataFlowType {
    associatedtype InputType
    
    func apply(_ input: InputType)
}
