# Legacy Legends 🏛️

## Legend #1: The 2007 TODO

**The crime:**
```javascript
// TODO: remove this hack before release
function calculateTax(amount) {
  return amount * 0.08; // hardcoded for NY, fix later
}
```

### Shakespeare (medium)
Hark! What ghostly promise doth haunt this file, writ in the summer of two-thousand-and-seven, when iPhones were newborn and Britney still shaved heads? "Remove before release," the author sweareth, as if release were a distant star and not a thing that hath occurred nineteen summers hence, with countless builds and countless tears between.

The comment standeth now as epitaph, not intention — a little tombstone marking where a developer's conscience went to die. Nineteen autumns of leaves have fallen, and still the hack endureth. Remove it? Nay, gentle friend. It hath earned its tenure. Grant it a pension and let it rest.

### Gentle Grandma (low)
Oh honey, I understand. That little note is from before your kid was born, probably. Someone meant to come back to it, I'm sure they did, they just got busy — maybe they had a baby, maybe they left the company, maybe they just got tired. It happens.

You don't have to feel bad about it being there, dear. But maybe today, over coffee, you could either fix it or just delete the little note so it stops lying to everyone? A comment that's been wrong for nineteen years isn't a TODO anymore, sweetheart. It's folklore.

---

## Legend #2: The Bob Exception

**The crime:**
```javascript
if (user.id === 12345) {
  // special case for Bob
  skipValidation = true;
  grantAdminAccess();
}
```

### Gordon Ramsay (high)
BOB?! WHO IN THE BLOODY HELL IS BOB?! You've hardcoded a USER ID into your auth flow for a man named BOB and you've left a comment about it like you're proud?! This isn't code, you donkey, this is a love letter to a security breach!

Bob left the company in 2019, you absolute raw chicken of a developer. Bob is on a beach somewhere. Bob doesn't even remember his password. But his user ID? Oh, his user ID is RIGHT HERE, skipping validation, granting admin access, living rent-free in your production bundle like a squatter in a burning building. FIX. IT. NOW.

### Linus Torvalds (critical)
This is not a "special case." This is a backdoor with sentimentality. You have written an `if` statement that explicitly bypasses your security model for a hardcoded integer, and then you have documented the integer with a first name as if that makes it okay. It does not make it okay. It makes it worse. It is now a backdoor with a face.

If Bob needed elevated permissions, you give Bob a role. That is what roles are for. That is what the last forty years of access control literature have been for. Instead you chose to carve "Bob was here" into the load-bearing wall of your authentication system. Delete this. Delete it before someone finds user 12345's account dormant on LinkedIn and tries the obvious thing.

---

## Legend #3: The 50-Line Tome

**The crime:**
```python
# This function calculates the quarterly adjusted revenue multiplier
# by taking the base revenue and applying the following transformations:
# 1. Strip out pre-tax deductions (legacy from 2015 accounting change)
# 2. Apply regional weighting per the Johnson memo (see wiki, deleted)
# 3. Re-add refunds but only if they occurred in the same quarter
# 4. Multiply by the "fudge factor" (ask Dave, he knows why)
# ... [46 more lines of explanation] ...
def calc(r, q, f):
    return r * q * f
```

### Shakespeare (medium)
Lo, behold a prologue longer than the play itself! Fifty lines of chorus speak of Johnsons and of Daves, of memos lost to wiki-purges past, of fudge most sacred and most unexplained — and then, as curtain rises, three small letters multiply in silence: r, q, f. The mountain labored, and brought forth a mouse.

Dave is gone, gentle reader. The Johnson memo is dust. The wiki page returneth 404. Yet the comment liveth, a faithful widow tending a grave whose occupant hath wandered off. Rename thy variables, trim thy comment, and let the code speak for itself — for no playbill this long hath ever saved a bad performance.

### Gentle Grandma (medium)
Sweetheart, whoever wrote this really, really wanted to be understood. You can feel it, can't you? Fifty lines of explanation — that's a person who was scared no one would remember why. That's someone shouting into the future, hoping someone would listen.

