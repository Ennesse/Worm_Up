import SwiftUI

struct ChooseView: View {

    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 8) {
                
                Text("Choose how to\nworm up")
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                    .foregroundStyle(Color.colorRose)
                    .multilineTextAlignment(.leading)
                
                Text("Pick one. It takes about 2 minutes.")
                    .foregroundStyle(.white)
                
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(Array(GameSection.all.enumerated()), id: \.element.id) { index, section in
                        NavigationLink {
                            InstructionsView(istruzione: all[index])
                        } label: {
                            GameCardView(section: section)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.top, 24)
                
                Spacer()
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Color Background"))
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        ChooseView()
    }
}
