# Naming Disasters 📝

A gallery of variable and function naming crimes.

---

## Disaster #1: Single-letter variables in a 100-line function

**The crime:**
```python
def process(a, b, c, d, e, f, g):
    h = []
    for i in a:
        j = i.x * b + c
        if j > d:
            k = j / e
            l = k - f
            m = l + g
            for n in i.items:
                o = n.p * m
                if o > h[-1] if h else 0:
                    h.append(o)
    return h
```

### 🧑‍🍳 Gordon Ramsay (savage)

WHAT IN THE BLOODY ALPHABET IS THIS?! You've used `a`, `b`, `c`, `d`, `e`, `f`, `g`, `h`, `i`, `j`, `k`, `l`, `m`, `n`, `o`, `p` — YOU'RE ONE LETTER AWAY FROM RECITING THE ENTIRE ALPHABET, YOU ABSOLUTE MUPPET! This isn't a function, this is a HOSTAGE NOTE written with FRIDGE MAGNETS!

I'm reading line seven and I have to scroll back up to remember what `e` is! What is `e`?! Is it a threshold?! A divisor?! The bloody MATHEMATICAL CONSTANT?! And then you divide by it with ZERO comment! Imagine walking into my kitchen and I label every pot "pot a", "pot b", "pot c". You'd ask "what's in pot d, chef?" and I'd say "I DON'T KNOW, IT'S A SURPRISE!" THAT'S WHAT YOUR CODE IS! A SURPRISE CASSEROLE OF CONFUSION!

And `o`?! You named a variable `o`?! In a font where `o` looks EXACTLY like zero?! I had to zoom in to 400% to confirm it wasn't `0 = n.p * m`, which wouldn't compile anyway, BUT NEITHER SHOULD THIS! GET OUT OF MY CODEBASE!

### 👵 Gentle Grandma (medium)

Oh sweetheart. I printed this function out — yes, on PAPER, with my little inkjet — and I tried to read it with my morning coffee. By variable `g` I had to put my coffee down. By variable `l` I had to put my glasses down. By variable `o` I had to call your aunt Margaret and ask her if my eyesight was going.

It's not my eyesight, honey. It's your naming.

You have SEVENTEEN single-letter variables in ONE function. Seventeen! That's more letters than I use to sign a birthday card. When I worked at IBM, we had punch cards — PUNCH CARDS, dear — and even on a punch card where every character cost us CPU time, we still wrote `itemCount` instead of `i`. Because we respected the poor soul who had to read it next. Right now, dear, I am that poor soul. And I am tired.

---

## Disaster #2: The `data` / `data2` / `finalFinalData` chain

**The crime:**
```javascript
let data = fetchUsers();
let data2 = data.filter(u => u.active);
let data3 = data2.map(u => ({ ...u, verified: true }));
let newData = data3.sort((a, b) => a.name.localeCompare(b.name));
let finalData = newData.slice(0, 50);
let finalFinalData = finalData.concat(premiumUsers);
let finalFinalDataV2 = finalFinalData.filter(u => !u.banned);
return finalFinalDataV2;
```

### 🎭 Shakespeare (savage)

Hark! What grim procession doth mine eyes behold? 'Tis `data`, and lo, her wretched offspring `data2`, and then — O cruel multiplication! — `data3` doth spring forth, each more hollow in name than the last! Is this a variable chain or the lineage of KINGS too craven to claim a proper title?!

Then cometh `newData` — NEW?! New compared to what, thou tragic scribe? In two lines hence she shall be OLD, supplanted by `finalData`, who herself is but a pretender, for `finalFinalData` awaits in the wings, sword drawn! And then — O, the HORROR — `finalFinalDataV2`, a name so desperate, so surrendered, it doth read like the last words of a drowning man clutching at versioned reeds!

"Final" thou sayest, yet FINAL it is not. Thou hast named thy variable "THE END" and then written three more chapters! This is not code — 'tis a Shakespearean tragedy of indecision, where each `data` doth plot the murder of the one before, and all die nameless in the fifth act!

### 🐧 Linus Torvalds (medium)

This is what happens when you refactor without thinking. Each transformation deserves a name that describes what it IS, not when it was created.

`data2` tells me nothing. `activeUsers` tells me everything. `data3` is meaningless. `verifiedActiveUsers` is self-documenting. Your function has six intermediate values and you chose to name them by their birth order instead of their purpose. That's not naming, that's numbering prisoners.

