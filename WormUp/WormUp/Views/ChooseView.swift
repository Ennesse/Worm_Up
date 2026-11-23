import SwiftUI

struct ChooseView: View {

    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {

        NavigationStack {

            ZStack {

                VStack(alignment: .leading) {

                    HStack {
                        Text("Choose how to\n warm up")
                            .font(.system(size: 45))
                            .foregroundStyle(Color.colorRose)
                            .fontWeight(.heavy)
                            .multilineTextAlignment(.leading)
                    }

                    Text("Pick one. It takes about two minutes")
                        .foregroundStyle(.white)

                    Spacer()

                    LazyVGrid(columns: columns, spacing: 12) {

                        ForEach(Array(GameSection.all.enumerated()), id: \.element.id) { index, section in

                            NavigationLink {
                                InstructionsView(istruzione: all[index])
                            } label: {
                                GameCardView(section: section)
                            }
                        }
                    }

                    Spacer()
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("Color Background"))
        }
    }
}

#Preview {
    ChooseView()
}
