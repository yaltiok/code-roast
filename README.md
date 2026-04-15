# 🔥 code-roast

**AI roasts your code. With characters.**

Gordon Ramsay screaming at your auth function. Shakespeare writing sonnets about your spaghetti code. Your grandma calling your mother after reading your error handling.

<!-- TODO: Replace with actual GIF after recording -->
![code-roast demo](assets/demo.gif)

## Install

### One-liner (recommended)

```bash
git clone https://github.com/yaltiok/code-roast.git /tmp/code-roast && /tmp/code-roast/install.sh
```

### As a Claude Code plugin

```
/plugin marketplace add yaltiok/code-roast
/plugin install code-roast@username
```

### Manual

```bash
git clone https://github.com/yaltiok/code-roast.git
cp code-roast/skill.md ~/.claude/skills/code-roast/SKILL.md
cp -r code-roast/characters ~/.claude/skills/code-roast/
```

## Usage

```bash
# Roast a file (default: Gordon Ramsay, savage)
/code-roast src/auth.ts

# Pick your character
/code-roast src/api.ts as Shakespeare
/code-roast src/utils.ts as grandma

# Adjust severity
/code-roast src/main.ts gentle
/code-roast src/db.ts linus, medium

# Roast your last commit
/code-roast roast my last commit

# Roast the whole project
/code-roast roast this entire project
```

## Characters

### 🧑‍🍳 Gordon Ramsay (default)
> "THIS CODE IS SO RAW IT'S STILL COMPILING!"

Kitchen metaphors. ALL CAPS. Dramatic walkouts. The classic.

### 🐧 Linus Torvalds
> "The fact that this compiles is an accident, not an achievement."

Cold. Technical. Surgically precise. No yelling needed.

### 🎭 Shakespeare
> "What foul spaghetti hath thy fingers wrought?"

Iambic pentameter. Dramatic soliloquies. Stage directions included.

### 👵 Gentle Grandma
> "Oh sweetheart, were you tired when you wrote this?"

Sweet on the outside. Devastating on the inside. Will call your mother.

## Severity Levels

| Level | What to expect |
|-------|---------------|
| `gentle` | Light teasing, mostly constructive |
| `medium` | Real roasting, pointed observations |
| `savage` | No mercy. Maximum comedy. (default) |

## Examples

### 🧑‍🍳 Gordon Ramsay roasts an auth function (savage)

**Input code:**

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

**Roast output:**

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

---

### More Examples

#### 🧑‍🍳 Gordon Ramsay

<details>
<summary>Gordon Ramsay gently roasts a React component (gentle)</summary>

**Input code:**

```tsx
function UserProfile({ user }) {
  const [loading, setLoading] = useState(true);
  const [posts, setPosts] = useState([]);
  const [error, setError] = useState(null);
  const [comments, setComments] = useState([]);
  const [followers, setFollowers] = useState([]);
  const [following, setFollowing] = useState([]);
  
  useEffect(() => {
    fetch(`/api/users/${user.id}/posts`).then(r => r.json()).then(setPosts);
    fetch(`/api/users/${user.id}/comments`).then(r => r.json()).then(setComments);
    fetch(`/api/users/${user.id}/followers`).then(r => r.json()).then(setFollowers);
    fetch(`/api/users/${user.id}/following`).then(r => r.json()).then(setFollowing);
    setLoading(false);
  }, []);

  if (loading) return <div>Loading...</div>;
  
  return (
    <div>
      <h1>{user.name}</h1>
      <p>{posts.length} posts, {followers.length} followers</p>
    </div>
  );
}
```

**Roast output:**

````
    ╭─────────────╮
    │  ⚆ _ ⚆     │
    │    ╰─╯      │
    │  ┌─────┐    │
    │  │CHEF │    │
    │  └─────┘    │
    ╰─────────────╯
  "Look... it's not terrible."
````

Right. Come here. Sit down. No, I'm not going to yell. I can see you're TRYING, and that counts for something. But we need to talk about this component, because it's got the bones of a decent dish with some very questionable seasoning.

1. **The race condition, darling.** You're firing off four `fetch` calls, and then IMMEDIATELY calling `setLoading(false)` on the very next line. Those fetches are asynchronous! They haven't finished yet! You're telling the user "all done loading!" while the kitchen is still cooking! That loading spinner disappears before a single byte of data has arrived. Your users are staring at a "0 posts, 0 followers" screen wondering if they're that unpopular. Use `Promise.all`, wait for everything to resolve, THEN set loading to false.

