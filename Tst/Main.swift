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
                        return NO
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
                    return login.map{ $0.isValidEmail() } ?? NO
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
                    return password.map{ $0.characters.count >= minimalLength } ?? NO
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
    
    //===
    
    
    struct MyUser
    {
        let someConstantValue = ValueWrapper(constant: 3)
        
        let firstName = ValueWrapper<String>{ $0.characters.count > 0 }
    }
    
    //===
    
    func testSomeConstantValueWrapper()
    {
        let u = MyUser()
        
        XCTAssertTrue(u.someConstantValue.isValid())
        XCTAssertEqual(u.someConstantValue.value!, 3)
    }
    
    func testFirstNameValueWrapper()
    {
        let u = MyUser()
        
        //===
        
        XCTAssertTrue(u.firstName.value == nil)
        XCTAssertFalse(u.firstName.isValid())
        
        //===
        
        do
        {
            try u.firstName.setValue(5)
            XCTFail("Should not get here ever")
        }
        catch
        {
            XCTAssertTrue(type(of: error) == InvalidValue.self)
        }
        
        //===
        
        XCTAssertTrue(u.firstName.value == nil)
        XCTAssertFalse(u.firstName.isValid())
        
        //===
        
        do
        {
            let tmp: String? = nil
            try u.firstName.setValue(tmp)
            XCTFail("Should not get here ever")
        }
        catch
        {
            XCTAssertTrue(type(of: error) == InvalidValue.self)
        }
        
        //===
        
        XCTAssertTrue(u.firstName.value == nil)
        XCTAssertFalse(u.firstName.isValid())
        
        //===
        
        do
        {
            try u.firstName.setValue("")
            XCTFail("Should not get here ever")
        }
        catch
        {
            XCTAssertTrue(type(of: error) == InvalidValue.self)
        }
        
        //===
        
        XCTAssertTrue(u.firstName.value == nil)
        XCTAssertFalse(u.firstName.isValid())
        
        //===
        
        do
        {
            try u.firstName.setValue("Max")
        }
        catch
        {
            XCTFail("Should not get here ever")
        }
        
        //===
        
        XCTAssertEqual(u.firstName.value!, "Max")
        XCTAssertTrue(u.firstName.isValid())
        
        //===
        
        do
        {
            try u.firstName.setValue("Alex")
            XCTFail("Should not get here ever")
        }
        catch
        {
            XCTAssertTrue(type(of: error) == MutabilityViolation.self)
        }
        
        //===
        
        XCTAssertEqual(u.firstName.value!, "Max")
        XCTAssertTrue(u.firstName.isValid())
    }
}
