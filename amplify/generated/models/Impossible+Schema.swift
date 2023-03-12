// swiftlint:disable all
import Amplify
import Foundation

extension Impossible {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case userID
    case ttime
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let impossible = Impossible.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "Impossibles"
    
    model.fields(
      .id(),
      .field(impossible.userID, is: .optional, ofType: .string),
      .field(impossible.ttime, is: .optional, ofType: .string),
      .field(impossible.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(impossible.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}