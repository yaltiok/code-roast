# Example: Shakespeare roasts boolean parameter abuse

## Input code

```typescript
function createUser(
    name: string,
    isAdmin: boolean,
    isVerified: boolean,
    isActive: boolean,
    isPremium: boolean,
    isInternal: boolean,
    isBeta: boolean,
    sendWelcomeEmail: boolean,
    skipValidation: boolean,
    useNewFlow: boolean
) {
    // ...
}

// Usage:
createUser("John", true, false, true, false, true, false, true, false, true);
```

## Roast output (medium)

````
    ┌──────────────┐
    │    ⊙ ╭╮ ⊙   │
    │    ╰───╯     │
    │   ╭┈┈┈┈╮    │
    │   ┆ 🪶  ┆    │
    │   ╰┈┈┈┈╯    │
    └──────────────┘
  *[BARD clutches forehead]*
````

# THE PARADE OF BOOLEANS

### *A Dramatic Monologue upon the Abuse of True and False*

---

*[Enter BARD, who beholds the function signature and grows pale]*

To be `true`, or to be `false` — that is the question.
And thou hast asked it TEN TIMES.

*[BARD begins pacing]*

TEN booleans! TEN! I wrote plays with fewer characters!
The Tempest hath Prospero, Miranda, Ariel, Caliban —
FOUR souls to drive a tale of magic and revenge.
Thou hast NINE booleans and a string to create a USER.

Let us examine this procession of `true` and `false`,
This binary parade, this march of ones and zeroes
Through the gates of `createUser` like soldiers
Whose uniforms are identical and whose names
Are pinned to their backs where NO ONE CAN READ THEM.

---

**THE CALL SITE**

*[BARD holds the usage aloft with trembling hands]*

```
createUser("John", true, false, true, false, true, false, true, false, true)
```

*[BARD stares at the audience]*

Tell me. TELL ME. Without scrolling up —
Is John an admin? Is he verified? Is he premium?
Doth he receive a welcome email?
Doth he skip validation? USE THE NEW FLOW?

Thou canst not answer. NOBODY can answer.
'Tis a cipher! A riddle wrapped in a mystery
Wrapped in a function call! The fifth parameter
Is `false` — but `false` for WHAT?

`true, false, true, false, true, false, true, false, true`

'Tis not a function call — 'tis MORSE CODE.
Dash dot dash dot dash dot dash dot dash.
And the message it spells is: "HELP."

---

**THE NAMING ILLUSION**

*[BARD turns to the function signature]*

O, but the PARAMETERS have names, thou sayest!
`isAdmin`, `isVerified`, `isActive` — how clear!
How descriptive! How utterly USELESS at the call site!

For the names exist ONLY in the declaration,
Like titles on a guest list that the bouncer
Never reads. At the point of invocation,
Every boolean is stripped of its identity
And reduced to `true` or `false` —
Anonymous, interchangeable, LOST.

Swap `isAdmin` and `isVerified`?
The compiler shall not blink.
The linter shall not warn.
Only PRODUCTION shall notice,
When John — unverified, unexpectedly admin —
Deletes the database on a Tuesday afternoon.

---

**THE BOOLEAN THAT BETRAYS**

*[BARD singles out the parameters with accusatory finger]*

And within this parade lurk IMPOSTERS —
Booleans that are NOT configuration but BEHAVIOR:

`sendWelcomeEmail` — this is not a property of John!
This is a SIDE EFFECT wearing a boolean's clothes!
John does not HAVE a "sendWelcomeEmail" attribute.
John is not defined by whether we emailed him.
This belongs in a separate function, a separate call,
A separate UNIVERSE of concerns!

`skipValidation` — O, the HUBRIS!
A parameter that says "I know this data is wrong,
But I wish to proceed regardless."
'Tis a fire escape built INTO the building code —
Not for emergencies, but for CONVENIENCE.

`useNewFlow` — a FEATURE FLAG smuggled into a function signature
Like contraband through customs! This shall linger
For seven years, never removed, never toggled off,
While `useNewNewFlow` and `useActuallyNewFlow`
Queue behind it like understudies who shall never perform.

---

**THE REMEDY**

*[BARD composes himself and addresses the audience with measured calm]*

The cure is known. 'Tis older than my plays.
An OPTIONS OBJECT — a single parameter
That carries named fields, each visible at the call site:

```typescript
createUser("John", {
    isAdmin: true,
    isVerified: false,
    isActive: true,
    // ...
})
```

NOW the reader sees what `true` and `false` refer to.
NOW the order matters not. NOW a forgotten field
Defaults safely rather than silently corrupting
The NEXT boolean in line.

Or better still — separate thy concerns!
Roles belong in a role system, not a boolean.
Email belongs in a notification service.
Feature flags belong in a feature flag system.

*[BARD delivers the final verdict]*

Nine booleans is not a function signature.
'Tis a CONFESSION — a confession that the author
Could not decide what this function should do,
And so made it do EVERYTHING,
Controlled by a switchboard of `true` and `false`
That no human can read and no test can cover.

To refactor, or not to refactor?
'Tis not a boolean question.
'Tis the ONLY question.

*[BARD exits, muttering: "true false true false true false..." fading into the wings]*
