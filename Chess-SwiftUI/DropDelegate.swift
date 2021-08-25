//
//  DropDelegate.swift
//  Chess-SwiftUI
//
//  Created by Mac on 30/05/2021.
//

import Foundation
import SwiftUI

struct DropViewDelegate: DropDelegate {
    var pos: Square
    func performDrop(info: DropInfo) -> Bool {
        return true
    }
    
    func dropEntered(info: DropInfo) {
        print(pos.getCoords())
    }
}
