//
//  Person.swift
//  HitList
//
//  Created by Joshua Adams on 2/22/15.
//  Copyright (c) 2015 Josh Adams. All rights reserved.
//

import Foundation
import CoreData

//@objc(Person)

class Person: NSManagedObject {
    @NSManaged var name: String
}
