//
//  SunnerRefreshHeader.swift
//  SunnerRefresh
//
//  Created by ifuwo on 2018/9/11.
//  Copyright © 2018年 sunner. All rights reserved.
//

import UIKit

public class SunnerRefreshHeader: SunnerRefreshBase {

    public override func layoutFrame(scrollview: UIScrollView) -> CGRect {
        let w: CGFloat = (self.scrollview?.sunner_w)!
        let h: CGFloat = sunnerRefreshHeaderHeight
        let x: CGFloat = 0
        let y: CGFloat = (self.scrollview?.sunner_insetT)!
        let rect = CGRect(x: x, y: y, width: w, height: h)
        return rect
    }
    
    override public func refreshObserveValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        super.refreshObserveValue(forKeyPath: keyPath, of: object, change: change, context: context)
        if let object = object as? NSObject,
            let keyPath = keyPath {
            if self.state == .refreshing {
                return
            }
            if object.isEqual(self.scrollview) && keyPath == sunnerRefreshScrollviewContentOffsetKeyPath
            {
                let offsetY = (self.scrollview?.contentOffset.y)!
                let insetT = (self.scrollview?.sunner_insetT)!
                let dis = offsetY + insetT
                if dis >= 0
                {
                    self.state = .idle
                }
                else if dis < 0 && dis >= -sunnerRefreshHeaderHeight
                {
                    self.state = .drag
                }
                else if dis < -sunnerRefreshHeaderHeight
                {
                    self.state = .will
                }
            }
            if object.isEqual(self.scrollview) && keyPath == sunnerRefreshScrollviewContentSizeKeyPath
            {
                
            }
            if object.isEqual(self.scrollview?.panGestureRecognizer) && keyPath == sunnerRefreshScrollviewPanGesStateKeyPath
            {
                if self.scrollview?.panGestureRecognizer.state == UIGestureRecognizerState.ended
                {
                    if self.state == .will {
                        self.beginRefresh()
                    }
                }
            }
        }
    }
    
    override public func beginRefresh() {
        super.beginRefresh()
        DispatchQueue.main.async {
            self.state = .refreshing
            let y = -(self.scrollview?.sunner_insetT)!-sunnerRefreshHeaderHeight
            let offset = CGPoint(x: (self.scrollview?.contentOffset.x)!, y: y)
            self.scrollview?.setContentOffset(offset, animated: true)
            
        }
    }
    
    override public func endRefresh() {
        super.endRefresh()
        DispatchQueue.main.async {
            self.state = .idle
            let y = -(self.scrollview?.sunner_insetT)!
            let offset = CGPoint(x: (self.scrollview?.contentOffset.x)!, y: y)
            self.scrollview?.setContentOffset(offset, animated: true)
        }
    }
}