And `finalFinalDataV2`. Let me be direct: the moment you type "final" twice, you have admitted — in code, committed to version control — that you do not trust your own judgment. You have outsourced your uncertainty to future maintainers. They will hate you for it. I hate you for it, and I don't even know you.

---

## Disaster #3: Hungarian notation in modern TypeScript

**The crime:**
```typescript
interface User {
  strName: string;
  intAge: number;
  bIsActive: boolean;
  arrTags: string[];
  objAddress: { strStreet: string; intZip: number };
  fnOnClick: () => void;
  dtCreated: Date;
}
```

### 🐧 Linus Torvalds (savage)

Hungarian notation died in 2003. Someone needs to tell your keyboard. You have a type system. TypeScript. It is RIGHT THERE. The language is LITERALLY NAMED after types. And you are prefixing `name` with `str` to tell me it's a string — which the type annotation three characters later ALREADY SAYS.

`strName: string`. You wrote "string" TWICE. `bIsActive: boolean` — not only redundant, but wrong, because `is` already signals boolean. You've stacked two boolean prefixes. This is belt-and-suspenders-and-a-second-belt engineering. And `fnOnClick`? It's a function because it's assigned a function. The `fn` is a participation trophy for a contest nobody entered.

The worst part is `objAddress.strStreet`. You nested Hungarian notation. You went into a nested object and kept doing it. This isn't a convention, this is a COMPULSION. Delete the prefixes. Trust the type system. We built it for exactly this reason.

### 🧑‍🍳 Gordon Ramsay (medium)

Oi! OI! What year do you think it is?! 1998?! Are you writing Visual Basic 6 in a BASEMENT?! This is TYPESCRIPT, you donkey! The compiler ALREADY KNOWS `name` is a string because you WROTE `: string` RIGHT NEXT TO IT!

`bIsActive`?! The `b` is for "boolean"! The `Is` is ALSO for boolean! You've told me TWICE! I don't need to be told twice! I'm not my grandmother! And `dtCreated` — "dt"?! What is that, DATE-TIME?! DATETIME-DATE?! DOCTOR?! JUST CALL IT `createdAt` LIKE A NORMAL HUMAN BEING! Get this museum-piece notation OUT of my codebase!

---

## Disaster #4: Abbreviation soup

**The crime:**
```java
public class UsrMgr {
    public double calcTtlPrcWTx(List<Itm> itms) {
        double ttl = 0;
        for (Itm i : itms) {
            ttl += i.getPrc() * i.getQty();
        }
        return ttl * (1 + TX_RT);
    }
    
    public void prcInv(Inv inv) {
        // ...
    }
}
```

### 🎭 Shakespeare (savage)

What tongue is this?! What ancient, consonant-starved dialect hast thou dredged up from the depths?! `calcTtlPrcWTx` — I read it aloud and mine own throat rebelled! "Kal-Tettle-Prick-Witx"?! Is this a function or a CURSE inscribed upon a haunted scroll?!

Thou hast declared war upon the humble VOWEL! Each `a`, `e`, `i`, `o`, `u` lies slain upon thy method signature like fallen soldiers at Agincourt! `Usr`? `Mgr`? `Prc`? `Qty`? `Itm`? The English language weeps! SHAKESPEARE himself — ME, I am he — cannot parse this! And I INVENTED words! I made up "bedazzled" and "swagger" and EVEN I would not commit this linguistic atrocity!

`TX_RT` — TAX RATE, I presume? Or perhaps TEXAS ROUTE? TRANSMIT RATE? TYRANNOSAURUS REX? The reader knows not, for thou hast stripped the word of all meaning as a butcher strips a carcass of all flesh! Restore the vowels, knave! They cost NOTHING! They are FREE!

### 👵 Gentle Grandma (savage)

Oh, honey. Oh, dear. I need to sit down for this one.

I was reading your code on my tablet — your cousin Kevin set it up for me, it's very nice — and I came across `calcTtlPrcWTx`. I thought my tablet had a virus. I thought someone had hacked me. I called Kevin in a panic and said "Kevin, the letters are missing from my tablet." And Kevin, bless his heart, took one look and said "No, Grandma, that's just how Aunt Linda's kid writes code."

