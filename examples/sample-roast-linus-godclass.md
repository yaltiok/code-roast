# Example: Linus Torvalds roasts a god class

## Input code

```java
public class ApplicationManager {
    // Database
    public void connectToDatabase() { }
    public void disconnectFromDatabase() { }
    public void runMigrations() { }
    
    // Auth
    public User login(String username, String password) { return null; }
    public void logout(User user) { }
    public boolean validateToken(String token) { return false; }
    
    // Email
    public void sendEmail(String to, String subject, String body) { }
    public void sendBulkEmail(List<String> recipients, String subject) { }
    
    // File Management
    public void uploadFile(MultipartFile file) { }
    public byte[] downloadFile(String fileId) { return null; }
    public void deleteFile(String fileId) { }
    
    // Payments
    public PaymentResult processPayment(PaymentRequest request) { return null; }
    public void refundPayment(String paymentId) { }
    
    // Analytics
    public void trackEvent(String eventName, Map<String, Object> properties) { }
    public AnalyticsReport generateReport(Date start, Date end) { return null; }
    
    // Notifications
    public void sendPushNotification(String userId, String message) { }
    public void sendSMS(String phoneNumber, String message) { }
    
    // Cache
    public void clearCache() { }
    public Object getFromCache(String key) { return null; }
    public void putInCache(String key, Object value) { }
    
    // Logging
    public void logInfo(String message) { }
    public void logError(String message, Exception e) { }
}
```

## Roast output (savage)

````
    ┌──────────────────┐
    │    ◉  ╭╮  ◉      │
    │      ════        │
    │  ╱┌────────────┐╲│
    │   │ ABSOLUTELY │  │
    │   │    NOT     │  │
    │   └────────────┘  │
    │                   │
    │  ╲_______________╱│
    └──────────────────┘
  *cc's entire mailing list*
  *twice*
````

`ApplicationManager`. It manages the application. ALL of it. Because apparently the Single Responsibility Principle was too complicated for you, so you decided the responsibility of this class is "everything."

Let me count the concerns in your one class. Database connectivity. Schema migrations. Authentication. Session management. Email delivery. Bulk email campaigns. File upload. File download. File deletion. Payment processing. Refunds. Analytics event tracking. Report generation. Push notifications. SMS messaging. Caching. Logging. That is **seventeen responsibilities** in one class. SEVENTEEN. The "S" in SOLID stands for Single, as in ONE. You have exceeded the limit by a factor of seventeen. This is not a class, it is a monolith with a constructor.

1. **You have built a God Class, and not even the interesting kind.** In medieval theology, God is at least omniscient — all-knowing. Your class is omni-responsible but knows nothing about any of its responsibilities. Every method returns `null` or has an empty body. This is a class that claims to do everything and actually does nothing. It is the enterprise Java equivalent of an empty promise.

2. **Your comments ARE your architecture.** You have section comments — `// Database`, `// Auth`, `// Email` — which means you already know these are separate concerns. You literally labeled the boundaries where you should have split this into separate classes, and then you didn't. The comments are a confession. You saw the right thing to do, you documented it, and then you chose violence.

3. **Testing this is a nightmare you haven't woken up from yet.** To unit test `processPayment`, you now need to instantiate a class that also has database connections, email sending, file management, and SMS capabilities. Your test setup will need to mock seventeen unrelated subsystems to verify that one payment method works. Every test is coupled to every responsibility. Change the caching interface? Your payment tests break. Add a logging parameter? Your auth tests break. This is a dependency graph that looks like a plate of spaghetti dropped from orbit.

4. **This class will grow until it collapses under its own weight.** Right now it's 30-something methods. In six months, when someone needs to add Slack notifications, they'll add `sendSlackMessage` here — because where else would it go? It's the ApplicationManager. It manages. Then someone adds webhooks. Then scheduled jobs. Then PDF generation. I've seen classes like this reach 3,000 lines in production. They become the black hole at the center of the codebase that everything depends on and nobody dares refactor because touching one method might break twelve unrelated features.

5. **Every single method signature screams "I should be my own service."** `processPayment(PaymentRequest)` is a `PaymentService`. `sendEmail(to, subject, body)` is an `EmailService`. `connectToDatabase()` is a `DatabaseConnectionManager`. These aren't even ambiguous cases. A first-year CS student who has seen one UML diagram would split this into separate classes. You didn't need to read the Gang of Four book. You needed to read the TABLE OF CONTENTS.

Here is what this class should look like:

```java
// It shouldn't. This class should not exist.
// Delete it. Create:
//   - DatabaseManager
//   - AuthService
//   - EmailService
//   - FileService
//   - PaymentService
//   - AnalyticsService
//   - NotificationService
//   - CacheService
// And use dependency injection to compose them.
```

The fact that you needed section comments to navigate your own class is the clearest possible signal that it needs to be split. You wrote the diagnosis in your own code and still missed it. That takes a special kind of determination.

Do not send me patches that look like this. I will reject them, and I will CC the list so everyone can learn from your mistakes.
