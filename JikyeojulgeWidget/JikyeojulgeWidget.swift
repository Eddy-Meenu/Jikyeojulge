//
//  JikyeojulgeWidget.swift
//  JikyeojulgeWidget
//
//  Created by 김민택 on 2022/07/04.
//

import WidgetKit
import SwiftUI
import Intents

@main
struct JikyeojulgeWidget: WidgetBundle {
    
    @WidgetBundleBuilder
    var body: some Widget {
        SmallWidget()
        MediumWidget()
    }
}
