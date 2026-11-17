import SwiftUI

struct ChooseView: View {
    /* Define the grid columns (two columns, flexible width) */
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ZStack {
            Color(red: 0.66, green: 0.80, blue: 0.85)
                .ignoresSafeArea()
            VStack (alignment: .leading) {
                HStack {
                    Text("Choose how to warm up")
                        .bold()
                        .font(.largeTitle)
                    Spacer()
                    Image("WormRound").resizable().frame(width: 90, height: 90)
                }
                Text("Pick one. It takes about two minutes")
                
                Spacer()
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(GameSection.all) { section in
                        GameCardView (section: section)
                    }
                }
                Spacer()
            }
            .padding()
            
        }
    }

}
#Preview {
    ChooseView()
}
