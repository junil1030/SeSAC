//
//  main.swift
//  06_HashTable
//
//  Created by Bran on 10/29/25.
//

import Foundation


//var phoneNumber: [String: String] = [:]
//phoneNumber["01031258728"] = "Hue"
//phoneNumber["01068927321"] = "Jack"
//phoneNumber["01032094412"] = "Finn"
//phoneNumber["01089210809"] = "Bran"
//
//print(phoneNumber["01089210809"])
//print(phoneNumber["01051927022"])

var phoneBook = PhoneBook()
print(phoneBook.findNumber("01089210809"))
print(phoneBook.findNumber("01089210808"))

let test = readLine()

//var newPhoneBook = NewPhoneBook()
//print(newPhoneBook.findNumber("01089210809"))

//newPhoneBook.add("Ron", "01008929999")

