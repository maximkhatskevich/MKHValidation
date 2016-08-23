//
//  ValidationRule+Async.swift
//  MKHValidation
//
//  Created by Maxim Khatskevich on 8/22/16.
//  Copyright © 2016 Maxim Khatskevich. All rights reserved.
//

public
final
class ValidationRuleAsync<Value>
{
    public
    let name: String
    
    public
    let value: Value
    
    //===
    
    public
    init(name: String, value: Value)
    {
        self.name = name
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
    
    func validate() throws
    {
        if
            isValid ?? false
        {
            // everything is good, don't do anything
        }
        else
        {
            throw
                InvalidValue(
                    ruleDescription: name)
        }
    }
    
//    public
//    func assert()
//    {
//        expect(self.isValid)
//            .to(equal(true), description: self.dynamicType.errorDescription())
//    }
}
