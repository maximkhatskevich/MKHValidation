//
//  ValidationRule+Async.swift
//  MKHValidation
//
//  Created by Maxim Khatskevich on 8/22/16.
//  Copyright © 2016 Maxim Khatskevich. All rights reserved.
//

//import Nimble

//===

public
final
class ValidationRuleAsync<Value>: ValidationRuleBase
{
    public
    let value: Value
    
    //===
    
    public
    init(value: Value)
    {
        self.value = value
    }
    
    //===
    
    public private(set) // fileprivate
    var isValid: Bool?
}

//===

public
extension ValidationRuleAsync
{
    public
    func accept()
    {
        isValid = true
    }
    
    public
    func reject()
    {
        isValid = false
    }
    
    public
    func validate() throws
    {
        if
            isValid ?? false
        {
            // "isValid" is already set (not nil) and "true",
            // everything is good, don't do anything
        }
        else
        {
            throw ValidationError(message: self.dynamicType.errorDescription())
        }
    }
    
//    public
//    func assert()
//    {
//        expect(self.isValid)
//            .to(equal(true), description: self.dynamicType.errorDescription())
//    }
}