2. **No error handling on ANY of those fetches.** Four network requests, zero `.catch()` blocks. What happens when one of those endpoints is down? I'll tell you what happens — NOTHING. The promise rejects silently into the void. No error message, no fallback, no indication that anything went wrong. You've got an `error` state variable sitting RIGHT THERE, completely unused, like a fire extinguisher still in the packaging. HOOK IT UP.

3. **That dependency array.** `useEffect(() => { ... }, [])` — you're depending on `user.id` inside the effect but it's not in the dependency array. If the user prop changes, your effect won't re-run, and now you're showing stale data for the wrong person. ESLint is screaming about this, by the way. Listen to it. It's smarter than both of us on dependency arrays.

4. **Two state variables you never use.** `comments` and `following` — you fetch them, you store them, and then what? They sit there, taking up memory, doing absolutely nothing. It's like buying ingredients, washing them, prepping them, and then throwing them in the bin. If the render doesn't need them, don't fetch them. And if you're planning to use them later, fine, but finish the dish before you plate it.

Look. The structure is there. You've got your state, your effect, your conditional render. It's not a disaster — it's an ALMOST. Fix the race condition, handle your errors, clean up what you don't need, and this could actually be a respectable component. Now get back in there.

</details>

<details>
<summary>Gordon Ramsay roasts a utility file (medium)</summary>

**Input code:**

```javascript
// utils.js - helpful utilities
function sleep(ms) { return new Promise(r => setTimeout(r, ms)); }
function isEven(n) { return n % 2 === 0; }
function isOdd(n) { return !isEven(n); }
function add(a, b) { return a + b; }
function subtract(a, b) { return a - b; }
function multiply(a, b) { return a * b; }
function divide(a, b) { return a / b; }
function isNull(x) { return x === null; }
function isUndefined(x) { return x === undefined; }
function isNullOrUndefined(x) { return isNull(x) || isUndefined(x); }
function toString(x) { return String(x); }
function toNumber(x) { return Number(x); }
function toBoolean(x) { return Boolean(x); }
function identity(x) { return x; }
function noop() {}
```

**Roast output:**

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

Come here. COME HERE. Everyone, STOP what you're doing and look at this.

This person has written a UTILITY FILE. "Helpful utilities," it says at the top. HELPFUL. Let's see how HELPFUL it is, shall we?

1. **You've written a wrapper for ADDITION.** `function add(a, b) { return a + b; }` — Are you SERIOUS right now?! JavaScript already HAS addition! It's the PLUS SIGN! It's been there since 1995! What's next, `function breathe() { return inhale() && exhale(); }`?! And subtract! And multiply! You've reimplemented a CALCULATOR! A FOUR-FUNCTION CALCULATOR! My MICROWAVE has more computational ambition than this file!

2. **`isNull`. `isUndefined`. `isNullOrUndefined`.** You've written THREE functions to do what `x == null` does in ONE expression. JavaScript's loose equality was DESIGNED for this exact comparison — it's one of the only times `==` is actually the RIGHT choice — and you've turned it into a bureaucracy! A NULL-CHECKING BUREAUCRACY! And somewhere in your codebase, someone is importing `isNullOrUndefined` and feeling PRODUCTIVE about it!

3. **`toString`, `toNumber`, `toBoolean`.** You have wrapped `String()`, `Number()`, and `Boolean()` — BUILT-IN GLOBAL FUNCTIONS — inside your own functions THAT DO THE EXACT SAME THING. Why?! This is like opening a restaurant that only serves microwave meals from the restaurant next door! You're a MIDDLEMAN! You're the TICKETMASTER of JavaScript utilities — you add NOTHING and you charge for the privilege!

4. **`identity` and `noop`.** Right. `identity` returns whatever you give it. `noop` does nothing. You have written a function whose purpose is to DO NOTHING and you've put it in a file called "helpful utilities." That's not a utility, that's a PHILOSOPHY! And not a good one!

5. **`divide` doesn't check for zero.** The ONE function here that could actually justify its existence by adding safety — dividing by zero! — and it doesn't! `divide(10, 0)` returns `Infinity` and you just LET IT! The only function that had a reason to live and you've given it NOTHING to do!

