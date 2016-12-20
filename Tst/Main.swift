//
//  Main.swift
//  MKHValidationTst
//
//  Created by Maxim Khatskevich on 8/22/16.
//  Copyright © 2016 Maxim Khatskevich. All rights reserved.
//

import XCTest

@testable
import MKHValidation

import MKHHelpers

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
        enum User: ValidationRule // context for the nested rules
        {
            static
            func isValid(_ userDraft: UserDraft?) -> Bool
            {
                return FirstNameNonEmpty.isValid(userDraft?.firstName)
                    && LastNameAny.isValid(userDraft?.lastName)
                    && LoginIsValidEmail.isValid(userDraft?.login)
                    && PasswordComplexEnough.isValid(userDraft?.password)
            }
            
            //===
            
            enum FirstNameNonEmpty: ValidationRule
            {
                static
                func isValid(_ firstName: String?) -> Bool
                {
                    // any non-empty value is OK
                    
                    if
                        let firstName = firstName
                    {
                        return firstName.characters.count > 0
                    }
                    else
                    {
                        return false
                    }
                }
            }

            enum LastNameAny: ValidationRule
            {
                static
                func isValid(_ lastName: String?) -> Bool
                {
                    // ANY value is OK
                    
                    return true
                }
            }
            
            enum LoginIsValidEmail
            {
                static
                func isValid(_ login: String?) -> Bool
                {
                    return login.map{ $0.isValidEmail() } ?? false
                }
            }
            
            enum PasswordComplexEnough
            {
                static
                let minimalLength = 6
                
                //===
                
                static
                func isValid(_ password: String?) -> Bool
                {
                    return password.map{ $0.characters.count >= minimalLength } ?? false
                }
            }
        }
    }
    
    //===
    
    func testFirstNameValidation()
    {
        let r = Spec.User.FirstNameNonEmpty.self
        
        XCTAssertFalse(r.isValid(nil), r.description())
        XCTAssertFalse(r.isValid(""), r.description())
        XCTAssertTrue(r.isValid("Max"), r.description())
    }
}
