//  Weapon.swift
//  P3_01_Xcode
//  Created by Halyna on 21/05/2021.

import Foundation

class Weapon {
    var type: WeaponType
    var power: Int
    
    init(type: WeaponType, power: Int) {
        self.type = type
        self.power = power
    }
}

enum WeaponType {
    case attack, healing
}


