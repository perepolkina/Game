//  Player.swift
//  P3_01_Xcode
//  Created by Halyna on 21/05/2021.

import Foundation

class Player {
    var teamsName = [String]()
    var team1 = [Character]()
    var team2 = [Character]()
    var checkName = [String]() // check hero's names
    var arrayOfCharacters = [King(), Queen(), Knight(), Archer(), Wizard(), Troll(), Priest()]
    
    func enterName() {
        teamsName.removeAll() // to delete previous names of the team
        print("Let's start. Player 1 enter the name of your team")
        var nameOfTheTeam = (readLine() ?? "Team1").trimmingCharacters(in: NSCharacterSet.whitespaces) // to delete whitespaces
        teamsName.append(nameOfTheTeam)
        
        print("Player 2 enter the name of your team")
        nameOfTheTeam = readLine() ?? "Team2"
        while teamsName.contains(nameOfTheTeam)  { // unique names
            print("This name is already used in this game. Please enter another name:")
            nameOfTheTeam = (readLine() ?? "Team2").trimmingCharacters(in: NSCharacterSet.whitespaces)
        }
        teamsName.append(nameOfTheTeam)
        print("Nice to meet you team \"\(teamsName[0])\" and team \"\(teamsName[1])\"")
        
    }
    
    
    // func createTeams
    func createTeams() {
        print("Each team has to choose 3 heroes from the list below and to assign a name to each hero. Hero's name should be unique")
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
        checkName.removeAll()
        
        var all = [Character]()
        var heroNumber = 0
        var nameOfHero  = "" // change nameOfHero
        
        while all.count < 6 {
            if  all.count < 3 {
                print("\nPlayer 1 enter the number of your hero")
            } else {
                print("\nPlayer 2 enter the number of your hero")
            }
            
            heroNumber = Int(readLine() ?? "0") ?? 0
            while (heroNumber < 1 || heroNumber > 7) {
                print("Try again. There is no hero with this number:")
                heroNumber = Int(readLine() ?? "0") ?? 0
            }
            print("Enter the name of your hero:")
            nameOfHero = (readLine() ?? "Team1").trimmingCharacters(in: NSCharacterSet.whitespaces)
            while checkName.contains(nameOfHero) {
                print("Try again. This name already exists in this game!!!")
                nameOfHero = (readLine() ?? "Team1").trimmingCharacters(in: NSCharacterSet.whitespaces)
            }
            checkName.append(nameOfHero)
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
        team1 = [all[0], all[1], all[2]]
        team2 = [all[3], all[4], all[5]]
        print(" Well done. The both teams are complete:")
        
    }
    
    func presentCharacter (team: [Character], teamsName: String) {
        print("\nTeam \(teamsName):")
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
    func chooseHero(team: [Character], enemyTeam: [Character]) {
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
    
    func startBattle(){
        var round = 1
        var allLifes1 = team1[0].lifePoints + team1[1].lifePoints + team1[2].lifePoints// need to update for loop  while allLifes1 > 1 || allLifes2 > 1
        var allLifes2 = team2[0].lifePoints + team2[1].lifePoints + team2[2].lifePoints
        
        presentCharacter (team: team1, teamsName: teamsName[0])
        presentCharacter(team: team2, teamsName: teamsName[1])
        if (team1[0].type ==  .priest && team1[1].type ==  .priest &&  team1[2].type ==  .priest)
            && (team2[0].type ==  .priest && team2[1].type ==  .priest &&  team2[2].type ==  .priest)
        {
            print("This game have no sense. Try to choose another heroes next time")
        } else {
            while allLifes1 > 1 || allLifes2 > 1 {
                //round Team 1
                var randomBox  = Int.random(in: 1...100) // the possibility of the appearance of a magic box
                //print(randomBox) // delete
                if randomBox < 20 {
                    print("Team \(teamsName[0])")
                    box(team: team1)
                }
                print("Team \"\(teamsName[0])\" enter the number of a hero which will perform an action")
                chooseHero(team: team1, enemyTeam: team2)
                presentCharacter (team: team1, teamsName: teamsName[0])
                presentCharacter(team: team2, teamsName: teamsName[1])
                allLifes1 = team1[0].lifePoints + team1[1].lifePoints + team1[2].lifePoints
                allLifes2 = team2[0].lifePoints + team2[1].lifePoints + team2[2].lifePoints
                if allLifes2 < 1 {
                    break
                }
                //round Team 2
                randomBox  = Int.random(in: 1...100) //
                //print(randomBox) // delete
                if randomBox < 20 {
                    print("Team \(teamsName[1])")
                    box(team: team2)
                }
                print("Team \(teamsName[1]) it's your turn. Choose a hero of your team")
                chooseHero(team: team2, enemyTeam: team1)
                presentCharacter (team: team1, teamsName: teamsName[0])
                presentCharacter(team: team2, teamsName: teamsName[1])
                round += 1
                allLifes1 = team1[0].lifePoints + team1[1].lifePoints + team1[2].lifePoints
                allLifes2 = team2[0].lifePoints + team2[1].lifePoints + team2[2].lifePoints
                if allLifes1 < 1 {
                    break
                }
            }
            print("GAME OVER in \(round) rounds!!!")
            if allLifes1 == allLifes2 {
                print ("There is no winner ")
            } else if allLifes1 < 1 {
                print ("The Winner is \(teamsName[1])")
            } else {
                print ("The Winner is \(teamsName[0])")
            }
        }
    }
    func box(team: [Character]) { // each game only for 1 random team
        let numberPower = [-20, -10, 10, 20, 25]
        print("You can open the box . But be careful: you can increase your power or decrease. Would you like to open mystery box? Enter \"yes\" or \"no\"")
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
                checkHeroNumber(heroNumber: heroNumber, team: team)
                heroNumber = Int(readLine() ?? "0") ?? 0
            } // check !!!!
            team[heroNumber - 1].weapon.power += a ?? 0
            print("Your weapon is changed with 💪  \"\(a!)\" points and now it's 💪 \(team[heroNumber - 1].weapon.power)") // for optional we use !
        } else  {
            print("Continue the game")
        }
    }
    
    func checkHeroNumber(heroNumber: Int, team: [Character]) {
        if heroNumber < 1 || heroNumber > 3 {
            print("Try again. There is no hero with this number") // check number
        } else {
            print("Try again. This hero is dead ☠️☠️☠️") // check lifePoints
        }
    }
}
