//
//  FBSnapShotSwiftHelpers.swift
//  Verona
//
//  Created by Salvatore Randazzo on 6/3/15.
//  Copyright (c) 2015 Salvatore Randazzo. All rights reserved.
//

import Foundation
import FBSnapshotTestCase

extension FBSnapshotTestCase {
    
    func FBSnapShotVerifyLayer(layer: CALayer, identifier: String?) {
        
        var error: NSError?
        let referenceImagesDirectory = FB_REFERENCE_IMAGE_DIR
        let comparisonSuccess: Bool
        do {
            try self.compareSnapshotOfLayer(layer, referenceImagesDirectory: referenceImagesDirectory, identifier: identifier)
            comparisonSuccess = true
        } catch let error1 as NSError {
            error = error1
            comparisonSuccess = false
        }
        XCTAssertTrue(comparisonSuccess, "Snapshot comparison failed: \(error)")
        XCTAssertFalse(self.recordMode, "Test ran in record mode. Reference image is now saved. Disable record mode to perform an actual snapshot comparison!")
    }
    
    func FBSnapShotVerifyLayer(layer: CALayer) {
        FBSnapShotVerifyLayer(layer, identifier: nil)
    }
}