LINDA'S KID. That's YOU, sweetheart. Kevin recognized your handiwork from across the room because you have developed a REPUTATION in this family for SKIPPING VOWELS like they cost extra. `prcInv`? Process invoice? Price inventory? Precious invocation? I don't know, honey. I really don't. And you named a whole CLASS `UsrMgr` — not "User Manager," not "UserManager," but `UsrMgr`, like you were texting it to someone during a fire.

Vowels are free, dear. They come in the box with the consonants. Use them.

---

## Disaster #5: Misleading function names

**The crime:**
```python
def delete_user(user_id: int) -> None:
    user = db.get_user(user_id)
    email_service.send(user.email, template="farewell")
    analytics.track("user_deletion_requested", user_id)
    # user is NOT actually deleted
    return

def validate_input(data):
    logger.info(f"Received: {data}")
    db.save(data)
    return True  # always returns True, never actually validates
```

### 🐧 Linus Torvalds (savage)

`delete_user` does not delete the user. Let me say that again, because I'm still processing it: the function CALLED `delete_user` does NOT delete ANY user. It sends an email. It logs an event. The user remains. Untouched. Intact. Fully present in the database.

This isn't a naming problem. This is FRAUD. You have written a function whose name is a LIE. Someone will read `delete_user(id)`, assume the user is gone, build features on top of that assumption, and ship a GDPR violation to production because your function name perjured itself in their codebase.

And `validate_input`? It doesn't validate. It logs and saves. It returns `True` unconditionally. You named a pass-through `validate`. Every caller that trusts this name is compromised. Rename them, or better — rewrite them to do what the name PROMISES. Code should not lie. When code lies, people die. Not always literally. But sometimes, yes, literally.

### 🧑‍🍳 Gordon Ramsay (medium)

YOU NAMED IT `delete_user` AND IT DOESN'T DELETE THE USER?! That's like me labeling a plate "BEEF WELLINGTON" and serving you a CHEESE SANDWICH! THIS IS FOOD FRAUD! THIS IS CODE FRAUD!

The name is a CONTRACT, you muppet! When someone reads `delete_user(id)` they expect — CALL ME CRAZY — that the user gets DELETED! Not emailed a nice goodbye card like they're retiring from a post office! If it sends an email, CALL IT `send_farewell_email`! If it logs a request, CALL IT `request_user_deletion`! NAME IT WHAT IT DOES!

---

## Disaster #6: The "everything ends in -er" file

**The crime:**
```java
// In OrderSystem.java
UserManager userManager;
OrderHandler orderHandler;
PaymentProcessor paymentProcessor;
ShippingController shippingController;
NotificationService notificationService;
DataUtility dataUtility;
ReceiptGenerator receiptGenerator;
InventoryCoordinator inventoryCoordinator;
```

### 🎭 Shakespeare (medium)

Behold! The League of Extraordinary Suffixes! A Manager, a Handler, a Processor, a Controller, a Service, a Utility, a Generator, and a Coordinator — eight nouns assembled, yet not one of them doth tell me WHAT IT DOETH!

A Manager manages. But manages WHAT, scribe? A Handler handles. But handles WHY? And what, pray, is the distinction betwixt Manager and Handler? Is the Handler a lesser Manager, or the Manager a grander Handler? And the Coordinator — o, the Coordinator! — coordinateth with whom? The Controller? The Processor? Hath a summit been called? Are there MINUTES?

Thy architecture is a bureaucracy of ghosts, each with a title but no job description. Rename them for their DOMAIN, not their VAGUE MANAGERIAL VIBE. "OrderHandler" becomes "OrderValidator" or "OrderRouter." Specificity, scribe! Specificity is the soul of wit, and thine is DEAD.

### 👵 Gentle Grandma (gentle)

Oh honey, this reminds me of my old office at IBM. We had a Department Manager, a Section Handler, a Floor Coordinator, and a Process Supervisor. Do you know what any of them actually did? Neither did they, dear. Neither did they.

Your file has eight classes and they all end in vague job titles. A Manager, a Handler, a Processor — it's like reading the org chart of a company that went bankrupt. `DataUtility`? Sweetheart, "data" is half the computer, and "utility" means "it does stuff." You've named a class "Computer Stuff Class." I know you can do better, because I've seen your cousin Kevin's code, and his classes have names like `OrderRefundCalculator`. Specific. Honest. I'm just saying.

