# Example: Gordon Ramsay roasts a utility file

## Input code

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

Come here. COME HERE. Everyone, STOP what you're doing and look at this.

This person has written a UTILITY FILE. "Helpful utilities," it says at the top. HELPFUL. Let's see how HELPFUL it is, shall we?

1. **You've written a wrapper for ADDITION.** `function add(a, b) { return a + b; }` — Are you SERIOUS right now?! JavaScript already HAS addition! It's the PLUS SIGN! It's been there since 1995! What's next, `function breathe() { return inhale() && exhale(); }`?! And subtract! And multiply! You've reimplemented a CALCULATOR! A FOUR-FUNCTION CALCULATOR! My MICROWAVE has more computational ambition than this file!

2. **`isNull`. `isUndefined`. `isNullOrUndefined`.** You've written THREE functions to do what `x == null` does in ONE expression. JavaScript's loose equality was DESIGNED for this exact comparison — it's one of the only times `==` is actually the RIGHT choice — and you've turned it into a bureaucracy! A NULL-CHECKING BUREAUCRACY! And somewhere in your codebase, someone is importing `isNullOrUndefined` and feeling PRODUCTIVE about it!

3. **`toString`, `toNumber`, `toBoolean`.** You have wrapped `String()`, `Number()`, and `Boolean()` — BUILT-IN GLOBAL FUNCTIONS — inside your own functions THAT DO THE EXACT SAME THING. Why?! This is like opening a restaurant that only serves microwave meals from the restaurant next door! You're a MIDDLEMAN! You're the TICKETMASTER of JavaScript utilities — you add NOTHING and you charge for the privilege!

4. **`identity` and `noop`.** Right. `identity` returns whatever you give it. `noop` does nothing. You have written a function whose purpose is to DO NOTHING and you've put it in a file called "helpful utilities." That's not a utility, that's a PHILOSOPHY! And not a good one!

5. **`divide` doesn't check for zero.** The ONE function here that could actually justify its existence by adding safety — dividing by zero! — and it doesn't! `divide(10, 0)` returns `Infinity` and you just LET IT! The only function that had a reason to live and you've given it NOTHING to do!

6. **`sleep` is the only respectable one here.** I'll give you that. The `sleep` function actually adds something that isn't a one-liner equivalent. It's the one truffle in a bin of GARBAGE. Congratulations — you have a 6.7% success rate.

This file isn't a utility library. It's an ABSTRACTION ADDICTION. You're wrapping LANGUAGE FEATURES in functions and calling it architecture. Delete fourteen of these, keep `sleep`, and go think about what you've done.
