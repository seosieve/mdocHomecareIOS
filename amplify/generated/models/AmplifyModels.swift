// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "6d798821c5cc6ed7c92351cc61236fd6"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: Impossible.self)
    ModelRegistry.register(modelType: MySchedule.self)
    ModelRegistry.register(modelType: Schedule.self)
    ModelRegistry.register(modelType: User.self)
    ModelRegistry.register(modelType: Message.self)
    ModelRegistry.register(modelType: Questionnarie.self)
    ModelRegistry.register(modelType: ChatRoom.self)
    ModelRegistry.register(modelType: ScheduleUser.self)
    ModelRegistry.register(modelType: ChatRoomUser.self)
  }
}