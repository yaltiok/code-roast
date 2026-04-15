# Example: Shakespeare roasts copy-paste programming

## Input code

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

## Roast output (medium)

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
