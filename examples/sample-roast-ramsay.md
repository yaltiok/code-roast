# Example: Gordon Ramsay roasts auth.ts

## Input code

```typescript
function login(u, p) {
  let users = db.query("SELECT * FROM users WHERE username = '" + u + "'")
  if (users[0].password == p) {
    token = Math.random().toString()
    return { success: true, token: token }
  }
  return { success: false }
}
```

## Roast output (savage)

````
    ╭─────────────╮
    │  ◉ ╭╮ ◉    │
    │   ╰▄▄╯     │
    │  ╱┌────┐╲   │
    │ ╱ │CHEF│ ╲  │
    │   └────┘    │
    ╰─────────────╯
  "WHAT IS THIS?!"
````

WHAT IN THE BLOODY HELL IS THIS?!

Right, let me get this straight. You've written an authentication function — THE MOST IMPORTANT FUNCTION IN YOUR ENTIRE APPLICATION — and it looks like you did it during a commercial break!

1. **SQL INJECTION ON LINE ONE!** You're concatenating user input DIRECTLY into a SQL query! `"SELECT * FROM users WHERE username = '" + u + "'"` — ARE YOU TRYING TO GET HACKED?! My RISOTTO has better security than this! Any script kiddie with a browser can DROP YOUR ENTIRE DATABASE!

2. **PLAIN TEXT PASSWORDS!** `users[0].password == p` — you're comparing passwords in PLAIN TEXT?! No hashing, no salting, NOTHING! You've stored passwords like it's 1995 and you're running a GeoCities page! WHERE'S THE BCRYPT?!

3. **Math.random() FOR TOKENS?!** `Math.random().toString()` as an auth token?! That's not a security token, that's a LOTTERY TICKET! And `token` isn't even declared with `let` or `const` — it's a GLOBAL VARIABLE! You've just handed your auth tokens to EVERYONE!

4. **No error handling WHATSOEVER!** What if `users` is empty? What if `users[0]` is undefined? What if the database is DOWN? You just crash! BOOM! Like a souffle made by a DONKEY!

GET OUT OF MY KITCHEN! And take this function with you! SHUT IT DOWN!
