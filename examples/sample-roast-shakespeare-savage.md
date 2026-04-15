# Example: Shakespeare roasts a god function with terrible naming

## Input code

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

## Roast output (savage)

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
