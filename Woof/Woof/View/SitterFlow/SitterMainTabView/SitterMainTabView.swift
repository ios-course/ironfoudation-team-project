import SwiftUI

/// A view representing the main tab view for the sitter.
struct SitterMainTabView: View {
    // MARK: - Internal interface

    init() {
        customizeTabBar()
    }

    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                Group {
                    Text("My schedule")
                        .tabItem {
                            Label("Schedule", systemImage: .IconName.scheduleTab)
                        }
                        .tag(Tab.schedule)

                    Text("Walkings")
                        .tabItem {
                            Label("Walkings", systemImage: .IconName.walkingsTab)
                        }
                        .tag(Tab.walkings)

                    SitterProfileView()
                        .tabItem {
                            Label("Profile", systemImage: .IconName.profileTab)
                        }
                        .tag(Tab.profile)
                }
            }
            .tint(Color.App.purpleDark)
            .navigationTitle(selection.header)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                NavigationLink(
                    destination: LoginView()
                        .navigationBarBackButtonHidden(true),
                    isActive: $viewModel.isLogoutConfirmed
                ) {
                    Button(logoutButtonLabelText) {
                        viewModel.isAlertShown.toggle()
                    }
                }
            }
            .foregroundColor(.App.purpleDark)

            .alert(alertTitle, isPresented: $viewModel.isAlertShown) {
                Button(continueButtonLabelText) {
                    viewModel.isLogoutConfirmed.toggle()
                    userRoleViewModel.resetCurrentRole()
                    dismiss()
                }
                Button(
                    cancelButtonLabelText,
                    role: .cancel
                ) { viewModel.isAlertShown.toggle() }
            }
        }
    }

    // MARK: - Private interface

    @StateObject private var viewModel = SitterMainTabViewModel()
    @State private var selection: Tab = .schedule

    @EnvironmentObject private var userRoleViewModel: UserRoleViewModel
    @Environment(\.dismiss) private var dismiss

    private let logoutButtonLabelText = "Logout"
    private let continueButtonLabelText = "Continue"
    private let cancelButtonLabelText = "Cancel"
    private let alertTitle = "Do you really want to log out?"

    private func customizeTabBar() {
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.unselectedItemTintColor = UIColor(Color.App.grayDark)
    }
}

struct SitterMainTabview_Previews: PreviewProvider {
    static var previews: some View {
        SitterMainTabView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("iPhone 14 Pro")
        SitterMainTabView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
            .previewDisplayName("iPhone 14 Pro Max")
        SitterMainTabView()
            .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
            .previewDisplayName("iPhone SE")
    }
}
