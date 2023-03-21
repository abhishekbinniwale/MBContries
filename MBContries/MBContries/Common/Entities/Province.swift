//
//  Province.swift
//  MBContries
//
//  Created by Abhishek Binniwale on 10/03/23.
//

import Foundation

/*
 {
     "ID": 97,
     "CountryCode": "US",
     "Code": "AL",
     "Name": "Alabama"
 }
 */

struct Province: Codable {
    var ID: Int
    var CountryCode: String?
    var Code: String?
    var Name: String?
}
