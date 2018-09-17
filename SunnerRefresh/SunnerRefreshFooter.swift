//
//  SunnerRefreshFooter.swift
//  SunnerRefresh
//
//  Created by ifuwo on 2018/9/11.
//  Copyright © 2018年 sunner. All rights reserved.
//

import UIKit

public class SunnerRefreshFooter: SunnerRefreshBase {

    public override func layoutFrame(scrollview: UIScrollView) -> CGRect {
        let w: CGFloat = (self.scrollview?.sunner_w)!
        let h: CGFloat = sunnerRefreshFooterHeight
        let x: CGFloat = 0
        let y: CGFloat = (self.scrollview?.frame.maxY)! - (self.scrollview?.sunner_insetB)! - h
        let rect = CGRect(x: x, y: y, width: w, height: h)
        return rect
    }
    
    public override func refreshObserveValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let object = object as? NSObject,
            let keyPath = keyPath {
            if object.isEqual(self.scrollview) && keyPath == sunnerRefreshScrollviewContentOffsetKeyPath
            {
                let dis = (self.scrollview?.contentSize.height)! - (self.scrollview?.contentOffset.y)! - (self.scrollview?.frame.size.height)! + (self.scrollview?.sunner_insetB)!
                if dis >= 0
                {
                    self.state = .idle
                }
                else if dis < 0 && dis >= -sunnerRefreshFooterHeight
                {
                    self.state = .drag
                }
                else if dis < -sunnerRefreshFooterHeight
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
                    if self.state == .refreshing {
                        return
                    }
                    else if self.state == .will {
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
            let y = (self.scrollview?.contentSize.height)! + sunnerRefreshFooterHeight - (self.scrollview?.frame.size.height)! + (self.scrollview?.sunner_insetB)!
            let offset = CGPoint(x: (self.scrollview?.contentOffset.x)!, y: y)
            self.scrollview?.setContentOffset(offset, animated: true)
        }
    }
    
    override public func endRefresh() {
        super.endRefresh()
        DispatchQueue.main.async {
            let y = (self.scrollview?.contentSize.height)! - (self.scrollview?.frame.size.height)! + (self.scrollview?.sunner_insetB)!
            let offset = CGPoint(x: (self.scrollview?.contentOffset.x)!, y: y)
            self.scrollview?.setContentOffset(offset, animated: true)
        }
    }
}
