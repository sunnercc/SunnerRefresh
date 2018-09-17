//
//  SunnerIndicatorRefreshFooter.swift
//  SunnerRefresh
//
//  Created by ifuwo on 2018/9/17.
//  Copyright © 2018年 sunner. All rights reserved.
//

import UIKit

public class SunnerIndicatorRefreshFooter: SunnerRefreshFooter {

    fileprivate var indicator: UIActivityIndicatorView?
    
    public override func addSelfChilds() {
        super.addSelfChilds()
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        self.addSubview(indicator)
        indicator.isHidden = false
        self.indicator = indicator
    }
    
    public override func layoutSelfChildsFrames() {
        let w: CGFloat = sunnerRefreshFooterHeight
        let h: CGFloat = w
        let x: CGFloat = (self.sunner_w - w) * 0.5
        let y: CGFloat = (self.sunner_h - h) * 0.5
        self.indicator?.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    public override func beginRefresh() {
        super.beginRefresh()
        DispatchQueue.main.async {
            self.indicator?.startAnimating()
        }
    }
    
    public override func endRefresh() {
        super.endRefresh()
        DispatchQueue.main.async {
            self.indicator?.stopAnimating()
        }
    }

}
