//
//  Main.swift
//  MKHValidationTst
//
//  Created by Maxim Khatskevich on 8/22/16.
//  Copyright © 2016 Maxim Khatskevich. All rights reserved.
//

import XCTest

// @testable
import MKHValidation

//===

class MKHValidationTst: XCTestCase
{
    struct UserDraft
    {
        let firstName: String?
        let lastName: String?
        let login: String?
        let password: String?
    }
    
    //===
    
    enum Spec
    {
        enum User
        {
            enum FirstName: ValidationRule
            {
                static
                func isValid(value: String?) -> Bool
                {
                    // any non-empty value is OK
                    
                    return value?.characters.count > 0
                }
            }
//
//            enum LastName: ValidationRule
//            {
//                static
//                    func isValid(_: String?) -> Bool
//                {
//                    // ANY value is OK
//                    
//                    return YES
//                }
//            }
//            
//            enum Login
//            {
//                static
//                    func isValid(login: String) -> Bool
//                {
//                    return login.isValidEmail()
//                }
//            }
//            
//            enum Password
//            {
//                static
//                let minimalLength = 6
//                
//                //===
//                
//                static
//                    func isValid(password: String) -> Bool
//                {
//                    return (password.characters.count >= minimalLength)
//                }
//            }
        }
    }
    
    //===
    
    func testExample()
    {
        XCTAssertTrue(Spec.User.FirstName.isValid(nil), Spec.User.FirstName.errorDescription())
    }
    
//    func describeError(errorDesc: String, funcName: String = #function) -> String
//    {
//        return "\(funcName) :: \(errorDesc)"
//    }
}
