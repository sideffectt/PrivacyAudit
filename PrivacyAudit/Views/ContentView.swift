import SwiftUI

struct ContentView: View {
    
    @StateObject private var settingsViewModel = SettingsViewModel()
    
    var body: some View {
        TabView {
            DashboardTab()
                .tabItem {
                    Image(systemName: "shield.fill")
                    Text("Privacy")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
        .preferredColorScheme(settingsViewModel.colorScheme)
    }
}

struct DashboardTab: View {
    
    @StateObject private var viewModel = DashboardViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Custom Header
                HStack {
                    HStack(spacing: 0) {
                        Text("Privacy")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                        Text("Audit")
                            .font(.system(size: 28, weight: .light, design: .rounded))
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "checkmark.shield.fill")
                        .font(.title)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                }
                .padding(.horizontal)
                .padding(.top, 8)
                .padding(.bottom, 16)
                .background(Color(.systemBackground))
                
                ScrollView {
                    VStack(spacing: 16) {
                        ScoreCard(score: viewModel.privacyScore)
                        
                        LazyVStack(spacing: 12) {
                            ForEach(viewModel.permissions) { permission in
                                NavigationLink {
                                    PermissionDetailView(permission: permission)
                                } label: {
                                    PermissionRow(permission: permission)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 20)
                }
                .refreshable {
                    viewModel.loadPermissions()
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
        }
    }
    
}
struct ScoreCard: View {
    let score: Int
    
    var body: some View {
        VStack(spacing: 12) {
            Text("PRIVACY SCORE")
                .font(.caption)
                .fontWeight(.bold)
                .tracking(2)
                .foregroundColor(.secondary)
            
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 12)
                    .frame(width: 120, height: 120)
                
                Circle()
                    .trim(from: 0, to: CGFloat(score) / 100)
                    .stroke(
                        LinearGradient(
                            colors: gradientForScore,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        style: StrokeStyle(lineWidth: 12, lineCap: .round)
                    )
                    .frame(width: 120, height: 120)
                    .rotationEffect(.degrees(-90))
                
                Text("\(score)")
                    .font(.system(size: 44, weight: .bold, design: .rounded))
                    .foregroundColor(colorForScore)
            }
            
            Text(messageForScore)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 10, y: 5)
        )
        .padding(.horizontal)
    }
    
    var colorForScore: Color {
        if score >= 70 { return .green }
        if score >= 40 { return .orange }
        return .red
    }
    
    var gradientForScore: [Color] {
        if score >= 70 { return [.green, .mint] }
        if score >= 40 { return [.orange, .yellow] }
        return [.red, .pink]
    }
    
    var messageForScore: String {
        if score >= 70 { return "Great privacy!" }
        if score >= 40 { return "Room for improvement" }
        return "Review your permissions"
    }
}

struct PermissionRow: View {
    let permission: Permission
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: permission.type.icon)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(
                    LinearGradient(
                        colors: gradientForStatus(permission.status),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(12)
                .shadow(color: colorForStatus(permission.status).opacity(0.4), radius: 4, y: 2)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(permission.type.rawValue)
                    .font(.headline)
                    .fontWeight(.bold)
                Text(permission.type.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            
            Spacer()
            
            Text(permission.status.rawValue)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(colorForStatus(permission.status))
                .cornerRadius(8)
        }
        .padding(.vertical, 8)
    }
    
    func colorForStatus(_ status: PermissionStatus) -> Color {
        switch status {
        case .authorized: return .green
        case .denied: return .red
        case .notDetermined: return .orange
        case .restricted: return .gray
        }
    }
    
    func gradientForStatus(_ status: PermissionStatus) -> [Color] {
        switch status {
        case .authorized: return [.green, .green.opacity(0.7)]
        case .denied: return [.red, .red.opacity(0.7)]
        case .notDetermined: return [.orange, .orange.opacity(0.7)]
        case .restricted: return [.gray, .gray.opacity(0.7)]
        }
    }
}