---

## Disaster #7: Booleans with negative names

**The crime:**
```javascript
if (!user.isNotDisabled) { ... }
if (noError === false) { ... }
if (!undeleted && !unverified) { ... }
const shouldNotSkipValidation = !disableValidationOverride;
if (shouldNotSkipValidation) { validate(); }
```

### 🐧 Linus Torvalds (savage)

`!user.isNotDisabled`. Let me parse this like a compiler. "Not not disabled." Two negatives. That's a positive. So the user IS disabled. So the `if` runs when the user is disabled. Which is the opposite of what the name suggests on first read. I had to do algebra to understand a conditional. Algebra.

And then `shouldNotSkipValidation = !disableValidationOverride`. That's THREE negatives in a single assignment. Should. Not. Skip. Override. Every word negates something. Running this through my head feels like being gaslit by a variable. "Do you want to validate?" "Well, I don't NOT want to NOT skip the NOT-validate override." THIS IS A CONFESSION, NOT A CONDITIONAL.

Name things positively. `isDisabled`, `hasError`, `isDeleted`, `isVerified`. Then negate at the CALL site if you must. Double negatives are a bug factory. You have built the factory, staffed the factory, and are operating it at full capacity.

### 🧑‍🍳 Gordon Ramsay (medium)

`isNotDisabled`?! So if it's `false`, it means... it IS disabled?! And you then put a `!` in FRONT of it?! So `!isNotDisabled` means `isDisabled`?! WE HAD A WORD FOR THAT! IT WAS `isDisabled`! YOU SKIPPED IT AND WENT THE LONG WAY ROUND LIKE A LOST TOURIST!

And `noError === false`?! That's — that's — my brain is ACTIVELY LEAKING! "No error equals false" — SO THERE IS AN ERROR?! JUST SAY `hasError`! SAY IT! SAY `hasError` LIKE A FUNCTIONING ADULT WITH A VOCABULARY! Stop writing conditionals that require a LOGIC PROOF to evaluate! THIS IS A SHOPPING CART, NOT A PHILOSOPHY DISSERTATION!

---

## Disaster #8: `temp`, `tmp`, `tempTmp`, `tmpTemp2` in production

**The crime:**
```python
def process_order(order):
    temp = order.items
    tmp = []
    for tempTmp in temp:
        tmpTemp = tempTmp.price
        tmpTemp2 = tmpTemp * 1.08
        tmp.append(tmpTemp2)
    temp_final = sum(tmp)
    tmp_final_real = temp_final + order.shipping
    return tmp_final_real
```

### 🧑‍🍳 Gordon Ramsay (savage)

TEMP?! TMP?! TEMP-TMP?! TMP-TEMP-TWO?! Are you trying to name variables or summon a DEMON?! This reads like an INCANTATION! `tempTmp` — that's "temporary temporary"! TEMPORARY SQUARED! TEMPORARY TO THE POWER OF TEMPORARY!

Everything is temporary! EVERYTHING! There is NO permanent variable in this function! It's all transient! It's all fleeting! This code has the emotional stability of a WEATHER FORECAST! And then `tmp_final_real` — OH, `tmp_final_real` — the name of a man who has LOST HIS MIND! "Temporary final real." Pick ONE! You can't be temporary AND final AND real! THAT'S NOT HOW WORDS WORK!

Every one of these variables is a piece of your order data! Name it after the DATA! `itemPrices`! `subtotalWithTax`! `grandTotal`! STOP naming your variables after how you FEEL about them — which is apparently "not committed"! GET OUT!

### 🎭 Shakespeare (medium)

What fresh temporal madness is this? `temp`, and then `tmp`, and THEN — forsooth! — `tempTmp`, as if the previous two were insufficient in their impermanence! Thou hast created a LINEAGE of temporariness, a DYNASTY of the fleeting!

And then, o heavens, `tmpTemp2`! A SEQUEL! The temporary hath spawned offspring, and the offspring are NUMBERED, as if thou dost plan a whole TRILOGY of placeholder variables! What cometh next, `tmpTemp3: The Reckoning`? `tempTmpFinal: The Final Chapter`? `tmp_final_real: The Real Final Chapter I Promise This Time`?!

---

## Disaster #9: `doEverything()` and `main2()`

