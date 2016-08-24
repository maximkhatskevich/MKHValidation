//
//  ValidationRule.swift
//  MKHValidation
//
//  Created by Maxim Khatskevich on 8/22/16.
//  Copyright © 2016 Maxim Khatskevich. All rights reserved.
//

public
protocol ValidationError: ErrorType { }

public
struct TypeMismatch: ValidationError
{
    let actualType: Any.Type
    let expectedType: Any.Type
    let ruleDescription: String
}

public
struct InvalidValue: ValidationError
{
    let ruleDescription: String
}

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
        return String(self)
    }
    
    static
    func validate(value: Value) throws -> Value
    {
        if
            isValid(value)
        {
            return value
        }
        else
        {
            throw
                InvalidValue(
                    ruleDescription: description())
        }
    }
    
    static
    func validateAny<T>(value: T) throws -> Value
    {
        guard
            let typedValue = value as? Value
        else
        {
            throw
                TypeMismatch(
                    actualType: T.self,
                    expectedType: Value.self,
                    ruleDescription: description())
        }
        
        //===
        
        return try validate(typedValue)
    }
}
