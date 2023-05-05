//
//  ProfileViewModel.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 02/05/23.
//

import SwiftUI
import CoreData

class SetViewModel: ObservableObject{
    let container: NSPersistentContainer
    private var savedEntities: [EntitySet] = []
    var platySet: [EntitySet] = []
    var puggleSet: [EntitySet] = []
    
    init() {
        container = NSPersistentContainer(name: "MC1")
        container.loadPersistentStores{(description, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error) ")
            }
        }
        fetchSet()
        if savedEntities.isEmpty {
            seedData()
        }
    }
    
    func fetchSet(){
        let request = NSFetchRequest<EntitySet>(entityName: "EntitySet")
        
        do{
            savedEntities = try container.viewContext.fetch(request)
            
        } catch let error {
            print("Error fetching. \(error)")
        }
        seedArray()
    }
    
    func addSet(name: String, image: String, platy: Bool, isEqup: Bool, locked: Bool){
        let newData = EntitySet(context: container.viewContext)
        newData.id = UUID()
        newData.name = name
        newData.image = image
        newData.platy = platy
        newData.isEquip = isEqup
        newData.locked = locked
        saveData()
    }
    
    func saveData(){
        do{
            try container.viewContext.save()
        }catch let error{
            print("Error fetching. \(error)")
        }
    }
    
    func unlockSet(entity: EntitySet){
        entity.locked = true
        saveData()
    }
    
    func equipSet(entity: EntitySet){
        
        if entity.platy{
            platySet.forEach { element in
                element.isEquip = false
            }
        }else{
            puggleSet.forEach { element in
                element.isEquip = false
            }
        }
        
        entity.isEquip = true
        
        saveData()
    }
    
    func getEquipSet(isPlaty: Bool) -> EntitySet? {
        if isPlaty {
            return platySet.first(where: { $0.isEquip })
        } else {
            return puggleSet.first(where: { $0.isEquip })
        }
    }
    
    
    func seedData(){
        addSet(name: "The Normie", image: "Platypus", platy: true, isEqup: true, locked: false)
        addSet(name: "The Wizard", image: "Plat 1", platy: true, isEqup: false, locked: true)
        addSet(name: "The Skater", image: "Plat 2", platy: true, isEqup: false, locked: true)
        addSet(name: "The Baker", image: "Plat 3", platy: true, isEqup: false, locked: true)
        addSet(name: "The Doctor", image: "Plat 4", platy: true, isEqup: false, locked: true)
        addSet(name: "The Sailor", image: "Plat 5", platy: true, isEqup: false, locked: true)
        addSet(name: "The Angel", image: "Plat 6", platy: true, isEqup: false, locked: true)
        addSet(name: "The Bear", image: "Plat 7", platy: true, isEqup: false, locked: true)
        addSet(name: "The Mayor", image: "Plat 8", platy: true, isEqup: false, locked: true)
        addSet(name: "The Diver", image: "Plat 9", platy: true, isEqup: false, locked: true)
        addSet(name: "The Swag", image: "Plat 10", platy: true, isEqup: false, locked: true)
        addSet(name: "The Enthusiast", image: "Plat 11", platy: true, isEqup: false, locked: true)
        addSet(name: "The Baguette", image: "Plat 12", platy: true, isEqup: false, locked: true)
        addSet(name: "The Muskeeter", image: "Plat 13", platy: true, isEqup: false, locked: true)
        addSet(name: "The Orange", image: "Plat 14", platy: true, isEqup: false, locked: true)
        addSet(name: "The Teacher", image: "Plat 15", platy: true, isEqup: false, locked: true)
        addSet(name: "The Detective", image: "Plat 16", platy: true, isEqup: false, locked: true)
        addSet(name: "The Sleeper", image: "Plat 17", platy: true, isEqup: false, locked: true)
        
        
        addSet(name: "The Normie", image: "Puggle", platy: false, isEqup: true, locked: false)
        addSet(name: "The Orange", image: "Pug 1", platy: false, isEqup: false, locked: true)
        addSet(name: "The Muskeeter", image: "Pug 2", platy: false, isEqup: false, locked: true)
        addSet(name: "The Baguette", image: "Pug 3", platy: false, isEqup: false, locked: true)
        addSet(name: "The Enthusiast", image: "Pug 4", platy: false, isEqup: false, locked: true)
        addSet(name: "The Swag", image: "Pug 5", platy: false, isEqup: false, locked: true)
        addSet(name: "The Diver", image: "Pug 6", platy: false, isEqup: false, locked: true)
        addSet(name: "The Mayor", image: "Pug 7", platy: false, isEqup: false, locked: true)
        addSet(name: "The Bear", image: "Pug 8", platy: false, isEqup: false, locked: true)
        addSet(name: "The Angel", image: "Pug 9", platy: false, isEqup: false, locked: true)
        addSet(name: "The Sailor", image: "Pug 10", platy: false, isEqup: false, locked: true)
        addSet(name: "The Doctor", image: "Pug 11", platy: false, isEqup: false, locked: true)
        addSet(name: "The Baker", image: "Pug 12", platy: false, isEqup: false, locked: true)
        addSet(name: "The Skater", image: "Pug 13", platy: false, isEqup: false, locked: true)
        addSet(name: "The Wizard", image: "Pug 14", platy: false, isEqup: false, locked: true)
        addSet(name: "The Teacher", image: "Pug 15", platy: false, isEqup: false, locked: true)
        addSet(name: "The Detective", image: "Pug 16", platy: false, isEqup: false, locked: true)
//        addSet(name: "The Sleeper", image: "Pug 17", platy: false, isEqup: false, locked: true)
    }
    
    func seedArray(){
        savedEntities.forEach { element in
            if element.platy{
                platySet.append(element)
            }else{
                puggleSet.append(element)
            }
        }
    }
}
