//
//  File.swift
//  
//
//  Created by Jose Ignacio de Juan Díaz on 6/3/22.
//

import Foundation
import CoreData
import InteligenzDomain

final class CoreDataRepository {
        
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentCloudKitContainer(name: "InteligenzModel", managedObjectModel: managedObjectModel())

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func save(articles: [ArticleRepresentable]) throws {
        let managedContext = persistentContainer.newBackgroundContext()
        try articles.forEach { article in
            guard let entity = NSEntityDescription.entity(forEntityName: "ArticleEntity", in: managedContext) else { throw CoreDataError.generic }
            let articleEntity = NSManagedObject(entity: entity, insertInto: managedContext)
            articleEntity.setValue(article.title, forKeyPath: "title")
            articleEntity.setValue(article.description, forKeyPath: "articleDescription")
            articleEntity.setValue(article.url, forKeyPath: "url")
            articleEntity.setValue(article.urlToImage, forKeyPath: "urlToImage")
            articleEntity.setValue(article.date, forKeyPath: "date")
        }
        try managedContext.save()
    }
    
    func getArticles() throws -> [ArticleRepresentable] {
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleEntity")
        fetchRequest.returnsObjectsAsFaults = false
        let results = try managedContext.fetch(fetchRequest)
        var articles: [ArticleRepresentable] = []
        for object in results {
            guard let articleEntity = object as? ArticleEntity else { continue }
            let article = Article(
                title: articleEntity.title,
                description: articleEntity.articleDescription,
                url: articleEntity.url,
                urlToImage: articleEntity.urlToImage,
                date: articleEntity.date)
            articles.append(article)
        }
        return articles
    }

    
    func deleteArticles() throws {
        let managedContext = persistentContainer.newBackgroundContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleEntity")
        fetchRequest.returnsObjectsAsFaults = false
        let results = try managedContext.fetch(fetchRequest)
        for object in results {
            guard let objectData = object as? NSManagedObject else { continue }
            managedContext.delete(objectData)
        }
        try managedContext.save()   
    }
}


private extension CoreDataRepository {
    
    enum CoreDataError: Error {
        case generic
    }
    
    struct Article: ArticleRepresentable {
        let title: String
        let description: String
        let url: String
        let urlToImage: String
        let date: Date
    }
    
    func articleEntityDescription() -> NSEntityDescription {
        let entity = NSEntityDescription()
        entity.name = "ArticleEntity"
        entity.managedObjectClassName = NSStringFromClass(ArticleEntity.self)
        let title = NSAttributeDescription()
        title.name = "title"
        title.attributeType = .stringAttributeType
        let articleDescription = NSAttributeDescription()
        articleDescription.name = "articleDescription"
        articleDescription.attributeType = .stringAttributeType
        let url = NSAttributeDescription()
        url.name = "url"
        url.attributeType = .stringAttributeType
        let urlToImage = NSAttributeDescription()
        urlToImage.name = "urlToImage"
        urlToImage.attributeType = .stringAttributeType
        let date = NSAttributeDescription()
        date.name = "date"
        date.attributeType = .dateAttributeType

        entity.properties = [title,
                             articleDescription,
                             url,
                             urlToImage,
                             date]

        return entity
    }
    
    func managedObjectModel() -> NSManagedObjectModel {
        let model = NSManagedObjectModel()
        model.entities = [articleEntityDescription()]
        return model
    }
}
