//
//  ValidationRule.swift
//  MKHValidation
//
//  Created by Maxim Khatskevich on 8/22/16.
//  Copyright © 2016 Maxim Khatskevich. All rights reserved.
//

//=== MARK: ValidationRule

public
protocol ValidationRule
{
    associatedtype Value
    
    static
    func description() -> String
    
    static
    func isValid(_: Value) -> Bool
}

//=== MARK: ValidationRule Defaults

public
extension ValidationRule
{
    static
    func description() -> String
    {
        return String(describing: self)
    }
    
    static
    func validate(_ value: Value) throws -> Value
    {
        if
            isValid(value)
        {
            return value
        }
        else
        {
            throw InvalidValue()
        }
    }
    
    static
    func validateAny<T>(_ value: T) throws -> Value
    {
        guard
            let typedValue = value as? Value
        else
        {
            throw InvalidValue()
        }
        
        //===
        
        return try validate(typedValue)
    }
}
