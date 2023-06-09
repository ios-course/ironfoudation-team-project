import SwiftUI

/// View to display personal information about the owner.
struct OwnerProfileView: View {
    /// View model responsible to manage data from model layer
    @ObservedObject var viewModel = OwnerProfileViewModel()

    /// Owner information editing status
    @State private var isEditingMode = false

    var body: some View {
        VStack {
            if isEditingMode {
                EditOwnerInformationView(
                    name: $viewModel.name,
                    surname: $viewModel.surname,
                    phone: $viewModel.phone,
                    address: $viewModel.address
                )
            } else {
                OwnerCardView(
                    name: viewModel.name,
                    surname: viewModel.surname,
                    phone: viewModel.phone,
                    address: viewModel.address,
                    avatarUrl: viewModel.avatarURL
                )
            }
            Spacer()
        }
        .padding(.horizontal)
        .overlay(alignment: .topTrailing) {
            Button(isEditingMode ? "Save" : "Edit") {
                if isEditingMode {
                    viewModel.save()
                }
                isEditingMode.toggle()
            }
            .buttonStyle(CapsuleWithWhiteText())
            .padding()
            .padding(.horizontal)
            .disabled(isEditingMode && viewModel.name.isEmpty)
        }
    }
}

struct OwnerProfileView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerProfileView()
    }
}
