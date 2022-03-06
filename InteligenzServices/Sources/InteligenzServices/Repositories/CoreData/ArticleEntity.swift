//
//  File.swift
//  
//
//  Created by Jose Ignacio de Juan Díaz on 6/3/22.
//

import Foundation
import CoreData

final class ArticleEntity: NSManagedObject {
    @NSManaged var title: String
    @NSManaged var articleDescription: String
    @NSManaged var url: String
    @NSManaged var urlToImage: String
    @NSManaged var date: Date
}
