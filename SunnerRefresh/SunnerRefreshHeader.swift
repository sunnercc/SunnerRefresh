//
//  SunnerRefreshHeader.swift
//  SunnerRefresh
//
//  Created by ifuwo on 2018/9/11.
//  Copyright © 2018年 sunner. All rights reserved.
//

import UIKit

public class SunnerRefreshHeader: UIView {
    
    var target: NSObject? = nil
    var action: Selector? = nil
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        //
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        
        self.sunner_w = sunnerRefreshFooterWidth
        self.sunner_h = sunnerRefreshFooterHeight
        self.sunner_x = 0
        self.sunner_y = -self.sunner_h
    }
}


extension SunnerRefreshHeader : RefreshProtocol {
    
    public func refreshing(target: NSObject, action: Selector) {
        self.target = target
        self.action = action
    }
}
