//
//  ProfileViewModel.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 02/05/23.
//

import SwiftUI
import CoreData

class ProfileViewModel: ObservableObject{
    let container: NSPersistentContainer
    @Published var savedEntities: [EntityProfile] = []
    
    init() {
        container = NSPersistentContainer(name: "MC1")
        container.loadPersistentStores{(description, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error) ")
            }
        }
        fetchProfile()
        if savedEntities.isEmpty {
            registerProfile(name: "Family Name")
        }
    }
    
    func fetchProfile(){
        let request = NSFetchRequest<EntityProfile>(entityName: "EntityProfile")
        
        do{
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func registerProfile(name: String){
        let newData = EntityProfile(context: container.viewContext)
        newData.name = name
        newData.level = 1
        newData.coin = 0
        saveData()
    }
    
    func saveData(){
        do{
            try container.viewContext.save()
        }catch let error{
            print("Error fetching. \(error)")
        }
    }
    
    func updateName(name: String){
        savedEntities[0].name = name
        saveData()
    }
    
    func getCoin(coin: Int64){
        savedEntities[0].coin += coin
        saveData()
    }
    
    func buyGacha(coin: Int64) -> Bool{
        
        if savedEntities[0].coin >= coin {
            savedEntities[0].coin -= coin
            saveData()
            return true 
        }
        return false //cannot buy
    }
    
    func levelUp(index: Int){
        if index != 5 && savedEntities[0].level == index+1{
            savedEntities[0].level = Int64(index+2)
            saveData()
        }
    }
}
