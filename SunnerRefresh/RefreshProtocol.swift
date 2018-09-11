//
//  RefreshProtocol.swift
//  SunnerRefresh
//
//  Created by ifuwo on 2018/9/11.
//  Copyright © 2018年 sunner. All rights reserved.
//

import UIKit

public protocol RefreshProtocol {
    
    func refreshing(target: NSObject, action: Selector) -> Void
    
}

extension RefreshProtocol {
    
    public func refreshing(target: NSObject, action: Selector) -> Void {
        target.perform(action)
    }
}
