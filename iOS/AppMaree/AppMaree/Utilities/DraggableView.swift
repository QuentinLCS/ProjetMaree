//
//  DraggableView.swift
//  AppMaree
//
//  Created by unicaen on 03/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//
import SwiftUI

struct DraggableModifier : ViewModifier {

    enum Direction {
        case vertical
        case horizontal
    }

    let direction: Direction

    @State private var draggedOffset: CGSize = .zero
    @Binding var showAd: Bool

    func body(content: Content) -> some View {
        content
        .offset(
            CGSize(width: direction == .vertical ? 0 : draggedOffset.width,
                   height: direction == .horizontal ? 0 : draggedOffset.height)
        )
        .gesture(
            DragGesture()
            .onChanged { value in
                self.draggedOffset = value.translation
            }
            .onEnded { value in
                self.showAd = false
            }
        )
    }

}
