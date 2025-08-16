//
//  WhishModel.swift
//  Whishlist
//
//  Created by Josue Lubaki on 2025-08-16.
//

import Foundation
import SwiftData

@Model
class Wish {
    var title : String
    
    init(title: String) {
        self.title = title
    }
}