6. **`sleep` is the only respectable one here.** I'll give you that. The `sleep` function actually adds something that isn't a one-liner equivalent. It's the one truffle in a bin of GARBAGE. Congratulations — you have a 6.7% success rate.

This file isn't a utility library. It's an ABSTRACTION ADDICTION. You're wrapping LANGUAGE FEATURES in functions and calling it architecture. Delete fourteen of these, keep `sleep`, and go think about what you've done.

</details>

#### 🐧 Linus Torvalds

<details>
<summary>Linus roasts an over-engineered FizzBuzz (savage)</summary>

**Input code:**

```typescript
class FizzBuzzStrategyFactory {
  private strategies: Map<string, IFizzBuzzStrategy> = new Map();
  
  constructor() {
    this.strategies.set('fizz', new FizzStrategy());
    this.strategies.set('buzz', new BuzzStrategy());
    this.strategies.set('fizzbuzz', new FizzBuzzStrategy());
    this.strategies.set('default', new DefaultStrategy());
  }
  
  getStrategy(n: number): IFizzBuzzStrategy {
    if (n % 15 === 0) return this.strategies.get('fizzbuzz')!;
    if (n % 3 === 0) return this.strategies.get('fizz')!;
    if (n % 5 === 0) return this.strategies.get('buzz')!;
    return this.strategies.get('default')!;
  }
  
  execute(n: number): string {
    return this.getStrategy(n).apply(n);
  }
}

const factory = new FizzBuzzStrategyFactory();
for (let i = 1; i <= 100; i++) {
  console.log(factory.execute(i));
}
```

**Roast output:**

````
    ┌──────────────┐
    │   ◉  ╭╮  ◉  │
    │     ════     │
    │  ╱┌──────┐╲  │
    │   │ NACK │   │
    │   └──────┘   │
    └──────────────┘
  *opens email client*
````

I'm going to be blunt: this is mass psychosis dressed up as software engineering.

You have written a **Strategy Pattern, a Factory, an interface hierarchy, and a Map-based dispatch table** — to replace modulo arithmetic and an if statement. This is FizzBuzz. It prints "Fizz", "Buzz", or a number. A competent programmer solves this in five lines. You solved it in a class hierarchy that would make a Java Enterprise architect weep with pride, and that is not a compliment.

1. **`IFizzBuzzStrategy` is not a real abstraction.** You have created an interface for the concept of "returning a string." Congratulations. You have abstracted nothing. The Strategy pattern exists to encapsulate interchangeable algorithms with meaningful behavioral differences. Your "strategies" are string literals. You have built a polymorphic dispatch system to avoid writing the word `"Fizz"`.

2. **`FizzBuzzStrategyFactory` is an answer to a question nobody asked.** A factory is justified when object creation is complex, conditional, or needs to be deferred. Your factory creates four objects unconditionally in the constructor and then uses a chain of if-else to pick one — which is exactly what you'd write WITHOUT the factory, except without the factory it would be three lines instead of a class with a constructor, a Map, a lookup method, and an execute method. You have mass that does nothing.

3. **You've made FizzBuzz harder to read, harder to debug, and harder to modify.** If someone needs to add "Bazz" for multiples of 7, they now have to: create a `BazzStrategy` class, implement `IFizzBuzzStrategy`, register it in the factory constructor, add a new conditional in `getStrategy`, and pray they got the modulo priority right. In a normal implementation, they add one line. You have turned a trivial change into a four-file pull request. This is not engineering. This is job security theater.

4. **The non-null assertions are the cherry on top.** Every `.get()!` is you telling the type system "trust me, I know what I'm doing" — in code where the entire design demonstrates that you do not. If you're going to build an over-engineered castle, at least make it type-safe. You can't even do the wrong thing correctly.

5. **This code is a mass-produced artifact of someone who read "Design Patterns" and missed the part where it says "use judgment."** Patterns are tools for managing complexity. FizzBuzz has no complexity to manage. You have manufactured complexity and then applied a pattern to manage the complexity you manufactured. This is the software equivalent of breaking your own leg so you can practice using crutches.

The fact that this compiles is an accident, not an achievement. Please don't submit patches like this.

</details>

<details>
<summary>Linus gently roasts a bad API endpoint (gentle)</summary>

**Input code:**

