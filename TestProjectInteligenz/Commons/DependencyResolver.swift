//
//  DependencyResolver.swift
//  TestProjectInteligenz
//
//  Created by Jose Ignacio de Juan Díaz on 5/3/22.
//

import Foundation

@propertyWrapper
struct Inject<Component> {
    
    var component: Component?
    
    init() { }
    
    public var wrappedValue: Component {
        mutating get {
            guard let component = component else {
                let c = DependencyResolver.shared.resolve(Component.self)
                self.component = c
                return c
            }
            return component
        }
        mutating set { component = newValue }
    }
}

class DependencyResolver {
  
    static let shared = DependencyResolver()
    private var factoryDict: [String: () -> Any] = [:]
    private let lock = ResolverRecursiveLock()
    
    func register<Component>(type: Component.Type, _ factory: @escaping () -> Component) {
        lock.lock()
        defer { lock.unlock() }
        factoryDict[String(describing: type.self)] = factory
    }

    func resolve<Component>(_ type: Component.Type) -> Component {
        lock.lock()
        defer { lock.unlock() }
        if let closure = factoryDict[String(describing: Component.self)],
           let object = closure() as? Component {
            return object
        } else {
            fatalError("Not able to resolve dependency of \(String(describing: Component.self))")
        }
    }
}
   
private class ResolverRecursiveLock {
    private var recursiveMutex = pthread_mutex_t()
    private var recursiveMutexAttr = pthread_mutexattr_t()
    
    init() {
        pthread_mutexattr_init(&recursiveMutexAttr)
        pthread_mutexattr_settype(&recursiveMutexAttr, PTHREAD_MUTEX_RECURSIVE)
        pthread_mutex_init(&recursiveMutex, &recursiveMutexAttr)
    }
    
    @inline(__always)
    func lock() {
        pthread_mutex_lock(&recursiveMutex)
    }
    
    @inline(__always)
    func unlock() {
        pthread_mutex_unlock(&recursiveMutex)
    }

}
