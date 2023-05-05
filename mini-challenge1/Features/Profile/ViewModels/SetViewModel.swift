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
        entity.isEquip = true
        saveData()
    }
    
    func seedData(){
        addSet(name: "The Normie", image: "Platypus", platy: true, isEqup: true, locked: false)
        addSet(name: "The Baguette", image: "Plat 12", platy: true, isEqup: false, locked: true)
        addSet(name: "The Monk", image: "Plat 8", platy: true, isEqup: false, locked: true)
        addSet(name: "The Normie", image: "Puggle", platy: false, isEqup: true, locked: false)
        addSet(name: "The Baguette", image: "Pug 3", platy: false, isEqup: false, locked: true)
        addSet(name: "The Monk", image: "Pug 7", platy: false, isEqup: false, locked: true)
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
