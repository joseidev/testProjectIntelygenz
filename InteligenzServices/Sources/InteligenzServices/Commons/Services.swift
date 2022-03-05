
import Foundation
import ServicesLibrary
import InteligenzDomain

/// This class implements de RepositoryProvider protocol
/// Resolve protocol with dependency injector to get access to repositories
/// Ex: @Inject private var repositoryProvider: RepositoriesProvider
public final class Services {
    
    let networkClientManager = NetworkClientManager(client: DefaultNetworkClient(configuration: Configuration()))
    
    public init() {}

}

private extension Services {
    struct Configuration: NetworkClientConfiguration {
        let successStatusCodeRange: ClosedRange<Int>? = nil
        let cachePolicy: NSURLRequest.CachePolicy? = .useProtocolCachePolicy
        let timeoutInterval: Double? = nil
        let isSSLPinningActive: Bool = false
    }
}

extension Services: RepositoriesProvider {
    public var newsRepository: NewsRepository {
        NewsApiRepository(networkClientManager: networkClientManager)
    }
}