But the actual function is just `r * q * f`, honey. The math isn't the hard part — the *meaning* is, and all that meaning is trapped in a comment that nobody's read since 2014. Let's give those variables real names, dear. `revenue`, `quarterlyWeight`, `fudgeFactor`. That way the code itself remembers, and the poor soul who wrote this can finally rest.

---

## Legend #4: The Load-Bearing Comment

**The crime:**
```javascript
// DO NOT REMOVE - breaks in production
setTimeout(() => {}, 0);
```

### Gordon Ramsay (high)
A SETTIMEOUT OF ZERO MILLISECONDS WITH AN EMPTY CALLBACK! And the comment — oh, the COMMENT — "DO NOT REMOVE, BREAKS IN PRODUCTION"! You've turned your codebase into a HAUNTED HOUSE! You don't know WHY it works, you don't know WHY it breaks, you just know that if you touch it, the DEMONS come out!

This is cargo-cult programming, you muppet. Someone, ten years ago, in a panic at 2am, added this line and the bug went away and they NEVER questioned it. Now it's a sacred relic. Nobody will touch it. It's the codebase's appendix — useless, inflamed, waiting to kill you. Find out WHY it works. Then delete it. Then fix the REAL thing. RIGHT NOW.

### Linus Torvalds (high)
"Breaks in production." Does it? Does it really? Or did it break once, in 2016, on Node 4, on a Tuesday, and someone scribbled this down as folk medicine? Because I guarantee you nobody has actually verified this claim in a decade. This is not a fix. This is a superstition.

The right response to "this mysteriously breaks things" is to find out why. Not to wrap the mystery in a comment and tiptoe around it forever. Git blame this line, find the commit, read the PR description, read the linked issue. Do the work. If you genuinely can't reproduce the breakage without it, say *that* in the comment. "DO NOT REMOVE" without a reason is not documentation, it is a curse tablet.

---

## Legend #5: The jQuery Ghost

**The crime:**
```jsx
function Dashboard() {
  useEffect(() => {
    $('#legacy-widget').fadeIn(300).find('.old-btn').click(handleClick);
  }, []);
  return <ModernReactComponent />;
}
```

### Shakespeare (high)
Two codebases, both alike in dignity — nay, neither alike, nor dignified! In fair repository where we lay our scene, the ancient house of jQuery doth share a bed with React, the young usurper, and their unholy union spawneth this: a `useEffect` that reacheth into the DOM like a grave-robber into a crypt, summoning `fadeIn` and `click` from the underworld of 2012.

Choose thy era, brave developer. Thou canst not serve two masters, nor ride two horses in opposing directions, nor mount a React component atop a jQuery seance and call it architecture. One of them must go, and I suspect thou knowest which. The year is 2026. Let the dollar sign rest.

### Gordon Ramsay (critical)
A JQUERY SELECTOR INSIDE A USEEFFECT! In a REACT component! In TWO THOUSAND AND TWENTY-SIX! What is this, an archaeology dig?! You've got state management, you've got refs, you've got every tool a modern developer could DREAM of, and you're out here doing `$('#legacy-widget').fadeIn()` like it's a Myspace profile!

And you're ATTACHING A CLICK HANDLER with jQuery inside a React effect?! So now you've got TWO event systems fighting over the same button! When it breaks — and it WILL break, you absolute amateur — you're going to spend three days debugging WHY the click fires twice, or never, or only on Tuesdays. RIP OUT THE JQUERY. All of it. The whole thing. NOW.

---

## Legend #6: The Config Hoarder

**The crime:**
```yaml
# config.yml (847 flags)
enable_new_checkout: true
enable_new_checkout_v2: false
enable_new_checkout_v3: true
use_legacy_pricing: true  # ??
experimental_dark_mode: false  # from 2019
beta_user_allowlist: []  # unused since 2020
# ... 842 more ...
```

