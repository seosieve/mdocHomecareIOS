// swiftlint:disable all
import Amplify
import Foundation

public struct ChatRoom: Model {
  public let id: String
  public var newMessages: Int?
  public var name: String?
  public var Messages: List<Message>?
  public var Users: List<ChatRoomUser>?
  public var LastMessage: Message?
  public var Questionnaries: List<Questionnarie>?
  public var Schedule: Schedule?
  public var state: String?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  public var chatRoomLastMessageId: String?
  public var chatRoomScheduleId: String?
  
  public init(id: String = UUID().uuidString,
      newMessages: Int? = nil,
      name: String? = nil,
      Messages: List<Message>? = [],
      Users: List<ChatRoomUser>? = [],
      LastMessage: Message? = nil,
      Questionnaries: List<Questionnarie>? = [],
      Schedule: Schedule? = nil,
      state: String? = nil,
      chatRoomLastMessageId: String? = nil,
      chatRoomScheduleId: String? = nil) {
    self.init(id: id,
      newMessages: newMessages,
      name: name,
      Messages: Messages,
      Users: Users,
      LastMessage: LastMessage,
      Questionnaries: Questionnaries,
      Schedule: Schedule,
      state: state,
      createdAt: nil,
      updatedAt: nil,
      chatRoomLastMessageId: chatRoomLastMessageId,
      chatRoomScheduleId: chatRoomScheduleId)
  }
  internal init(id: String = UUID().uuidString,
      newMessages: Int? = nil,
      name: String? = nil,
      Messages: List<Message>? = [],
      Users: List<ChatRoomUser>? = [],
      LastMessage: Message? = nil,
      Questionnaries: List<Questionnarie>? = [],
      Schedule: Schedule? = nil,
      state: String? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil,
      chatRoomLastMessageId: String? = nil,
      chatRoomScheduleId: String? = nil) {
      self.id = id
      self.newMessages = newMessages
      self.name = name
      self.Messages = Messages
      self.Users = Users
      self.LastMessage = LastMessage
      self.Questionnaries = Questionnaries
      self.Schedule = Schedule
      self.state = state
      self.createdAt = createdAt
      self.updatedAt = updatedAt
      self.chatRoomLastMessageId = chatRoomLastMessageId
      self.chatRoomScheduleId = chatRoomScheduleId
  }
}