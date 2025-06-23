import SwiftUI

struct AnimatedChatbotAvatar: View {
    @State private var isAnimating = false
    @State private var isThinking = false
    @State private var isSpeaking = false
    @State private var pulseScale: CGFloat = 1.0
    @State private var rotationAngle: Double = 0
    @State private var floatingOffset: CGFloat = 0
    @State private var glowIntensity: Double = 0.5
    @State private var eyeBlink = false
    @State private var mouthScale: CGFloat = 1.0
    
    let size: CGFloat
    let isInteractive: Bool
    
    init(size: CGFloat = 120, isInteractive: Bool = true) {
        self.size = size
        self.isInteractive = true
    }
    
    var body: some View {
        ZStack {
            // Background glow
            Circle()
                .fill(Theme.accentColor.opacity(0.2))
                .frame(width: size * 1.3, height: size * 1.3)
                .scaleEffect(pulseScale)
                .opacity(glowIntensity)
                .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: pulseScale)
            
            // Main avatar body
            ZStack {
                // Head
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color.white.opacity(0.95), Color.blue.opacity(0.1)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: size * 0.8, height: size * 0.8)
                    .shadow(color: Theme.accentColor.opacity(0.3), radius: 8, x: 0, y: 4)
                
                // Face elements
                VStack(spacing: size * 0.08) {
                    // Eyes
                    HStack(spacing: size * 0.15) {
                        Eye(isBlinking: eyeBlink, size: size * 0.12)
                        Eye(isBlinking: eyeBlink, size: size * 0.12)
                    }
                    
                    // Mouth
                    Mouth(isSpeaking: isSpeaking, isThinking: isThinking, size: size * 0.15)
                }
                .offset(y: -size * 0.05)
                
                // Antenna
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(Theme.accentColor)
                        .frame(width: 3, height: size * 0.25)
                        .offset(x: size * 0.15, y: -size * 0.4)
                    
                    // Antenna light
                    Circle()
                        .fill(Theme.accentColor)
                        .frame(width: size * 0.08, height: size * 0.08)
                        .offset(x: size * 0.15, y: -size * 0.55)
                        .scaleEffect(pulseScale * 0.8)
                        .opacity(glowIntensity)
                }
                
                // Body/neck
                Rectangle()
                    .fill(Theme.accentColor.opacity(0.3))
                    .frame(width: size * 0.3, height: size * 0.15)
                    .offset(y: size * 0.35)
                    .cornerRadius(size * 0.075)
                
                // Floating particles around head
                ForEach(0..<4, id: \.self) { index in
                    FloatingParticle(
                        index: index,
                        size: size,
                        isAnimating: isAnimating
                    )
                }
            }
            .offset(y: floatingOffset)
            .animation(.easeInOut(duration: 3).repeatForever(autoreverses: true), value: floatingOffset)
        }
        .onAppear {
            startAnimations()
        }
        .onTapGesture {
            if isInteractive {
                triggerInteraction()
            }
        }
    }
    
    private func startAnimations() {
        isAnimating = true
        pulseScale = 1.1
        floatingOffset = -8
        glowIntensity = 0.7
        
        // Start blinking
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.1)) {
                eyeBlink = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut(duration: 0.1)) {
                    eyeBlink = false
                }
            }
        }
    }
    
    private func triggerInteraction() {
        // Trigger speaking animation
        withAnimation(.easeInOut(duration: 0.3)) {
            isSpeaking = true
        }
        
        // Stop speaking after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.easeInOut(duration: 0.3)) {
                isSpeaking = false
            }
        }
        
        // Add haptic feedback
        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
        impactFeedback.impactOccurred()
    }
}

struct Eye: View {
    let isBlinking: Bool
    let size: CGFloat
    @State private var eyeScale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            // Eye socket
            Circle()
                .fill(Theme.accentColor.opacity(0.2))
                .frame(width: size * 1.2, height: size * 1.2)
            
            // Eye
            Circle()
                .fill(Theme.accentColor)
                .frame(width: size, height: size)
                .scaleEffect(y: eyeScale)
                .animation(.easeInOut(duration: 0.1), value: eyeScale)
                .onChange(of: isBlinking) { _, newValue in
                    eyeScale = newValue ? 0.1 : 1.0
                }
            
