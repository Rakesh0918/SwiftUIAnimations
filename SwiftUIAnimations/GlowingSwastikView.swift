//
//  GlowingSwastikView.swift
//  SwiftUIAnimations
//
//  Created by Rakesh on 22/10/25.
//

import SwiftUI

struct SwastikSymbol: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let s = min(rect.width, rect.height)
        let c = CGPoint(x: rect.midX, y: rect.midY)
        let arm = s * 0.25
        let bar = s * 0.10
        let r   = s * 0.05

        // central square
        p.addRect(CGRect(x: c.x - bar/2, y: c.y - bar/2, width: bar, height: bar))

        // top arm ↑
        p.addRoundedRect(in: CGRect(x: c.x - bar/2,
                                    y: c.y - arm - bar,
                                    width: bar,
                                    height: arm + bar),
                         cornerSize: CGSize(width: 5, height: 5))
        // dot
        p.addRoundedRect(in: CGRect(x: c.x + bar,
                                    y: c.y - arm + bar/2,
                                    width: 18,
                                    height: 18),
                         cornerSize: CGSize(width: 9, height: 9))
        
        // top arm →
        p.addRoundedRect(in: CGRect(x: c.x + bar/2-13,
                                    y: c.y - arm - bar,
                                    width: arm + bar,
                                    height: bar),
                         cornerSize: CGSize(width: r, height: r))
        
        
        // right arm →
        p.addRoundedRect(in: CGRect(x: c.x,
                                    y: c.y - bar/2,
                                    width: arm + bar,
                                    height: bar),
                         cornerSize: CGSize(width: 5, height: 5))
        // dot
        p.addRoundedRect(in: CGRect(x: c.x - arm + bar/2,
                                    y: c.y - arm + bar/2,
                                    width: 18,
                                    height: 18),
                         cornerSize: CGSize(width: 9, height: 9))
        
        // right arm ↓
        p.addRoundedRect(in: CGRect(x: c.y + arm + bar/2-13,
                                    y: c.y,
                                    width: bar,
                                    height: arm + bar),
                         cornerSize: CGSize(width: r, height: r))
        
        // bottom arm ↓
        p.addRoundedRect(in: CGRect(x: c.x - bar/2,
                                    y: c.y,
                                    width: bar,
                                    height: arm + bar),
                         cornerSize: CGSize(width: 5, height: 5))
        // dot
        p.addRoundedRect(in: CGRect(x: c.y - arm + bar/2,
                                    y: c.y + arm - bar,
                                    width: 18,
                                    height: 18),
                         cornerSize: CGSize(width: 9, height: 9))
        // bottom arm ←
        p.addRoundedRect(in: CGRect(x: c.x - arm - bar,
                                    y: c.y + arm + bar/2-13,
                                    width: arm + bar,
                                    height: bar),
                         cornerSize: CGSize(width: r, height: r))
        
        // left arm ←
        p.addRoundedRect(in: CGRect(x: c.x - arm - bar,
                                    y: c.y - bar/2,
                                    width: arm + bar,
                                    height: bar),
                         cornerSize: CGSize(width: 5, height: 5))
        
        p.addRoundedRect(in: CGRect(x: c.y + arm - bar,
                                    y: c.y + arm - bar,
                                    width: 18,
                                    height: 18),
                         cornerSize: CGSize(width: 9, height: 9))
        // left arm ↑
        p.addRoundedRect(in: CGRect(x: c.y - arm - bar,
                                    y: c.y - arm - bar,
                                    width: bar,
                                    height: arm + bar),
                         cornerSize: CGSize(width: r, height: r))

        return p
    }
}

struct GlowingSwastikView: View {
    @State private var rotate = false
    @State private var pulse = false

    var body: some View {
        ZStack {
            // Background aura
            RadialGradient(
                gradient: Gradient(colors: [.black, .orange.opacity(0.2)]),
                center: .center,
                startRadius: 0,
                endRadius: 400
            )
            .ignoresSafeArea()

            // Outer pulse
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [.orange.opacity(0.3), .clear]),
                        center: .center,
                        startRadius: pulse ? 80 : 40,
                        endRadius: pulse ? 300 : 180
                    )
                )
                .blur(radius: 80)

            // Swastik symbol
            SwastikSymbol()
                .fill(
                    LinearGradient(
                        colors: [.yellow, .orange, .red],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    SwastikSymbol()
                        .stroke(Color.orange.opacity(0.9), lineWidth: 3)
                        .blur(radius: 5)
                )
                .shadow(color: .orange.opacity(0.9), radius: pulse ? 40 : 15)
                .rotationEffect(.degrees(rotate ? 360 : 0))
                .scaleEffect(pulse ? 1.05 : 1.0)
                .frame(width: 260, height: 260)
                .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: pulse)
            Circle()
                .fill(
                    RadialGradient(gradient: Gradient(colors: [.yellow.opacity(0.5), .clear]),
                                   center: .center,
                                   startRadius: 10,
                                   endRadius: 200)
                )
                .blur(radius: 60)
                .scaleEffect(pulse ? 1.1 : 0.9)
        }
        .onAppear {
            // Continuous rotation
            withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)) {
                rotate = true
            }
        }
    }
}


#Preview {
    GlowingSwastikView()
}
