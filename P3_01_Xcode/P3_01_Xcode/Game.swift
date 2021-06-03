//  Game.swift
//  P3_01_Xcode
//  Created by Halyna on 28/05/2021.

import Foundation

class Game {
    
    func startGame() {
        while true {
            let player1 = Player()
            let player2 = Player()
            
            print("Let's start.")
            player1.enterName(ofPlayer: 1)
            player2.enterName(ofPlayer: 2)
            
            print("\n\nNice to meet you \"\(player1.name)\" and \"\(player2.name)\"")
            
            print("\n\nEach team has to choose 3 heroes from the list below and to assign a name to each hero. Hero's name should be unique")
            player1.createTeam()
            player2.createTeam()
            
            print("\n\n*** Well done. The both teams are complete: ***")
            startBattle(player1: player1, player2: player2)
            
            print("Would you like to restart the game. You need to write \"yes\" or \"no\"")
            var answer = (readLine() ?? "0").lowercased()
            
            while answer != "yes" && answer != "no" {
                print("Choose between \"yes\" or \"no\"")
                answer = (readLine() ?? "0").lowercased()
            }
            if answer == "no" {
                print("***See you soon***")
                break
            } else if answer == "yes" {
                resetGame()
            }
        }
    }
    
    func startBattle(player1: Player, player2: Player){
        var round = 1
        var allLifes1 = player1.getAllLifes() // need to update for loop  while allLifes1 > 1 || allLifes2 > 1
        var allLifes2 = player2.getAllLifes()
        
        player1.presentCharacter()
        player2.presentCharacter()
        
        if player1.allHeroesArePriest() && player2.allHeroesArePriest(){
            print("This game have no sense. Try to choose another heroes next time")
        } else {
            while allLifes1 > 1 || allLifes2 > 1 {
                
                // Player 1 starts
                player1.playRound(against: player2)
                allLifes2 = player2.getAllLifes()
                round += 1
                
                if allLifes2 < 1 {
                    break
                }
                
                // Then Player 2 plays
                player2.playRound(against: player1)
                allLifes1 = player1.getAllLifes()
                round += 1
                
                if allLifes1 < 1 {
                    break
                }
                
            }
            print("\n\n*** GAME OVER in \(round) rounds!!! ***")
            if allLifes1 == allLifes2 {
                print ("There is no winner ")
            } else if allLifes1 < 1 {
                print ("***The Winner is \(player2.name)***")
            } else {
                print ("***The Winner is \(player1.name)***")
            }
        }
    }
    
    func resetGame(){
        teamsName.removeAll() // to delete previous names of the team
        charactersName.removeAll()
    }
    
}


