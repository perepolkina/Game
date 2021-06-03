//  Player.swift
//  P3_01_Xcode
//  Created by Halyna on 21/05/2021.

import Foundation

class Player {
    var name = ""
    var team = [Character]()
    let arrayOfCharacters = [King(), Queen(), Knight(), Archer(), Wizard(), Troll(), Priest()]
    
    func enterName(ofPlayer player: Int) {
        print("Player \(player) enter the name of your team")
        var nameOfTheTeam = (readLine() ?? "Team\(player)").trimmingCharacters(in: NSCharacterSet.whitespaces)
        while teamsName.contains(nameOfTheTeam)  { // unique names
            print("This name is already used in this game. Please enter another name:")
            nameOfTheTeam = (readLine() ?? "Team\(player)").trimmingCharacters(in: NSCharacterSet.whitespaces)
        }
        name = nameOfTheTeam
        teamsName.append(nameOfTheTeam)
    }
    
    
    // func createTeams
    func createTeam() {
        print("\n\(self.name), you'll have to pick a Hero:")
        var i = 1
        for hero in arrayOfCharacters {
            if hero.type == AllHeroes.priest {
                print("Input \(i) for hero \(hero.type) ❤️ \(hero.lifePoints) 💛💛💛 \(hero.weapon.power). Only this hero can heal instead of attack. He can even heal himself")
            } else {
                print("Input \(i) for hero \(hero.type) ❤️ \(hero.lifePoints) 💪 \(hero.weapon.power) ")
            }
            i += 1
        }
        
        print("\n\nRules: Priest heals a member of your team, others - attack a member of enemy team")
        
        var all = [Character]()
        var heroNumber = 0
        var nameOfHero  = ""
        let currentTeamName = self.name
        
        while all.count < 3 {
            print("\n \"\(currentTeamName)\", enter the number of your hero:")
            
            heroNumber = Int(readLine() ?? "0") ?? 0
            while (heroNumber < 1 || heroNumber > 7) {
                print("Try again. There is no hero with this number:")
                heroNumber = Int(readLine() ?? "0") ?? 0
            }
            print("Enter the name of your hero:")
            nameOfHero = (readLine() ?? "\(currentTeamName)").trimmingCharacters(in: NSCharacterSet.whitespaces)
            while charactersName.contains(nameOfHero) {
                print("Try again. This name already exists in this game!!!")
                nameOfHero = (readLine() ?? "\(currentTeamName)").trimmingCharacters(in: NSCharacterSet.whitespaces)
            }
            charactersName.append(nameOfHero)
            var hero: Character
            switch heroNumber {
            case 1:
                hero = King()
            case 2:
                hero = Queen()
            case 3:
                hero = Knight()
            case 4:
                hero = Archer()
            case 5:
                hero = Wizard()
            case 6:
                hero = Troll()
            case 7:
                hero = Priest()
            default:
                hero = King()
            }
            
            hero.name = nameOfHero
            all.append(hero)
        }
        
        self.team = [all[0], all[1], all[2]]
        
    }
    
    func presentCharacter() {
        print("\nTeam \(self.name):")
        var i = 1
        for hero in team {
            if hero.lifePoints < 1 {
                print("hero \(i): \(team[i - 1].name)  -  \(team[i - 1].type) ☠️ \(team[i - 1].lifePoints)  💪 \(team[i - 1].weapon.power)")
            } else {
                print("hero \(i): \(team[i - 1].name)  -  \(team[i - 1].type) ❤️ \(team[i - 1].lifePoints) 💪 \(team[i - 1].weapon.power)")
            }
            i += 1
        }
    }
    
    // additional function for code optimization
    static func chooseHero(team: [Character], enemyTeam: [Character]) {
        var heroNumber = Int(readLine() ?? "0") ?? 0// change num
        // numero of hero must be 1...3
        while heroNumber < 1 || heroNumber > 3 || team[heroNumber - 1].lifePoints < 1 {
            checkHeroNumber(heroNumber: heroNumber, team: team)
            heroNumber = Int(readLine() ?? "0") ?? 0
        }
        var  heroNumberActionOn = 0
        if team[heroNumber - 1].type == .priest {
            print("Enter hero's number of your team to heal:")
            heroNumberActionOn = Int(readLine() ?? "0") ?? 0
            while (heroNumberActionOn < 1 || heroNumberActionOn > 3 )
                    || team[heroNumberActionOn - 1].lifePoints < 1 {
                checkHeroNumber(heroNumber: heroNumberActionOn, team: team)
                heroNumberActionOn = Int(readLine() ?? "0") ?? 0
            }
            team[heroNumber - 1].actionOn(team[heroNumberActionOn - 1])
        } else {
            print("Enter hero's number of enemy team to attack:")
            heroNumberActionOn = Int(readLine() ?? "0") ?? 0
            while (heroNumberActionOn < 1 || heroNumberActionOn > 3 )
                    || enemyTeam[heroNumberActionOn - 1].lifePoints < 1 {
                checkHeroNumber(heroNumber: heroNumberActionOn, team: team)
                heroNumberActionOn = Int(readLine() ?? "0") ?? 0
            }
            team[heroNumber - 1].actionOn(enemyTeam[heroNumberActionOn - 1])
        }
    }
    
    func openBox() { // each game only for 1 random team
        let numberPower = [-20, -10, 10, 20, 25]
        print("You can open the box 🧳 🧳 🧳 . But be careful: you can increase your power or decrease. Would you like to open mystery box? Enter \"yes\" or \"no\"")
        var yourAnswer = (readLine() ?? "0").lowercased()
        
        while yourAnswer != "yes" && yourAnswer != "no" {
            print("choose between \"yes\" or \"no\"")
            yourAnswer = (readLine() ?? "0").lowercased()
        }
        
        if yourAnswer == "yes" {
            let a = numberPower.randomElement()
            print("Choose a hero of your team who will open the box")
            
            var heroNumber = Int(readLine() ?? "0") ?? 0
            while (heroNumber < 1 || heroNumber > 3) || team[heroNumber - 1].lifePoints < 1 { //check hero
                Player.checkHeroNumber(heroNumber: heroNumber, team: team)
                heroNumber = Int(readLine() ?? "0") ?? 0
            }
            team[heroNumber - 1].weapon.power += a ?? 0
            print("Your weapon changed with 💪  \"\(a!)\" points and now it's 💪 \(team[heroNumber - 1].weapon.power)") // for optional we use !
        } else  {
            print("Continue the game")
        }
    }
    
    func getAllLifes() -> Int {
        return team[0].lifePoints + team[1].lifePoints + team[2].lifePoints
    }
    
    func allHeroesArePriest() -> Bool { //
        var result = true
        for hero in team {
            if hero.type != .priest {
                result = false
            }
        }
        return result
    }
    
    func playRound(against opponent: Player) {
        let teamName = self.name
        let randomBox  = Int.random(in: 1...100) // the possibility of the appearance of a magic box
        if randomBox < 20 {
            print("Team \(teamName)")
            openBox()
        }
        print("Team \"\(teamName)\" enter the number of a hero which will perform an action:")
        Player.chooseHero(team: self.team, enemyTeam: opponent.team)
        
        self.presentCharacter()
        opponent.presentCharacter()
    }
    
    static func checkHeroNumber(heroNumber: Int, team: [Character]) {
        if heroNumber < 1 || heroNumber > 3 {
            print("Try again. There is no hero with this number") // check number
        } else {
            print("Try again. This hero is dead ☠️☠️☠️") // check lifePoints
        }
    }
}