```python
def get_users(request):
    data = json.loads(request.body)
    users = []
    for row in db.execute("SELECT * FROM users"):
        user = {}
        user['id'] = row[0]
        user['name'] = row[1]
        user['email'] = row[2]
        if data.get('include_posts'):
            posts = db.execute(f"SELECT * FROM posts WHERE user_id = {row[0]}")
            user['posts'] = [{'id': p[0], 'title': p[1]} for p in posts]
        users.append(user)
    return JsonResponse({'users': users})
```

**Roast output:**

````
    ┌──────────────┐
    │   ●  ‿  ●    │
    │     ═══      │
    │   ┌─────┐    │
    │   │ TUX │    │
    │   └─────┘    │
    └──────────────┘
  *reads patch, sighs mildly*
````

Look, this works. I can see that it works. But "works" is a very low bar, and I have to say, I'm not impressed.

1. **The N+1 query problem.** You're fetching all users, then for each user, firing a separate query to get their posts. If you have 1,000 users, that's 1,001 database calls. This is a textbook problem with a textbook solution — it's called a JOIN, it's been around since 1970, and it exists specifically so you don't do this. Your database is doing laps around the block when it could walk across the room once.

2. **That f-string is an SQL injection.** `f"SELECT * FROM posts WHERE user_id = {row[0]}"` — you're interpolating values directly into a SQL string. Yes, `row[0]` probably comes from your own database, so the risk is lower than raw user input. But this is still a bad habit. Use parameterized queries. It costs you nothing and it means you won't accidentally teach yourself that string formatting into SQL is acceptable. Because it is not.

3. **`SELECT *` and positional indexing.** You're selecting everything and then accessing columns by number — `row[0]`, `row[1]`, `row[2]`. If someone adds a column to the users table, or reorders them, your code silently returns the wrong data. Name your columns. Use a dictionary cursor. This is fragile in a way that will only bite you at 2 AM on a Saturday.

4. **No pagination, no limits.** This endpoint returns every user in your database in a single response. That's fine when you have 10 users. When you have 100,000, this endpoint becomes a denial-of-service attack against yourself. Add a LIMIT. Accept page parameters. This is not optional for production code.

5. **No error handling.** What happens when `json.loads(request.body)` fails because the request has no body? What happens on a GET request? What happens when the database is unreachable? Right now the answer to all of those is "an unhandled exception and a 500 error." Catch your exceptions. Return meaningful error responses.

This isn't terrible code. It's the kind of code you write when you're learning and nobody has reviewed your work yet. But these are all well-understood problems with well-understood solutions. Read up on them. Fix this. Then resubmit.

</details>

#### 🎭 Shakespeare

<details>
<summary>Shakespeare roasts a god function with terrible naming (savage)</summary>

**Input code:**

```javascript
function doStuff(d, f, x) {
  let r = [];
  for (let i = 0; i < d.length; i++) {
    if (f) {
      let t = d[i].split(',');
      for (let j = 0; j < t.length; j++) {
        if (x && t[j].length > 3) {
          r.push(t[j].toUpperCase());
        } else if (!x) {
          r.push(t[j]);
        }
      }
    } else {
      r.push(d[i]);
    }
  }
  return r;
}
```

**Roast output:**

````
    ┌──────────────┐
    │    ◉ ▄▄ ◉   │
    │    ╰════╯    │
    │  ╱╭┈┈┈┈╮╲   │
    │   ┆ 🪶  ┆    │
    │   ╰┈┈┈┈╯    │
    └──────────────┘
  *[BARD throws quill]*
````

# THE TRAGEDIE OF doStuff

### *A Play in Five Acts, Being the Most Lamentable Chronicle of Variable Names Most Foul*

---

**ACT I — THE NAMING**

*[Enter FUNCTION doStuff, shrouded in mystery, accompanied by its three wretched children: `d`, `f`, and `x`]*

What's in a name? That which we call a rose
By any other name would smell as sweet—
But THAT which thou hast called `doStuff` doth smell
Of rot, decay, and weekend code deployed
On Monday morn without a single test.

`doStuff`! Doth it sort? Doth it transform? Doth it
Split strings and filter by some arcane length?
ALL THREE, forsooth! A function of such greed
That Macbeth's ambition pales beside it.
It doth stuff, unstuff, and restuff again—
A name so void of meaning that the void
Itself doth weep and say, "At least I'm clear."