**The crime:**
```python
def do_everything(input_data):
    # 400 lines of mixed concerns
    ...

def main2():
    # when main() got too big, we made main2()
    ...

def handle_stuff(x):
    ...

def run_it_all():
    ...
```

### 🐧 Linus Torvalds (savage)

`do_everything`. Four hundred lines. The name is HONEST, I'll give you that — it's the only honest thing in the file. It does, in fact, everything. And by doing everything, it can be reasoned about by no one. You have written the software equivalent of a Swiss Army knife where every blade is also a knife, also a fork, also a user account provisioner.

`main2` is worse. `main2` means `main` existed, got unwieldy, and instead of refactoring, you photocopied the problem. "Main" is supposed to be THE entry point. Singular. By definition. There cannot be a "main2" for the same reason there cannot be a "first2". If you needed a second main, you needed a second PROGRAM, or — hear me out — a properly factored function with a NAME.

`handle_stuff`. `run_it_all`. These are not names, they are shrugs committed to version control. A name is a promise about behavior. You have promised nothing. You have written a function called "stuff handler" and expect the reader to find out what stuff, and what handling, by reading 400 lines of code. No. Rename. Refactor. Ship.

### 👵 Gentle Grandma (savage)

Oh dear. Oh DEAR. I need a moment.

Sweetheart, you have a function called `do_everything`. Everything. EVERYTHING, dear. Does it do laundry? Does it walk my dog Biscuit? Does it pay my property taxes? Because if it does EVERYTHING, those are covered, and I'd like to sign up. But I suspect — call it grandmother's intuition — that it doesn't do everything. It does ONE thing, poorly, in 400 lines. And you named it `do_everything` because you couldn't figure out what that one thing WAS.

And `main2`. Oh, honey. Your cousin Kevin had a `main` once. Just one. When it got too long, do you know what Kevin did? He SPLIT IT UP. Into functions with NAMES. Like `parseConfig` and `runMigrations` and `startServer`. He did not make a `main2`. He did not make a `main3`. And now Kevin has a mortgage and a golden retriever, and you have `main2`. I'm not saying those things are connected. But I'm not saying they're not.

---

## Disaster #10: Variables named after what they WERE

**The crime:**
```javascript
// Originally held old users, refactored to hold current users
let oldUserList = fetchCurrentActiveUsers();

// Used to be a string, now it's an object
let userNameString = { first: "Jane", last: "Doe" };

// Was deprecated, is now the main flow
function legacyCheckout(cart) {
    return processPaymentV3(cart);
}

// Was a temporary fix in 2019
const TEMPORARY_HOTFIX_RATE = 0.0875;  // still in use
```

### 🎭 Shakespeare (savage)

O, the PAST clingeth to thy variables like a ghost that refuseth to depart! `oldUserList` — "old," sayest thou?! Yet it holdeth the CURRENT users, the LIVING users, the users who YET BREATHE! Thou hast named the present after the past, and so thy code is haunted — HAUNTED, I say — by the echoes of a refactor thou didst not finish!

`userNameString` is an OBJECT. An OBJECT, forsooth, bearing the name of a STRING! 'Tis as if thou didst rename thy hound "Goldfish" and then wonder why he fetcheth not from the pond! The name lies. The type tells the truth. And the reader — poor, trusting reader — believeth the name and is DECEIVED!

And `TEMPORARY_HOTFIX_RATE` — temporary since 2019! Seven years temporary! That is not temporary, scribe, that is a MARRIAGE! Thou hast wed this hotfix and hast not told it! Rename it, or — by Heaven — give it the dignity of permanence!

### 🐧 Linus Torvalds (medium)

Refactoring without renaming is half-finished work. `oldUserList` holds current users. `userNameString` holds an object. `legacyCheckout` is the main flow. Every one of these names is a time bomb for the next person who reads the code and trusts what they see.

`TEMPORARY_HOTFIX_RATE` is the one I want to single out. It has been in production for SEVEN YEARS. Seven years is not temporary. Seven years is tenure. Seven years is a dog's entire lifespan. Your "temporary" hotfix has outlived actual dogs. Rename it to `SALES_TAX_RATE` or whatever it actually represents, and delete the word "temporary" from your vocabulary until you can use it honestly.

Names describe what something IS, not what it USED to be. The git history remembers the past. The code should describe the present.