            // Eye highlight
            Circle()
                .fill(Color.white.opacity(0.8))
                .frame(width: size * 0.3, height: size * 0.3)
                .offset(x: -size * 0.2, y: -size * 0.2)
        }
    }
}

struct Mouth: View {
    let isSpeaking: Bool
    let isThinking: Bool
    let size: CGFloat
    @State private var mouthScale: CGFloat = 1.0
    
    var body: some View {
        Group {
            if isSpeaking {
                // Speaking mouth - animated oval
                Ellipse()
                    .fill(Theme.accentColor)
                    .frame(width: size * 1.2, height: size * 0.6)
                    .scaleEffect(mouthScale)
                    .animation(.easeInOut(duration: 0.2).repeatForever(autoreverses: true), value: mouthScale)
                    .onAppear {
                        mouthScale = 1.3
                    }
            } else if isThinking {
                // Thinking mouth - small dot
                Circle()
                    .fill(Theme.accentColor)
                    .frame(width: size * 0.4, height: size * 0.4)
            } else {
                // Neutral mouth - small line
                Rectangle()
                    .fill(Theme.accentColor)
                    .frame(width: size * 1.2, height: size * 0.15)
                    .cornerRadius(size * 0.075)
            }
        }
    }
}

struct FloatingParticle: View {
    let index: Int
    let size: CGFloat
    let isAnimating: Bool
    
    @State private var offset: CGSize = .zero
    @State private var opacity: Double = 0.0
    @State private var scale: CGFloat = 0.0
    
    var body: some View {
        Circle()
            .fill(Theme.accentColor.opacity(0.6))
            .frame(width: 3, height: 3)
            .offset(offset)
            .opacity(opacity)
            .scaleEffect(scale)
            .animation(
                .easeInOut(duration: Double.random(in: 2...4))
                .repeatForever(autoreverses: true)
                .delay(Double(index) * 0.5),
                value: offset
            )
            .onAppear {
                let angle = Double(index) * (2 * .pi / 4)
                let radius = size * 0.5
                offset = CGSize(
                    width: cos(angle) * radius,
                    height: sin(angle) * radius
                )
                opacity = 0.8
                scale = 1.0
            }
    }
}

struct ChatbotAvatarCard: View {
    @State private var isExpanded = false
    @State private var showDetails = false
    
    var body: some View {
        Button(action: { showDetails = true }) {
            HStack(spacing: 12) {
                AnimatedChatbotAvatar(size: 50, isInteractive: false)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("AI Assistant")
                        .font(.subheadline.bold())
                        .foregroundColor(.white)
                    
                    Text("Your cosmic companion")
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.8))
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(Theme.cardBackground.opacity(0.7))
            .cornerRadius(12)
            .shadow(color: Theme.accentColor.opacity(0.3), radius: 6, x: 0, y: 3)
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showDetails) {
            ChatbotAssistantView()
        }
    }
}

