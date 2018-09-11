//
//  SunnerRefreshFooter.swift
//  SunnerRefresh
//
//  Created by ifuwo on 2018/9/11.
//  Copyright © 2018年 sunner. All rights reserved.
//

import UIKit

public class SunnerRefreshFooter: UIView, RefreshProtocol {

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
        if let superv = self.superview as? UIScrollView {
            self.sunner_y = superv.frame.minY + superv.contentSize.height
        }
    }
}
