import SwiftUI
import Playgrounds
        
       
            struct ContentView: View {
            var body: some View {

                NavigationStack {
                    VStack (alignment: .center, spacing: 30){
                        Text("Your brain\nis rotting")
                            .font(.system(size: 60, design : .rounded))
                            .padding().foregroundStyle(Color.colorRose).fontWeight(.bold).multilineTextAlignment(.center)
                            

                        Image("Image")

                        Text("Worm it\n up!").font(.system(size: 60, design: .rounded))
                            .padding().foregroundStyle(Color.colorRose).fontWeight(.bold).multilineTextAlignment(.center)
                            

                        NavigationLink(destination: ChooseView()) {
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
                }
            }
        }



#Preview {
    ContentView()
}

#Playground {
    _ = 1 + 2
}