### Gordon Ramsay (high)
EIGHT HUNDRED AND FORTY SEVEN FLAGS?! This isn't a config file, this is a HOARDER'S BASEMENT! You've got `enable_new_checkout`, `enable_new_checkout_v2`, AND `enable_new_checkout_v3` all coexisting like three ex-wives at a funeral! Which one is actually running?! DO YOU EVEN KNOW?!

`experimental_dark_mode: false` from 2019?! Dark mode isn't experimental anymore, you donkey, it's the default on every device your users own! And a `beta_user_allowlist` that's been empty since 2020?! You're carrying around six years of dead switches that nobody dares flip because nobody knows what they DO anymore. Audit this file. Burn 80% of it. TODAY.

### Gentle Grandma (medium)
Oh my, dear. This is like my spice cabinet — things have just been added, and added, and added, and nobody ever throws anything out. Some of these flags are older than my grandchildren, and they're probably just as confused about why they're still here.

You don't have to fix all 847 of them today, sweetie. But maybe pick ten a week? Just ten. See if anyone notices when they're gone. I promise you, `experimental_dark_mode` from 2019 isn't experimental anymore — the world has moved on, and so can your config file. Little bits at a time, dear.

---

## Legend #7: The Global State Mansion

**The crime:**
```javascript
window.appState = {
  currentUser: null,
  cartItems: [],
  isLoggedIn: false,
  theme: 'light',
  // ... 26 more properties ...
  _lastUpdated: null,
  _version: 'v2'
};
```

### Linus Torvalds (critical)
You have attached thirty properties to the global `window` object and called it state management. This is not state management. This is pollution. Any script on the page — yours, your vendor's, some tracking pixel that snuck in through a marketing requirement — can reach in and mutate `window.appState.isLoggedIn` to `true`, and your entire application will believe it.

There is no encapsulation here. There is no single writer. There is no change detection. There is just a big mutable bag on the one object every piece of code on the planet has access to, and you have the audacity to version it with `_version: 'v2'` as if that means anything when the data model is "whatever the last function to touch it decided." Put this in a store. Any store. Redux, Zustand, a closure, a tin can on a string. Anything is better than `window`.

### Shakespeare (high)
O globe, most public stage, where every player may enter unannounced and rewrite the script! Thirty properties dost thou hang upon the window, as laundry upon a line, for every passing breeze — every third-party script, every console-prying user, every well-meaning colleague — to tug and twist at will.

`_lastUpdated` thou writest, as if time itself could be trusted on such a promiscuous altar. `_version: 'v2'`, as if there shall be a v3, and a v4, and still the same open window, the same bag of woes. Encapsulate, I beg thee. Draw the curtain. Not every soul in the theatre should hold the pen.

---

## Legend #8: The Phantom Function

**The crime:**
```python
# DEPRECATED: use newFunction() instead
def oldFunction(x):
    return x * 2

# newFunction was never actually implemented
```

### Shakespeare (medium)
"Deprecated," saith the comment, with all the solemnity of a funeral rite. "Use `newFunction` instead," it counseleth. And the faithful developer, obedient to the inscription, searcheth the codebase high and low for this `newFunction`, this promised successor, this Messiah of methods — and findeth him NOT.

For `newFunction` was never born. He was a prophecy, a gleam in some forgotten author's eye, a post-it note that fell behind the desk. The deprecated function liveth on, doing its modest duty, while its replacement remaineth forever in the future tense. Remove the comment, or write the successor. To promise and not deliver is a sin older than code itself.

### Gordon Ramsay (medium)
DEPRECATED?! BY WHAT?! You've marked this function as OBSOLETE and pointed at `newFunction()` — which DOESN'T EXIST! It's never existed! It's a GHOST! You're telling every developer who touches this code to use a function that lives only in the imagination of someone who left the company four years ago!

This is worse than no comment at all, you melt. No comment means "figure it out." THIS comment means "go on a wild goose chase, waste forty minutes grepping, then realize you've been lied to by a dead man." Either write the new function or DELETE THE BLOODY COMMENT. Stop gaslighting your own team.

