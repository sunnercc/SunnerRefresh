//
//  SunnerRefreshHeader.swift
//  SunnerRefresh
//
//  Created by ifuwo on 2018/9/11.
//  Copyright © 2018年 sunner. All rights reserved.
//

import UIKit

public class SunnerRefreshHeader: SunnerRefreshBase {
    
    override public func layoutSize() {
        super.layoutSize()
        self.sunner_w = (self.scrollview?.frame.size.width)!
        self.sunner_h = sunnerRefreshHeaderHeight
        self.sunner_x = 0
        self.sunner_y = -self.sunner_h
    }
    
    override public func refreshObserveValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        super.refreshObserveValue(forKeyPath: keyPath, of: object, change: change, context: context)
        if let object = object as? NSObject,
            let keyPath = keyPath {
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
            let y = -(self.scrollview?.sunner_insetT)!-sunnerRefreshHeaderHeight
            let offset = CGPoint(x: (self.scrollview?.contentOffset.x)!, y: y)
            self.scrollview?.setContentOffset(offset, animated: true)
        }
    }
    
    override public func endRefresh() {
        super.endRefresh()
        DispatchQueue.main.async {
            let y = -(self.scrollview?.sunner_insetT)!
            let offset = CGPoint(x: (self.scrollview?.contentOffset.x)!, y: y)
            self.scrollview?.setContentOffset(offset, animated: true)
        }
    }
}
