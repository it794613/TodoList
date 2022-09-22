//
//  Todo+CoreDataClass.swift
//  TodoList
//
//  Created by 최진용 on 2022/09/20.
//
//

import Foundation
import CoreData


public class Todo: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "ThingsTodo")
    }

    @NSManaged public var listString: String?
}
