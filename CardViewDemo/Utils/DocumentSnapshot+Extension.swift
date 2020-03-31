//
//  DocumentSnapshot+Extension.swift
//  Admin-mystuff
//
//  Created by Ravi Dhorajiya on 13/11/18.
//  Copyright © 2018 Ravi Dhorajiya. All rights reserved.
//

import Foundation
import FirebaseFirestore

extension DocumentSnapshot {
  func dataWithIDIncluded() -> [String: Any]? {
    if var theData = self.data() {
      theData["id"] = self.documentID
      return theData
    }
    return nil
  }
}
