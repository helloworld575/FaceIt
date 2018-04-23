//
//  FaceItExpression.swift
//  FaceIt
//
//  Created by HealthJudge on 2018/4/16.
//  Copyright © 2018年 HealthHIT. All rights reserved.
//

import Foundation
struct FacialExpression{
    enum Eyes: Int{
        case open
        case closed
        case squinting//眯眼
    }
    enum Mouth: Int{
        case frown
        case smirk
        case neutral
        case grin
        case smile
        
        var sadder: Mouth{
            return Mouth(rawValue: rawValue-1) ?? .frown
        }
        var happier: Mouth{
            return Mouth(rawValue: rawValue + 1) ?? .smile
        }
    }
    
    var sadder: FacialExpression{
        return FacialExpression(eyes: self.eyes,mouth: self.mouth.sadder)
    }
    var happier:FacialExpression{
        return FacialExpression(eyes: self.eyes,mouth:self.mouth.happier)
    }
    
    let eyes:Eyes
    let mouth:Mouth
}
