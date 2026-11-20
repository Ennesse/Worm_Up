import SwiftUI

struct ChooseView: View {
    /* Define the grid columns (two columns, flexible width) */
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ZStack {
            VStack (alignment: .leading) {
                HStack {
                    Text("Choose how to\n warm up")
                        .font(.system(size: 45)).foregroundStyle(Color.colorRose).fontWeight(.heavy).multilineTextAlignment(.leading)
                    

                }
                Text("Pick one. It takes about two minutes").foregroundStyle(.white)
                
                Spacer()
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(GameSection.all) { section in
                        GameCardView (section: section)
                    }
                }
                Spacer()
            }
            .padding()
            
        } .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("Color Background"))
    }
    

}
#Preview {
    ChooseView()
}
