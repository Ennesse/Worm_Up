//
//  Timeview.swift
//  WormUp
//
//  Created by Siria Neri on 24/11/2026.
//

import SwiftUI
import Combine
import AlarmKit
import AppIntents

struct DatiTimer: AlarmMetadata {}

struct ApriAppIntent: LiveActivityIntent {
    static let title: LocalizedStringResource = "Open app"
    static let openAppWhenRun = true
    
    @Parameter(title: "alarmID") var alarmID: String
    
    init(alarmID: String) {
        self.alarmID = alarmID
    }
    
    init() {
        self.alarmID = ""
    }
    
    func perform() async throws -> some IntentResult {
        try AlarmManager.shared.stop(id: UUID(uuidString: alarmID)!)
        return .result()
    }
}

struct TimerView: View {
    @Binding var percorso: [String]
    @AppStorage("fineTimer") var fineTimer = 0.0
    
    @State var minuti = 1
    @State var secondi = 0
    @State var rimanenti = 0
    @State var inCorso = false
    @State var scaduto = false
    @State var idAllarme = UUID()
    @State var visto = false
    @State var messaggio = ""
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 30) {
            
            if scaduto {
                Text("Time's up!")
                    .font(.system(size: 50, design: .rounded))
                    .bold()
                    .foregroundStyle(Color.colorRose)
                
                Image("Attention")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                
                Button {
                    fermaAllarme()
                } label: {
                    Text("Stop")
                        .font(.title)
                        .bold()
                        .foregroundStyle(Color.colorStart)
                        .frame(width: 170, height: 70)
                        .background(Color.colorRose)
                        .clipShape(Capsule())
                }
                
            } else if inCorso {
                Text(String(format: "%02d:%02d", rimanenti / 60, rimanenti % 60))
                    .font(.system(size: 80, design: .rounded))
                    .bold()
                    .foregroundStyle(Color.colorRose)
                
                Text(messaggio)
                    .font(.caption)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Button {
                    annulla()
                } label: {
                    Text("Cancel")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.white)
                }
                
            } else {
                Text("Set timer")
                    .font(.system(size: 50, design: .rounded))
                    .bold()
                    .foregroundStyle(Color.colorRose)
                
                HStack {
                    Picker("Minuti", selection: $minuti) {
                        ForEach(0..<60) { numero in
                            Text("\(numero) min")
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: 130)
                    
                    Picker("Secondi", selection: $secondi) {
                        ForEach(0..<60) { numero in
                            Text("\(numero) sec")
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: 130)
                }
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Button {
                    avvia()
                } label: {
                    Text("Start")
                        .font(.title)
                        .bold()
                        .foregroundStyle(Color.colorStart)
                        .frame(width: 170, height: 70)
                        .background(Color.colorRose)
                        .clipShape(Capsule())
                }
                .disabled(minuti == 0 && secondi == 0)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Color Background"))
        .onReceive(timer) { _ in
            if inCorso {
                rimanenti = Int((fineTimer - Date().timeIntervalSince1970).rounded(.up))
                if rimanenti <= 0 {
                    inCorso = false
                    scaduto = true
                }
            }
        }
        .task {
            for await lista in AlarmManager.shared.alarmUpdates {
                if lista.contains(where: { $0.id == idAllarme }) {
                    visto = true
                } else if visto {
                    vaiAScelta()
                }
            }
        }
    }
    
    func avvia() {
        let totale = minuti * 60 + secondi
        let fine = Date().addingTimeInterval(Double(totale))
        idAllarme = UUID()
        fineTimer = fine.timeIntervalSince1970
        rimanenti = totale
        messaggio = "Programmo l'allarme..."
        inCorso = true
        
        Task {
            await programmaAllarme(fine)
        }
    }
    func programmaAllarme(_ fine: Date) async {
        do {
            let stato = try await AlarmManager.shared.requestAuthorization()
            messaggio = "Permesso: \(stato)"
            
            let alert = AlarmPresentation.Alert(title: "Time's up!")
            let attributes = AlarmAttributes(presentation: AlarmPresentation(alert: alert), metadata: DatiTimer(), tintColor: Color.colorRose)
            
            let configurazione = AlarmManager.AlarmConfiguration.alarm(
                schedule: .fixed(fine),
                attributes: attributes,
                stopIntent: ApriAppIntent(alarmID: idAllarme.uuidString)
            )
            
            _ = try await AlarmManager.shared.schedule(id: idAllarme, configuration: configurazione)
            messaggio = "Permesso: \(stato) - allarme programmato"
        } catch {
            messaggio = "Errore: \(error)"
        }
    }
    func annulla() {
        visto = false
        inCorso = false
        fineTimer = 0
        try? AlarmManager.shared.cancel(id: idAllarme)
    }
    
    func fermaAllarme() {
        try? AlarmManager.shared.stop(id: idAllarme)
        vaiAScelta()
    }
    
    func vaiAScelta() {
        visto = false
        fineTimer = 0
        percorso = ["scelta"]
    }
}

#Preview {
    NavigationStack {
        TimerView(percorso: .constant([]))
    }
}
