//
//  PasswordStrengthView.swift
//  Booklet
//
//  Created by Erison Veshi on 14.7.24.
//

import SwiftUI

struct PasswordStrengthView: View {
    let password: String
    
    var strength: PasswordStrength {
        if password.count < 6 {
            return .weak
        } else if password.count < 10 {
            return .medium
        } else {
            return .strong
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("auth.passwordStrength \(strength.rawValue)")
                .font(.caption)
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 4)
                    
                    Rectangle()
                        .fill(strength.color)
                        .frame(width: CGFloat(strength.percentage) / 100 * geometry.size.width, height: 4)
                }
            }
            .frame(height: 4)
        }
    }
}

enum PasswordStrength: String {
    case weak = "auth.passwordStrength.weak"
    case medium = "auth.passwordStrength.medium"
    case strong = "auth.passwordStrength.strong"
    
    var color: Color {
        switch self {
        case .weak: return .red
        case .medium: return .yellow
        case .strong: return .green
        }
    }
    
    var percentage: Double {
        switch self {
        case .weak: return 5
        case .medium: return 66.6
        case .strong: return 100
        }
    }
}
#Preview {
    PasswordStrengthView(password: "Kakashka69")
}
