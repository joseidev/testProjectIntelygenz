
import Foundation

public protocol ArticleRepresentable {
    var title: String { get }
    var description: String { get }
    var url: String { get }
    var urlToImage: String { get }
    var date: Date? { get }
}
