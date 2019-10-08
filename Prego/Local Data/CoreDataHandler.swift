//
//  CoreDataHandler.swift
//  Prego
//
//  Created by owner on 9/22/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public class CoreDaTaHandler: NSObject {

    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    class func saveCart(itemID:String, image: String, title: String, specialRequest: String, desc:String, quantity:Int32, totalPrice:Double, infoId: String, optionsIds: String, extraIds: String, mDate:String) ->Bool {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Cart", in: context)
        let managedObject = NSManagedObject(entity: entity!, insertInto: context)
        
        managedObject.setValue(itemID, forKey: "item_id")
        managedObject.setValue(image, forKey: "image")
        managedObject.setValue(desc, forKey: "desc")
        managedObject.setValue(quantity, forKey: "quantity")
        managedObject.setValue(title, forKey: "title")
        managedObject.setValue(specialRequest, forKey: "special_request")
        managedObject.setValue(totalPrice, forKey: "total_price")
        
        managedObject.setValue(infoId, forKey: "info_id")
        managedObject.setValue(extraIds, forKey: "extra_ids")
        managedObject.setValue(optionsIds, forKey: "options_ids")
        
        managedObject.setValue(mDate, forKey: "mDate")
        do {
            try context.save()
            return true
        }catch{
            return false
        }
    }

    class func getCarts() -> [Cart]? {
        let context = getContext()
        var items:[Cart]? = nil
        do {
            items = try context.fetch(Cart.fetchRequest()) as? [Cart]
            return items
        }catch{
            return items
        }
    }
    
    class func deleteObject(id: String) -> Bool {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        let predicate = NSPredicate(format: "mDate == %@", id as CVarArg)
        fetchRequest.predicate = predicate
        let context = getContext()
        let result = try? context.fetch(fetchRequest)
        let resultData = result as! [Cart]
        
        for object in resultData {
            context.delete(object)
        }
        
        do {
            try context.save()
            return true
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
            return false
        }
    }
    
    class func updateCart(mDate: String, quantity: Int32, cart: Cart) -> Bool {

        
        let managedContext = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        fetchRequest.predicate = NSPredicate(format: "mDate = %@", mDate as CVarArg)
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            let managedObject = test[0] as! NSManagedObject
            managedObject.setValue(cart.item_id, forKey: "item_id")
            managedObject.setValue(cart.image, forKey: "image")
            managedObject.setValue(cart.desc, forKey: "desc")
            managedObject.setValue(quantity, forKey: "quantity")
            managedObject.setValue(cart.title, forKey: "title")
            managedObject.setValue(cart.total_price, forKey: "total_price")
            managedObject.setValue(mDate, forKey: "mDate")
            do{
                try managedContext.save()
                return true
            }
            catch{
                return false
            }
        }catch{
            return false
        }
        
    }
    
    class func cleanData() ->Bool {
        let context = getContext()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: Cart.fetchRequest())
        do {
            try context.execute(deleteRequest)
            return true
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
            return false
        }
    }
}
