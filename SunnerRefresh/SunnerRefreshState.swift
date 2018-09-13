//
//  SunnerRefreshState.swift
//  SunnerRefresh
//
//  Created by ifuwo on 2018/9/13.
//  Copyright © 2018年 sunner. All rights reserved.
//

import UIKit

enum SunnerRefreshState {
    /// 空闲状态
    case idle
    /// 拖动scrollview时候的状态
    case drag
    /// 拖动scrollview, 放手就会刷新的状态
    case will
    /// 正在刷新的状态
    case refreshing
}
