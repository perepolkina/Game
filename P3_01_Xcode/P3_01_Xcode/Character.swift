//  Character.swift
//  P3_01_Xcode
//  Created by Halyna on 21/05/2021.

import Foundation

enum AllHeroes {
    case king, queen, knight, archer, wizard, troll, priest
}

class Character {
    var name: String
    var type: AllHeroes
    var lifePoints: Int
    var weapon: Weapon
    
    init(name: String, lifePoints: Int, weapon: Weapon, type: AllHeroes) {
        self.name = name
        self.lifePoints = lifePoints
        self.weapon = weapon
        self.type = type
    }
    
    func actionOn(_ personnage: Character) {
        personnage.lifePoints -= self.weapon.power
        personnage.lifePoints = max(0,  personnage.lifePoints) // if lifePoints < 0 to show 0
    }
}


class King: Character {
    init() {
        super.init(name: "King", lifePoints: 70, weapon: Weapon(type: WeaponType.attack, power: 40), type: .king)
    }
}

class Queen: Character {
    init() {
        super.init(name: "Queen", lifePoints: 70, weapon:  Weapon(type: WeaponType.attack, power: 40), type: .queen)
    }
}
class Troll: Character {
    init() {
        super.init(name: "Troll", lifePoints: 50, weapon:  Weapon(type: WeaponType.attack, power: 40), type: .troll)
    }
}

class Wizard: Character {
    init() {
        super.init(name: "Wizard", lifePoints: 60, weapon:  Weapon(type: WeaponType.attack, power: 40), type: .wizard)
    }
}
class Archer: Character {
    init() {
        super.init(name: "Archer", lifePoints: 50, weapon:  Weapon(type: WeaponType.attack, power: 40), type: .archer)
    }
}

class Knight: Character {
    init() {
        super.init(name: "King", lifePoints: 50, weapon:  Weapon(type: WeaponType.attack, power: 40), type: .knight)
    }
}
// only this hero can heal
class Priest: Character {
    init() {
        super.init(name: "Priest", lifePoints: 50, weapon:  Weapon(type: WeaponType.attack, power: 20), type: .priest)
    }
    override func actionOn(_ personnage: Character) {
        personnage.lifePoints += self.weapon.power
    }
}

