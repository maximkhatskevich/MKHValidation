//
//  Errors.swift
//  MKHValidation
//
//  Created by Maxim Khatskevich on 8/27/16.
//  Copyright © 2016 Maxim Khatskevich. All rights reserved.
//

public
protocol ValidationRuleError: Error { }

//===

public
struct InvalidValue: ValidationRuleError { }
