//
//  ValueWrapper.swift
//  MKHValidation
//
//  Created by Maxim Khatskevich on 8/27/16.
//  Copyright © 2016 Maxim Khatskevich. All rights reserved.
//

public
final
class ValueWrapper<Value>
{
    private(set)
    var value: Value? = nil // you can force to have non-nil value in the validator
    
    public
    let mutable: Bool
    
    private
    let validator: (Value?) -> Bool
    
    //===
    
    public
    init(
        _ value: Value? = nil,
        mutable: Bool = false, // immutable by default - allows to set value only once
        validator: (Value?) -> Bool
        )
    {
        self.value = value
        self.mutable = mutable
        self.validator = validator
    }
    
    public
    init(_ value: Value?)
    {
        self.value = value
        
        //===
        
        self.mutable = false // immutable by default - allows to set value only once
        self.validator = { _ in return true } // accept any value by default
    }
}

//===

public
extension ValueWrapper
{
    func setValue<T>(externalValue: T?) throws
    {
        guard
            (value == nil) ||
            ((value != nil) && mutable)
        else
        {
            throw
                ViolateImmutabilityErr()
        }
        
        //===
        
        let newValue = externalValue as? Value
        
        //===
        
        guard
            validator(newValue)
        else
        {
            throw
                InvalidValue()
        }
        
        //===
        
        value = newValue
    }
}

//===

public
extension ValueWrapper
{
    func isValid() -> Bool
    {
        return validator(value)
    }
    
    func isValid<T>(externalValue: T) -> Bool
    {
        return validator(externalValue as? Value)
    }
}