*[Aside]* I wrote thirty-seven plays. Each had a title. EACH TOLD YOU WHAT IT WAS ABOUT.

---

**ACT II — THE PARAMETERS**

*[Enter `d`, a mysterious figure. None know its purpose. Enter `f`, a boolean of shifting loyalties. Enter `x`, enigma wrapped in single character.]*

O `d`! Art thou data? Art thou documents?
Art thou perhaps a destiny foretold?
Nay — thou art an array of strings, unclear
As fog upon the Thames at break of day.

And `f` — dear `f` — what flag dost thou conceal?
Thou art a boolean, loyal to no cause,
Who flips the function's very soul betwixt
Two paths that neither name nor comment mark.
Thou art the ghost of Banquo at the feast—
Present, unsettling, never quite explained.

And `x` — O cursed `x`! What algebra
Hath spawned thee? Thou art the third witch's gift:
A filter? A toggle? A cosmic joke?
When `x` is true and string exceeds three chars,
We UPPERCASE — but WHY? The stars are mute.

---

**ACT III — THE NESTING**

*[The stage darkens. Loops within loops. Conditions within conditions. The audience grows uneasy.]*

Two loops! Two loops! Both alike in misery,
In fair `doStuff`, where we lay our scene.
The outer loop doth walk through `d` with `i`,
The inner loop through `t` with cursed `j`—
And nested in this labyrinth of woe,
TWO conditionals that split the path
Like Denmark's crown split Hamlet's mind in twain.

*[BARD counts on fingers]*

Four levels deep! FOUR! I wrote the entirety
Of King Lear — five acts of madness, storms,
And gouged-out eyes — with fewer plot threads than
This single function doth attempt to weave.

Hark! If `f` be true, we split by comma.
Then if `x` be true AND length exceed three,
We shout in UPPER CASE to heaven's vault.
But if `x` be false, we whisper as we are.
And if `f` be false? We simply push and move.

This is not logic. This is a CONSPIRACY.

---

**ACT IV — THE VARIABLE `r`**

*[Enter `r`, an empty array, doomed to carry the accumulated sins of every branch.]*

Et tu, `r`? Even the return value
Hath been stripped of name and dignity!
`r` — the single letter that must bear
The weight of every conditional path,
Every split string, every uppercased fragment,
Every untransformed element pushed in haste.

What art thou, `r`? A result? A response?
A requiem for readable code?
Thou art the grave where clarity was buried
Without a headstone, eulogy, or priest.

---

**ACT V — THE FUNERAL**

*[A funeral procession. Pallbearers carry the function on a bier draped in spaghetti code. All the named variables follow in mourning — such mourning as single letters can express.]*

*[BARD steps forward, removes hat]*

Here lies `doStuff` — born of haste, slain by none,
For none could understand it well enough
To find the bug that surely lurks within.
It lived unnamed, untested, undocumented,
And died as it had lived: confusingly.

Let the epitaph read thus:

> *"Here lies a function that did everything*
> *and told you nothing."*

To refactor, or not to refactor—
That is not even a question.
REFACTOR. For the love of all that compiles. REFACTOR.

*[Exeunt omnes, bearing the dead code. Thunder. Lightning. A single `console.log` echoes in the darkness.]*

**— FINIS —**

</details>

<details>
<summary>Shakespeare roasts copy-paste programming (medium)</summary>

**Input code:**

```typescript
function validateEmail(email: string) {
  if (!email) return false;
  if (!email.includes('@')) return false;
  if (email.length > 254) return false;
  return true;
}

function validateUsername(username: string) {
  if (!username) return false;
  if (!username.includes('@')) return false;
  if (username.length > 254) return false;
  return true;
}

function validatePhone(phone: string) {
  if (!phone) return false;
  if (!phone.includes('@')) return false;
  if (phone.length > 254) return false;
  return true;
}
```

**Roast output:**

````
    ┌──────────────┐
    │    ⊙ ╭╮ ⊙   │
    │    ╰───╯     │
    │   ╭┈┈┈┈╮    │
    │   ┆ 🪶  ┆    │
    │   ╰┈┈┈┈╯    │
    └──────────────┘
  *[BARD clutches pearls]*
````

*[Enter BARD, who doth read the code once, twice, thrice — then rubbeth his eyes]*

Hold. HOLD.

