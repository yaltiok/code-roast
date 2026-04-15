# Example: Gordon Ramsay roasts try-catch abuse

## Input code

```java
public User getUser(String id) {
    try {
        try {
            User user = userRepository.findById(id);
            try {
                user.setLastLogin(new Date());
                try {
                    userRepository.save(user);
                } catch (Exception e) {
                    System.out.println("save failed");
                }
            } catch (Exception e) {
                System.out.println("date failed");
            }
            return user;
        } catch (Exception e) {
            System.out.println("find failed");
            return null;
        }
    } catch (Exception e) {
        System.out.println("something failed");
        return null;
    }
}
```

## Roast output (medium)

````
    ╭─────────────╮
    │  ◉ ╭╮ ◉    │
    │   ╰▄▄╯     │
    │  ╱┌────┐╲   │
    │ ╱ │CHEF│ ╲  │
    │   └────┘    │
    ╰─────────────╯
  "Oh, for f—'s sake."
````

Come here. Come HERE. Look at this. LOOK AT IT.

You've written a function to get a user. ONE user. A single user from a database. And somehow you've managed to nest FOUR try-catch blocks inside each other like RUSSIAN DOLLS OF INCOMPETENCE!

1. **FOUR levels of try-catch!** Try inside try inside try inside try! It's like watching someone put on a life jacket, then a second life jacket on top, then a third, then a fourth, and then FALLING INTO THE POOL ANYWAY because you're catching `Exception` every time and printing it to `System.out` where NOBODY WILL EVER SEE IT! That's not error handling — that's error HOARDING! You're the ERROR HOARDER! There's a TV show about people like you!

2. **"something failed."** SOMETHING FAILED?! That's your error message?! The OUTERMOST catch — the last line of defense, the final safety net — and your diagnostic wisdom is "something failed"?! You know what else "something failed"? THIS CODE! Your approach to error handling! Your CAREER CHOICES! At least the inner ones say WHAT failed — "save failed," "date failed," "find failed" — but even those are about as useful as a CHOCOLATE TEAPOT! No stack trace, no user ID, no context, just a little sad println whispering into the void!

3. **You catch and CONTINUE!** The save fails and you just... keep going? You return the user even though you COULDN'T SAVE the login timestamp? That's not graceful degradation, that's DENIAL! "The kitchen is on fire but let's keep serving the appetizers!" The user gets stale data and nobody knows because your error messages are rotting in stdout like FORGOTTEN LEFTOVERS!

4. **The outer try-catch is UNREACHABLE!** That outermost `catch (Exception e)` with "something failed"? Walk me through a scenario where the inner try-catch lets an exception ESCAPE to the outer one. Go on, I'll wait. YOU CAN'T! Because you've already caught `Exception` — the broadest possible type — on the inside! That outer try-catch is DECORATIVE! It's a GARNISH on a DISASTER! It's there for EMOTIONAL SUPPORT!

5. **One try-catch. That's all you needed.** ONE! Wrap the whole thing in a single try-catch, catch specific exceptions, log them PROPERLY with a real logger, and either throw a meaningful exception up the stack or return an Optional. This isn't complicated! A PREP COOK could figure this out!

Clean it up. One try block, specific catches, a real logger, and for the love of all that is holy, stop nesting try-catches like they're MATRYOSHKA dolls!
