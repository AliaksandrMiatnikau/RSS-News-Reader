//
//  StringProtocol+Extension.swift
//  RSS Reader
//
//  Created by Aliaksandr Miatnikau on 2.02.23.
//

import Foundation

extension StringProtocol {
    
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}