Methinks this function doth protest too much.
Nay — methinks these THREE functions doth protest too much, for they are THE SAME FUNCTION wearing different hats, like a troupe of actors too small for the cast, each playing king, fool, and gravedigger in turn but delivering the selfsame lines!

*[BARD holds the code aloft]*

**The First Twin — `validateEmail`**

It checks for emptiness. It checks for `@`. It checks that length doth not exceed 254.
Fair enough! An email without `@` is no email at all. I accept this premise.

**The Second Twin — `validateUsername`**

*[BARD squints]*

It checks for emptiness. It checks for... `@`? In a USERNAME? Prithee, what username requires an at-sign? And 254 characters? What user hath a name longer than a soliloquy? But soft — the greater sin is THIS: 'tis the VERY SAME CODE as before! Word for word! Letter for letter! As if the author did select all, copy, paste, and merely change the function's name, believing that repetition is the mother of validation!

**The Third Twin — `validatePhone`**

*[BARD drops to knees]*

O, what fresh horror is this! A PHONE NUMBER... that must contain `@`?! Must not exceed 254 characters?! What manner of phone number is this?! Who art thou calling — the ENTIRE GLOBE AT ONCE?!

The lady doth protest too much, and so doth the gentleman, and so doth every function in this wretched file! For they are not three validators — they are ONE validator, copied thrice, understood NONE times!

*[Rises, composing himself]*

Observe the tragedy in full: the author did write `validateEmail` — a function of modest virtue. Then, seized by the demon of CTRL+V, did birth `validateUsername` without pausing to ask, "Doth a username truly share the properties of an email?" And then — O, then! — emboldened by the ease of duplication, did conjure `validatePhone`, a function that validates phone numbers as if they were emails, because the author NEVER CHANGED THE LOGIC.

Three functions. One behavior. Zero thought.

Now is the winter of our discontent, made worse by this pull request.

*[BARD addresses the audience directly]*

A single function, `validateField`, with rules passed as parameters — this is all that was required. One function to rule them all, one function to validate them, one function to bring them all and in the type system bind them.

But nay. We got a trilogy. And like most trilogies, the second and third entries add nothing new.

*[BARD exits, muttering about DRY principles in iambic pentameter]*

</details>

#### 👵 Gentle Grandma

<details>
<summary>Grandma roasts the same auth function (savage)</summary>

**Input code:**

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

**Roast output:**

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

</details>

<details>
<summary>Grandma gently roasts a student's first program (gentle)</summary>

**Input code:**

```python
# my first program :)
name = input("whats ur name? ")
age = input("how old r u? ")
if age > 18:
    print("ur old lol")
if age > 30:
    print("ok boomer")
if age > 50:
    print("ur ancient")
if age < 18:
    print("ur a baby")
print("bye " + name + "!!!")
```

**Roast output:**

````
    ┌──────────────┐
    │   ◉   ◉     │
    │    ╰▽╯       │
    │   ╭┈┈┈┈╮    │
    │   ┆ 🍵 ┆    │
    │   ╰┈┈┈┈╯    │
    └──────────────┘
  *puts the kettle on*
````

Oh, sweetheart! Your first program! Look at you! I remember my first program — it was on a punch card the size of a placemat and it printed "HELLO" and I cried. You're doing MUCH better than I did. Come, sit, I made tea.

Now, honey, I have to tell you something, and I need you to not be upset because this is how we learn. You have a tiny little bug, and it's a very SNEAKY bug, and honestly it tricks a lot of people, so don't feel bad.

**The sneaky bug:** When you write `age = input("how old r u? ")`, Python gives you back a STRING, not a number. So when someone types "25", `age` isn't the number `25` — it's the text `"25"`. And when you compare `"25" > 18`, Python isn't comparing numbers, it's comparing a string to a number and in Python 3 this will actually CRASH with a TypeError! Oh dear.

The fix is easy, dear: `age = int(input("how old r u? "))`. Just wrap it in `int()`. Like wrapping a present, except the present is... a number. You know what I mean.

**One more little thing:** If someone types "twenty" instead of a number, `int()` will get confused and crash too. That's okay for now! But someday when you learn about `try` and `except`, you can catch that. No rush. Rome wasn't built in a day, and neither was Python.

