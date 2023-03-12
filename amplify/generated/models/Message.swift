// swiftlint:disable all
import Amplify
import Foundation

public struct Message: Model {
  public let id: String
  public var image: String?
  public var status: MessageStatus?
  public var content: String?
  public var userID: String?
  public var chatroomID: String?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      image: String? = nil,
      status: MessageStatus? = nil,
      content: String? = nil,
      userID: String? = nil,
      chatroomID: String? = nil) {
    self.init(id: id,
      image: image,
      status: status,
      content: content,
      userID: userID,
      chatroomID: chatroomID,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      image: String? = nil,
      status: MessageStatus? = nil,
      content: String? = nil,
      userID: String? = nil,
      chatroomID: String? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.image = image
      self.status = status
      self.content = content
      self.userID = userID
      self.chatroomID = chatroomID
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}