//
//  FunnyJoke+CoreDataProperties.swift
//  ICNDBJokeDemo
//
//  Created by liuzhihui on 16/10/10.
//  Copyright © 2016年 liuzhihui. All rights reserved.
//

import Foundation
import CoreData


extension FunnyJoke {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FunnyJoke> {
        return NSFetchRequest<FunnyJoke>(entityName: "FunnyJoke");
    }

    @NSManaged public var jokeContent: String?
    @NSManaged public var updateDate: String?

}
