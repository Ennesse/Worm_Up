import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    @AppStorage("fineTimer") var fineTimer = 0.0
    @State var percorso: [String] = []
    
    var body: some View {
        NavigationStack(path: $percorso) {
            VStack(alignment: .center, spacing: 20) {
                Text("Your brain\nis rotting")
                    .font(.system(size: 50, design: .rounded))
                    .foregroundStyle(Color.colorRose)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Image("Image")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 220)
                
                Text("Worm it\n up!")
                    .font(.system(size: 50, design: .rounded))
                    .foregroundStyle(Color.colorRose)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                NavigationLink(value: "timer") {
                    Text("Start").foregroundStyle(Color.colorStart)
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 170, height: 70)
                        .background(.colorRose)
                        .clipShape(Capsule())
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("Color Background"))
            .navigationDestination(for: String.self) { destinazione in
                if destinazione == "timer" {
                    TimerView(percorso: $percorso)
                } else {
                    ChooseView()
                }
            }
        }
        .onAppear {
            controlla()
        }
        .onChange(of: scenePhase) { _, nuova in
            if nuova == .active {
                controlla()
            }
        }
    }
    
    func controlla() {
        if fineTimer > 0 && Date().timeIntervalSince1970 >= fineTimer {
            fineTimer = 0
            percorso = ["scelta"]
        }
    }
}

#Preview {
    ContentView()
}