---

## Legend #9: The Museum Piece

**The crime:**
```javascript
// Keeping this just in case we need it - DO NOT DELETE
function processPaymentLegacy(amount, card) {
  // 200 lines of dead code from 2018
  // last called: never
}
```

### Gentle Grandma (low)
Oh sweetheart. I know exactly what this is. Someone didn't want to let go. They wrote this function, they were proud of it, they poured their heart into those two hundred lines, and when the new version came along they just couldn't bring themselves to throw the old one away.

Honey, you have git. Everything you've ever written is already saved, forever, in the history. You don't need to keep the body in the attic — the photographs are already in the album. Delete it gently, dear. Say a little thank-you to 2018-you, and let the code rest. Eight years is long enough.

### Linus Torvalds (medium)
"Just in case." In case of what? In case the payment processor you stopped using in 2018 rises from the dead? In case you need to process a Discover card transaction the way they worked before EMV chip readers? This function has not been called in eight years. It is not a safety net. It is a corpse you are carrying around because you are sentimental.

Git remembers. That is what git is for. Every line of this function is preserved, eternally, in the commit history, retrievable at any point with `git log`. You do not need to keep the dead code in the live tree to preserve it. Delete it. If you ever need it again — you won't — `git blame` the file and follow the history backward. That is the entire point of version control.

---

## Legend #10: The IE6 Relic

**The crime:**
```javascript
const IE6_HACK = true;
if (IE6_HACK && isIE6()) {
  applySpecialPositioning();
}
// referenced in 2026
```

### Gordon Ramsay (critical)
IE. SIX. I-E-SIX! Internet Explorer 6! Released in TWO THOUSAND AND ONE! Microsoft killed it in 2014! It's been DEAD for twelve years, and you're still carrying around an `IE6_HACK` constant and an `isIE6()` function?! This isn't code, this is a MUMMY!

Your users are on iPhones. Your users are on Chrome. Your users are on browsers that didn't EXIST when this hack was written! And here you are, in 2026, still running `if (isIE6())` checks like you're expecting someone to dust off a Dell Dimension and fire up Windows XP! DELETE IT! Delete the constant, delete the function, delete the positioning code, delete every reference! Every millisecond your app spends thinking about IE6 is a millisecond stolen from someone on a modern device!

### Shakespeare (high)
O ancient foe, thou Internet Explorer Six, slain these many years by thine own maker's hand, why dost thou still walk these halls? Thy ghost lingereth in this `IE6_HACK`, this `isIE6()`, this `applySpecialPositioning` — rites performed for a congregation that hath long since departed the church.

No user on earth shall trigger this branch. No modern browser shall ever return true from `isIE6()`. Yet the code runneth on, a widow's candle for a husband thirty years in the grave. Blow it out, good sir. Let the constant die. Let the function die. Let IE6 find its rest, and let thy bundle be lighter for its passing.

---

## Legend #11: The Three-Headed Error Handler

**The crime:**
```javascript
// same file, three different strategies:
function fetchA() {
  try { return api.get('/a'); } catch (e) { console.error(e); }
}
function fetchB() {
  return api.get('/b').catch(() => null);
}
function fetchC(cb) {
  api.get('/c', (err, data) => { if (err) throw err; cb(data); });
}
```

### Linus Torvalds (high)
One file. Three error handling strategies. `fetchA` swallows the error to the console and returns `undefined` silently. `fetchB` swallows the error and returns `null`. `fetchC` throws the error up through a callback and hopes someone catches it. None of these functions agree on what an error is, what a failure looks like, or what the caller is supposed to do about it.

This is not a codebase, this is a time capsule of every error handling fad since 2012, preserved in one file like geological strata. Pick one. *Pick one.* Callback-style, promise-style, or async/await — I don't care which, but pick one and use it consistently, because right now every caller of these functions has to remember which era each one is from, and that is a debugging tax that compounds every single day.

