//
//  SomethingTodo+CoreDataProperties.swift
//  TodoList
//
//  Created by 최진용 on 2022/09/20.
//
//

import Foundation
import CoreData


extension SomethingTodo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SomethingTodo> {
        return NSFetchRequest<SomethingTodo>(entityName: "SomethingTodo")
    }

    @NSManaged public var todoList: String?

}

extension SomethingTodo : Identifiable {

}
