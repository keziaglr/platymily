//
//  MapViewModel.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 01/05/23.
//

import SwiftUI
import CoreData
import AVFoundation

class MapViewModel: ObservableObject{
    let container: NSPersistentContainer
    @Published var savedEntities: [EntityGame] = []
    
    init() {
        container = NSPersistentContainer(name: "MC1")
        container.loadPersistentStores{(description, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error) ")
            }
        }
        fetchMap()
        if savedEntities.isEmpty {
            seedMap()
        }
    }
    
    
    func seedMap(){
        addData(name: Prompt.Games.game1.title, winner: "", status: true, rules: Prompt.Games.game1.rules, lockImage: "1_Locked", image: "1")
        addData(name: Prompt.Games.game2.title, winner: "", status: false, rules: Prompt.Games.game2.rules, lockImage: "2_Locked", image: "2")
        addData(name: Prompt.Games.game3.title, winner: "", status: false, rules: Prompt.Games.game3.rules, lockImage: "3_Locked", image: "3")
        addData(name: Prompt.Games.game4.title, winner: "", status: false, rules: Prompt.Games.game4.rules, lockImage: "4_Locked", image: "4")
        addData(name: Prompt.Games.game5.title, winner: "", status: false, rules: Prompt.Games.game5.rules, lockImage: "5_Locked", image: "5")
        addData(name: Prompt.Games.game6.title, winner: "", status: false, rules: Prompt.Games.game6.rules, lockImage: "6_Locked", image: "6")
    }
    
    func fetchMap(){
        let request = NSFetchRequest<EntityGame>(entityName: "EntityGame")
        
        do{
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func addData(name: String, winner: String, status: Bool, rules: String, lockImage: String, image: String){
        let newData = EntityGame(context: container.viewContext)
        newData.name = name
        newData.winner = winner
        newData.status = status
        newData.lockImage = lockImage
        newData.image = image
        newData.rules = rules
        saveData()
    }
    
    func saveData(){
        do{
            try container.viewContext.save()
        }catch let error{
            print("Error fetching. \(error)")
        }
    }
    
    func updateData(index: Int, scorePlaty: Int, scorePuggle: Int){
        var winner = ""
        if scorePlaty == scorePuggle {
            winner = "Tie"
        }else if scorePlaty > scorePuggle{
            winner = "Platypus"
        }else{
            winner = "Puggle"
        }
        savedEntities[index].winner = winner
        
        if index != 5{
            savedEntities[index+1].status = true
        }
        saveData()
    }
    
}
