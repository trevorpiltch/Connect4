//
//  Confetti.swift
//  ConnectFour
//
//  Created by Trevor Piltch on 4/4/23.
//

import SwiftUI

/*
MARK: Attribution:
I got the outline of this code from this medium article (https://betterprogramming.pub/creating-confetti-particle-effects-using-swiftui-afda4240de6b)
I modified it so it made more sense for this game (i.e slower and more particles).
*/

/// Geometry effect that moves and rotates the content by a random value
struct ConfettiGeometryEffect: GeometryEffect {
	var time: Double
	var speed = Double.random(in: 10 ... 150)
	var direction = Double.random(in: -Double.pi ... Double.pi)
	var animatableData: Double {
		get { time }
		set { time = newValue }
	}
	
	func effectValue(size: CGSize) -> ProjectionTransform {
		let dx = speed * cos(direction) * time
		let dy = speed * sin(direction) * time
		
		let translation = CGAffineTransform(translationX: dx, y: dy)
		return ProjectionTransform(translation)
	}
}

struct ConfettiEffect: ViewModifier {
	@State private var time = 0.0
	@State private var scale = 0.1
	let duration = 10.0
	
	func body(content: Content) -> some View {
		ZStack {
			ForEach(0..<300) { _ in
				content
					.hueRotation(Angle(degrees: time * 80))
					.modifier(ConfettiGeometryEffect(time: time))
					.opacity((duration - time) / duration)
					.scaleEffect(scale)
			}
		}
		.onAppear {
			withAnimation(.easeOut(duration: duration)) {
				self.time = duration
				self.scale = 1.0
			}
		}
	}
}
