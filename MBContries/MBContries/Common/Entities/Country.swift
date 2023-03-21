//
//  County.swift
//  MBContries
//
//  Created by Abhishek Binniwale on 10/03/23.
//

import Foundation

/*
 {
     "ID": 227,
     "Name": "UNITED STATES",
     "Code": "US",
     "PhoneCode": "1"
 }
 */

struct Country: Codable {
    var ID: Int
    var Name: String?
    var Code: String?
    var PhoneCode: String?
}
