//
//  ContentView.swift
//  Timer-SwiftUI
//
//  Created by Begüm Arıcı on 9.03.2025.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    @State private var hours = 0
    @State private var minutes = 0
    @State private var seconds = 0
    @State private var timerRunning = false
    @State private var timerPaused = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var totalTimeInSeconds: Int {
        return (hours * 3600) + (minutes * 60) + seconds
    }
    
    var body: some View {
        VStack {
            VStack {
                Text("\(hours) : \(minutes) : \(seconds)")
                    .onReceive(timer) { _ in
                        if totalTimeInSeconds > 0 && timerRunning && !timerPaused {
                            let newTotalTime = totalTimeInSeconds - 1
                            hours = newTotalTime / 3600
                            minutes = (newTotalTime % 3600) / 60
                            seconds = newTotalTime % 60
                        } else if totalTimeInSeconds == 0 {
                            timerRunning = false
                            scheduleNotification(in: totalTimeInSeconds)
                        }
                    }
                    .font(.system(size: 80, weight: .bold))
                    .opacity(0.80)
            }

            VStack {
                HStack {
                    VStack {
                        Text("Hours")
                            .font(.headline)
                        Picker("Hours", selection: $hours) {
                            ForEach(0..<24) { i in
                                Text("\(i)").tag(i)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                    }
                    VStack {
                        Text("Minutes")
                            .font(.headline)
                        Picker("Minutes", selection: $minutes) {
                            ForEach(0..<60) { i in
                                Text("\(i)").tag(i)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                    }
                    VStack {
                        Text("Seconds")
                            .font(.headline)
                        Picker("Seconds", selection: $seconds) {
                            ForEach(0..<60) { i in
                                Text("\(i)").tag(i)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                    }
                }
                .padding()
            }
            
            HStack(spacing: 30) {
                Button("Start") {
                    timerRunning = true
                    timerPaused = false
                    scheduleNotification(in: totalTimeInSeconds)
                }
                Button("Pause") {
                    timerPaused.toggle()
                }
                .foregroundColor(.orange)
                
                Button("Reset") {
                    hours = 0
                    minutes = 0
                    seconds = 0
                    timerRunning = false
                    timerPaused = false
                }
                .foregroundColor(.red)
            }
        }
        .padding()
    }
    
    func scheduleNotification(in seconds: Int) {
        guard seconds > 0 else { return }

        let content = UNMutableNotificationContent()
        content.title = "Timer Done"
        content.body = "Your timer has finished!"
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(seconds), repeats: false)
        let request = UNNotificationRequest(identifier: "timerNotification", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled for \(seconds) seconds later.")
            }
        }
    }
}

#Preview {
    ContentView()
}
