//  Game.swift
//  P3_01_Xcode
//  Created by Halyna on 28/05/2021.

import Foundation

class Game {
    let players =  Player()
    
    func startGame() {
        while true {
            players.enterName()
            players.createTeams()
            players.startBattle()
            
            print("Would you like to restart the game. You need to write \"yes\" or \"no\"")
            var answer = (readLine() ?? "0").lowercased()
            
            while answer != "yes" && answer != "no" {
                print("Choose between \"yes\" or \"no\"")
                answer = (readLine() ?? "0").lowercased()
            }
            if answer == "no" {
                print("See you soon")
                break
            }
        }
    }
}

