//
//  ValidationRule.swift
//  MKHValidation
//
//  Created by Maxim Khatskevich on 8/22/16.
//  Copyright © 2016 Maxim Khatskevich. All rights reserved.
//

//import Nimble

//===

public
struct ValidationError: ErrorType
{
    public
    let message: String
}

//=== MARK: ValidationRuleBase

public
protocol ValidationRuleBase
{
    static
    func errorDescription() -> String
}

public
extension ValidationRuleBase
{
    public
    static
    func errorDescription() -> String
    {
        return String(self) + " is invalid."
    }
}

//=== MARK: ValidationRule

public
protocol ValidationRule: ValidationRuleBase
{
    associatedtype Value
    
    static
    func isValid(_: Value) -> Bool
    
    static
    func validate(_: Value) throws
    
//    static
//    func assert(_: Value)
}

//=== MARK: ValidationRule Defaults

public
extension ValidationRule
{
    static
    func validate(v: Value) throws
    {
        if
            isValid(v)
        {
            // everything is good, don't do anything
        }
        else
        {
            throw ValidationError(message: errorDescription())
        }
    }
    
//    static
//    func assert(v: Value)
//    {
//        expect(isValid(v))
//            .to(equal(true), description: errorDescription())
//    }
}