struct ChatbotAssistantView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var messageText = ""
    @State private var messages: [ChatMessage] = []
    @State private var isTyping = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.primaryGradient
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header with avatar
                    VStack(spacing: 16) {
                        AnimatedChatbotAvatar(size: 100, isInteractive: true)
                        
                        Text("Cosmic AI Assistant")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                        
                        Text("Ask me anything about scholarships, applications, or your academic journey!")
                            .font(.body)
                            .foregroundColor(.white.opacity(0.8))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding()
                    
                    // Messages area
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(messages) { message in
                                MessageBubble(message: message)
                            }
                            
                            if isTyping {
                                TypingIndicator()
                            }
                        }
                        .padding()
                    }
                    
                    // Input area
                    HStack(spacing: 12) {
                        TextField("Ask me anything...", text: $messageText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundColor(.black)
                        
                        Button(action: sendMessage) {
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(.white)
                                .padding(12)
                                .background(Theme.accentColor)
                                .cornerRadius(12)
                        }
                        .disabled(messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                    .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
            }
        }
        .onAppear {
            addWelcomeMessage()
        }
    }
    
    private func addWelcomeMessage() {
        let welcomeMessage = ChatMessage(
            id: UUID(),
            text: "Hello! I'm your cosmic AI assistant. I can help you with scholarship applications, essay writing tips, deadline reminders, and much more. What would you like to know?",
            isFromUser: false,
            timestamp: Date()
        )
        messages.append(welcomeMessage)
    }
    
    private func sendMessage() {
        let trimmedText = messageText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else { return }
        
        let userMessage = ChatMessage(
            id: UUID(),
            text: trimmedText,
            isFromUser: true,
            timestamp: Date()
        )
        messages.append(userMessage)
        messageText = ""
        
        // Simulate AI response
        isTyping = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let response = generateAIResponse(to: trimmedText)
            let aiMessage = ChatMessage(
                id: UUID(),
                text: response,
                isFromUser: false,
                timestamp: Date()
            )
            messages.append(aiMessage)
            isTyping = false
        }
    }
    
    private func generateAIResponse(to message: String) -> String {
        let lowercased = message.lowercased()
        
        if lowercased.contains("scholarship") || lowercased.contains("apply") {
            return "I can help you find scholarships that match your profile! Try using the Smart Filters feature to search by your GPA, field of study, and other criteria. You can also check the Scholarship Alert Radar for new opportunities."
        } else if lowercased.contains("essay") || lowercased.contains("write") {
            return "The AI Essay Assistant in the More section can help you brainstorm ideas, improve your writing, and get feedback on your scholarship essays. It's powered by advanced AI to make your applications stand out!"
        } else if lowercased.contains("deadline") || lowercased.contains("time") {
            return "Don't worry about missing deadlines! The app tracks all your saved scholarships and sends you notifications. You can also add deadlines to your calendar directly from the app."
        } else if lowercased.contains("mentor") || lowercased.contains("help") {
            return "Connect with experienced mentors through the Mentorship Marketplace! Find Waterloo CS students and other professionals who can guide you through your academic journey."
        } else {
            return "I'm here to help with your scholarship journey! You can ask me about finding scholarships, writing essays, meeting deadlines, connecting with mentors, or any other academic questions. What specific area would you like to explore?"
        }
    }
}

struct ChatMessage: Identifiable {
    let id: UUID
    let text: String
    let isFromUser: Bool
    let timestamp: Date
}

struct MessageBubble: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.isFromUser {
                Spacer()
            }
            
            VStack(alignment: message.isFromUser ? .trailing : .leading, spacing: 4) {
                Text(message.text)
                    .font(.body)
                    .foregroundColor(message.isFromUser ? .white : .black)
                    .padding()
                    .background(
                        message.isFromUser ? Theme.accentColor : Color.white.opacity(0.9)
                    )
                    .cornerRadius(16)
                
                Text(message.timestamp.formatted(date: .omitted, time: .shortened))
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.6))
            }
            
            if !message.isFromUser {
                Spacer()
            }
        }
    }
}

struct TypingIndicator: View {
    @State private var dotScale1: CGFloat = 1.0
    @State private var dotScale2: CGFloat = 1.0
    @State private var dotScale3: CGFloat = 1.0
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 4) {
                    ForEach(0..<3, id: \.self) { index in
                        Circle()
                            .fill(Theme.accentColor)
                            .frame(width: 8, height: 8)
                            .scaleEffect(index == 0 ? dotScale1 : (index == 1 ? dotScale2 : dotScale3))
                            .animation(
                                .easeInOut(duration: 0.6)
                                .repeatForever(autoreverses: true)
                                .delay(Double(index) * 0.2),
                                value: index == 0 ? dotScale1 : (index == 1 ? dotScale2 : dotScale3)
                            )
                    }
                }
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(16)
                
                Text("AI is typing...")
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.6))
            }
            
            Spacer()
        }
        .onAppear {
            dotScale1 = 1.5
            dotScale2 = 1.5
            dotScale3 = 1.5
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        AnimatedChatbotAvatar(size: 120)
        ChatbotAvatarCard()
    }
    .padding()
    .background(Theme.primaryGradient)
} 