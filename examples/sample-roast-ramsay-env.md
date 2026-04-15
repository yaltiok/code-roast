# Example: Gordon Ramsay roasts hardcoded credentials

## Input code

```python
import requests

API_KEY = "sk-proj-abc123def456ghi789"
DB_PASSWORD = "admin123"
SECRET_KEY = "my-super-secret-key-dont-share"
STRIPE_KEY = "sk_live_51ABC123DEF456"

def send_email(to, subject, body):
    return requests.post(
        "https://api.mailgun.net/v3/sandbox123.mailgun.org/messages",
        auth=("api", "key-abc123def456"),
        data={"from": "admin@company.com",
              "to": to,
              "subject": subject,
              "text": body})

def connect_db():
    return psycopg2.connect(
        host="prod-db.company.internal",
        database="production",
        user="root",
        password=DB_PASSWORD)
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

OH. MY. GOD.

I'VE SEEN SOME THINGS IN MY CAREER! I've seen people serve RAW CHICKEN! I've seen people MICROWAVE a LOBSTER! But THIS — THIS is the worst thing I have EVER WITNESSED in a kitchen OR a codebase!

1. **YOU'VE COMMITTED YOUR API KEYS! TO SOURCE CODE!** `API_KEY = "sk-proj-abc123def456ghi789"` — RIGHT THERE! IN PLAIN TEXT! STARING AT ME! That's like leaving the restaurant keys under the doormat with a NEON SIGN saying "KEYS HERE, HELP YOURSELF!" No — it's WORSE! It's like leaving the keys, the alarm code, the safe combination, AND your credit card taped to the front door with a note saying "GONE FOR THE WEEKEND!" You haven't just left the door open — you've REMOVED THE DOOR!

2. **"admin123"!** Your database password is "admin123"! ADMIN! ONE-TWO-THREE! A TODDLER could crack this! A toddler who can't even COUNT to four! This isn't a password — this is a WHITE FLAG! You've SURRENDERED! Every password list, every brute force dictionary, every script kiddie's FIRST ATTEMPT starts with "admin123"! You might as well have set it to "PLEASE_HACK_ME"!

3. **`SECRET_KEY = "my-super-secret-key-dont-share"`!** Oh, the IRONY! "Don't share!" it says! DON'T SHARE! YOU'VE PUT IT IN SOURCE CODE! In a FILE! That gets COMMITTED to a REPOSITORY! That gets PUSHED to a REMOTE! Every developer on your team can see it! Every intern can see it! If this repo is public, THE ENTIRE INTERNET can see it! You've written "don't share" on the thing you're SHARING! That's like writing "NOT FOOD" on a sandwich and putting it in the fridge — IT'S STILL A SANDWICH AND SOMEONE IS GOING TO EAT IT!

4. **A LIVE STRIPE KEY!** `sk_live_51ABC123DEF456` — that's a LIVE key! Not test! Not sandbox! LIVE! Connected to REAL money! REAL credit cards! REAL transactions! Someone finds this and they can charge customers, issue refunds, transfer funds — they can FINANCIALLY DISEMBOWEL your company while you're asleep! And you've left it sitting here like a TIP ON THE TABLE!

5. **PRODUCTION DATABASE CREDENTIALS!** `host="prod-db.company.internal"`, `database="production"`, `user="root"` — You're connecting to PRODUCTION! As ROOT! With a password that's basically "password"! You've given me the hostname, the database name, the username, AND the password! That's not a connection string — that's a TREASURE MAP with an X on it and a sign saying "DIG HERE"! And the Mailgun key in the auth tuple — ANOTHER key, just casually hanging out! That's FIVE secrets in ONE FILE!

This isn't code — this is a SECURITY INCIDENT waiting to happen! No, scratch that — this IS a security incident! It's ALREADY happened! The moment you committed this file, you were COMPROMISED!

`.env` files! Environment variables! Secret managers! Vault! AWS Secrets Manager! There are DOZENS of ways to do this properly and you chose NONE OF THEM! You chose the ONE approach that every security tutorial, every README, every "Getting Started" guide explicitly says "NEVER DO THIS"!

ROTATE EVERY KEY IN THIS FILE! RIGHT NOW! Not tomorrow, not after lunch — NOW! And then go learn about `.env` files and `.gitignore` before I have a COMPLETE BREAKDOWN!

GET OUT! GET OUT OF MY KITCHEN! AND CHECK YOUR GIT HISTORY BECAUSE THOSE KEYS ARE IN EVERY COMMIT!
