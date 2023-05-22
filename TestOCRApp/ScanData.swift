//
//  ScanData.swift
//  TestOCRApp
//
//  Created by Akhil Sachdev on 5/20/23.
//

import Foundation

struct ScanData: Identifiable {
    var id = UUID()
    let content: String
    
    init(content: String) {
        self.content = content
    }
    
}