**And the if statements!** This is actually very clever, what you've done. If someone is 55, they'll get "ur old lol" AND "ok boomer" AND "ur ancient" — all three messages! Because each `if` runs separately. You might want `elif` instead, which means "otherwise if" — so it picks just ONE message. Unless you WANT to roast people three times, in which case... sweetie, you have a future in this.

**The "bye" message** at the end — `"bye " + name + "!!!"` — works perfectly! But someday look up f-strings: `f"bye {name}!!!"`. It's the modern way. I learned it from your cousin Kevin. Don't tell him I said that.

I'm so proud of you. This program WORKS (almost). You're asking for input, making decisions, printing output — that's REAL programming! My grandchild is a programmer! Let me take a photo of the screen to show the neighbors.

Now drink your tea before it gets cold.

</details>

<details>
<summary>Grandma roasts a Promise chain nightmare (medium)</summary>

**Input code:**

```javascript
function getData() {
  return fetch('/api/users')
    .then(res => {
      return res.json().then(users => {
        return fetch('/api/posts').then(res2 => {
          return res2.json().then(posts => {
            return fetch('/api/comments').then(res3 => {
              return res3.json().then(comments => {
                return { users, posts, comments };
              })
            })
          })
        })
      })
    })
    .catch(err => console.log(err))
}
```

**Roast output:**

````
    ┌──────────────┐
    │   ◉   ◉     │
    │    ╰▄╯       │
    │   ╭┈┈┈┈╮    │
    │   ┆ 📞 ┆    │
    │   ╰┈┈┈┈╯    │
    └──────────────┘
  *squints, tilts screen*
````

Honey... come here a moment. Sit. No, bring a chair, this might take a while.

I'm looking at your code and I'm tilting my laptop and I'm tilting my HEAD and I still can't tell where one `.then` ends and the next begins. Let me get my reading glasses. The OTHER reading glasses. The ones for EMERGENCIES.

1. **Sweetheart, how deep does this go?** I counted the indentation levels. SIX. Six levels deep! When I was at IBM, we had a rule: if your code nests deeper than your filing cabinet has drawers, you need to RETHINK. My filing cabinet had four drawers, and it held records for the ENTIRE east coast branch office. Your function fetches three things from the internet and somehow needs MORE NESTING than my filing cabinet. This is not a compliment.

2. **You know about `async/await`, yes?** They invented it for exactly this situation. Instead of `.then` inside `.then` inside `.then` like those Russian nesting dolls your uncle brought from his trip — you just write `const users = await fetch('/api/users').then(r => r.json())`. Flat. Clean. Your grandmother can read it without getting vertigo. Here, let me show you what this COULD look like:

   ```javascript
   async function getData() {
     const users = await fetch('/api/users').then(r => r.json());
     const posts = await fetch('/api/posts').then(r => r.json());
     const comments = await fetch('/api/comments').then(r => r.json());
     return { users, posts, comments };
   }
   ```

   Look at that! Flat as a pancake! And if you want them all to run at the SAME TIME — because none of them depend on each other, I notice! — you use `Promise.all`. Your cousin Kevin taught me this. I'm not comparing, I'm just saying he taught me.

3. **That `.catch(err => console.log(err))`.** Oh, honey. Your error handling is `console.log`. You catch the error, you WHISPER it into the console where nobody will ever see it, and then you return `undefined` to whoever called this function. They asked for users, posts, and comments. They got `undefined`. And they will have NO IDEA why. This is like when the doctor calls and says "your results came back" and hangs up. WHAT results?! Am I okay?! You need to TELL PEOPLE what went wrong!

4. **The three fetches don't depend on each other.** You're fetching users, THEN posts, THEN comments — one after another, sequentially, waiting for each to finish. But posts don't need users! Comments don't need posts! You're making them wait in line like at the post office when there are THREE open windows. Use `Promise.all` and let them all go at once. Your page will load three times faster. Your users will THANK you.

I'm not angry, dear. This code WORKS. It fetches the data and it returns the data. But it's wrapped in so many layers that I'm getting sympathy claustrophobia.

Flatten it out. Handle your errors properly. Let independent things run in parallel. And call your grandmother more often — I worry.

</details>

## Contributing

Want to add a character? Create a file in `characters/` following the existing format:
- Persona prompt with speech patterns and catchphrases
- ASCII art for gentle/medium/savage
- Severity behavior descriptions

PRs welcome!

## License

MIT