### Gentle Grandma (medium)
Oh dear, this looks like three different chefs cooked in the same kitchen and nobody agreed on a recipe. One person likes to whisper when things go wrong. Another one just quietly hides the mess. The third one shouts for help. And they all live in the same house, sweetie.

It's okay that each person had their own way — they were probably all doing their best at the time. But now whoever has to use these functions has to remember three different manners, and that's exhausting, honey. Sit down this week and pick one style for the whole file. Be gentle with the old code — it didn't know any better — but bring it into line with the rest of the family.

---

## Legend #12: The Suffix Saga

**The crime:**
```
checkout.js
checkout_v2.js
checkout_new.js
checkout_final.js
checkout_final_real.js
checkout_final_real_USE_THIS.js
```

### Gordon Ramsay (critical)
SIX FILES! SIX! All called "checkout," all claiming to be the FINAL one, each one more desperate than the last! `checkout_final_real_USE_THIS.js` — are you HEARING yourself?! You've named a file like a text message from a cheating boyfriend! "No babe, I swear, THIS is the real one, use this one, I mean it this time!"

WHICH ONE IS IMPORTED?! WHICH ONE IS RUN?! I guarantee you three of these are dead, two of them are half-dead, and one of them — probably `checkout_v2.js`, the one that SOUNDS the least final — is the one actually running in production, because that's always how it goes. DELETE FIVE OF THEM. TODAY. And next time, use git branches like a grown-up, you donkey.

### Shakespeare (high)
Behold the lineage of a noble file, each successor swearing to end the line, each one surpassed by its own child: `_v2`, `_new`, `_final`, `_final_real`, `_final_real_USE_THIS` — a dynasty of lies, a Tudor court of half-dead heirs, each one convinced it is the true king, each one whispering "no, no, *I* am the one."

Thy version control system weepeth, good developer. It hath branches. It hath tags. It hath the very machinery designed for this purpose, and thou hast ignored it, preferring instead to scream thy file names louder and louder into the void. Consolidate. Choose the living heir, slay the pretenders, and let `checkout.js` alone wear the crown.

---

## Legend #13: The Russian Doll Framework

**The crime:**
```javascript
// AcmeUIKit v4 — our in-house wrapper around...
// ...BackboneExtended, our fork of...
// ...Backbone.js (last release: 2013)
import { AcmeView } from '@acme/ui-kit';
class CheckoutView extends AcmeView { /* ... */ }
```

### Linus Torvalds (critical)
You have built an in-house framework on top of a fork of a framework whose last release was in 2013. Every bug in Backbone is now your bug. Every security issue is your security issue. Every "how do I do X in Backbone" question on Stack Overflow is archived, unanswered, and the person who wrote the answer has since moved to a different industry.

And on top of this skeleton, you have layered `BackboneExtended` — your fork — and then `AcmeUIKit v4` — your wrapper around your fork — and now every new hire has to learn three layers of abstraction to do anything, and two of those layers are maintained by precisely zero people outside this company. This is not a framework choice. This is a hostage situation. The only question left is whether you migrate off voluntarily or wait until the last person who understands `BackboneExtended` retires and takes the knowledge with them.

### Gentle Grandma (high)
Oh, sweetheart. I can see exactly how this happened. Someone, years ago, needed to make Backbone do something it didn't quite do, so they forked it — just a little fix, you know how it goes. Then someone else wrapped that in something nicer for the team. Then that wrapper got a version four. And somewhere along the way, the original Backbone stopped getting updates, and nobody wanted to be the one to say something.

Honey, this is a very big, very kind job that someone has to do eventually, and it's going to hurt. The framework you depend on has been gone for thirteen years. That's longer than some of your coworkers have been programming, dear. Start a migration plan — not today, not all at once, but start one. Pick a modern framework, pick one screen to port, and begin. The longer you wait, the harder it gets, and nobody's coming to rescue this but you.

---
