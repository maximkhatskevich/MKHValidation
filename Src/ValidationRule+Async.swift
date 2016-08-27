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
    
    public
    func validate() throws -> Value
    {
        if
            isValid ?? false
        {
            return value
        }
        else
        {
            throw
                InvalidValue()
        }
    }
}
