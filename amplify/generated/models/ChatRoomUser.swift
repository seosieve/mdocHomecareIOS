// swiftlint:disable all
import Amplify
import Foundation

public struct ChatRoomUser: Model {
  public let id: String
  public var user: User
  public var chatRoom: ChatRoom
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      user: User,
      chatRoom: ChatRoom) {
    self.init(id: id,
      user: user,
      chatRoom: chatRoom,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      user: User,
      chatRoom: ChatRoom,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.user = user
      self.chatRoom = chatRoom
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}