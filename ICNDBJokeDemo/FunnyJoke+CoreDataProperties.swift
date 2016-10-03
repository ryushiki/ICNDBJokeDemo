//
//  FunnyJoke+CoreDataProperties.swift
//  ICNDBJokeDemo
//
//  Created by liuzhihui on 16/10/3.
//  Copyright © 2016年 liuzhihui. All rights reserved.
//  This file was automatically generated and should not be edited.
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
