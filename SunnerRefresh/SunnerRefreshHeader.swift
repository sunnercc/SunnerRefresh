//
//  SunnerRefreshHeader.swift
//  SunnerRefresh
//
//  Created by ifuwo on 2018/9/11.
//  Copyright © 2018年 sunner. All rights reserved.
//

import UIKit

open class SunnerRefreshHeader: UIView, RefreshProtocol {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        //
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        
        self.sunner_w = sunnerRefreshFooterWidth
        self.sunner_h = sunnerRefreshFooterHeight
        self.sunner_x = 0
        self.sunner_y = -self.sunner_h
    }
}
