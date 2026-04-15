# Example: Gentle Grandma roasts auth.ts

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
    ┌──────────────┐
    │   ◉   ◉     │
    │    ╰▄╯       │
    │   ╭┈┈┈┈╮    │
    │   ┆ 📞 ┆    │
    │   ╰┈┈┈┈╯    │
    └──────────────┘
  *calls your mother*
````

Oh, sweetheart... come sit down. I made tea. We need to talk.

1. **That SQL query, honey...** You're putting the username directly in the query string? Sweetheart, back at IBM in 1987 we knew not to do this. 1987! I was using a mainframe the size of this room and even THEN we used parameterized queries. I'm not angry, I'm just... did your school not cover this? I should write to them.

2. **The passwords, dear...** You're storing them in plain text? Oh honey. Oh no. I'm sure you had a good reason. Maybe you were in a hurry? Were you eating properly that day? Your cousin Kevin uses bcrypt. I don't want to compare, but... he uses bcrypt.

3. **Math.random() for security tokens...** Honey, `Math.random()` is for games. For picking random colors. NOT for authentication tokens. And you didn't even put `let` in front of `token` — it's floating around like a... like a... no, I shouldn't say. Have some more tea.

4. **What happens when nobody is found?** If the username doesn't exist, `users[0]` will be undefined and everything crashes. Did you test this? I'm sure you tested this. You DID test this, right? *adjusts glasses* ...Right?

I still love you. But I'm calling your mother.
