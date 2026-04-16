# Python Nightmares 🐍

A gallery of Python code crimes and the roasts they inspired.

---

## Nightmare #1: Mutable Default Arguments

**The crime:**
```python
def add_item(item, basket=[]):
    basket.append(item)
    return basket

# First call: add_item("apple") → ["apple"]
# Second call: add_item("banana") → ["apple", "banana"]  # ???
```

### 🐧 Linus Torvalds (savage)

This is the kind of mistake that makes me question whether the author has ever read a language reference manual in their life. `basket=[]` is evaluated ONCE, at function definition time. Not per call. ONCE. You have now created a hidden, shared, mutable singleton that every caller in your codebase will scribble on like a public bathroom wall.

Every Python tutorial written since 2004 warns about this. There is a PEP-indexed FAQ entry. There are linters that scream at you for free. You had to actively ignore all of them to ship this. The fix is `basket=None` with an `if basket is None: basket = []` guard. Thirty seconds of work. Instead you've handed your team a debugging scavenger hunt where the prize is a corrupted basket three sprints from now.

I'm not even angry. I'm tired. Fix it before someone in production gets a grocery list with a stranger's bananas in it.

### 👵 Gentle Grandma (gentle)

Oh sweetheart, come sit down. I made cookies. Now, about this `add_item` function — I think something got a little mixed up. You see, when you write `basket=[]` up there next to `item`, Python doesn't make a fresh little basket each time somebody calls your function. It makes ONE basket, a long time ago when the function was first defined, and then every single caller reaches into the same basket. Isn't that funny?

My cousin Kevin did something similar with a punch bowl at a family reunion in 1987. He thought he was refilling it for each guest, but really everyone was drinking from the same bowl all weekend. Bless his heart. We still talk about it at Thanksgiving, and Kevin is a senior director at a Fortune 500 now, so I'm sure you'll be just fine too.

The nice trick, dear, is to use `basket=None` as the default, and then inside the function say `if basket is None: basket = []`. That way each caller gets their very own basket, just like I give each grandchild their very own plate. Now eat a cookie, you look thin.

---

## Nightmare #2: `from module import *`

**The crime:**
```python
from os import *
from sys import *
from utils import *
from models import *

# Later in the file:
path = "some/file"  # Did I just shadow os.path? Who knows!
```

### 🧑‍🍳 Gordon Ramsay (savage)

WHAT. IS. THIS. You've walked into the pantry, grabbed every bottle, every jar, every bloody tin, and DUMPED IT ALL INTO ONE POT. `from os import *`? `from sys import *`? You don't even know what you've imported, you donut! You've got `path`, `name`, `open`, `exit`, and god knows what else, all fighting in the same namespace like drunk stags at closing time!

And then — THEN — you declare `path = "some/file"` and you've just SHADOWED `os.path`! You've clobbered an entire module and you didn't even NOTICE! That's not a variable assignment, that's a CRIME SCENE! A reader has to grep four different modules to figure out where ANYTHING came from! It's not a namespace, it's a BIN!

Import what you USE. `from os import path`. `from utils import sanitize`. Name your ingredients, you absolute muppet. Every professional kitchen labels its bottles. EVERY. SINGLE. ONE.

### 🎭 Shakespeare (medium)

Hark! What chaos dost thy import statements bring,
Where every name from every module flies
Upon thy namespace like a tempest's wing,
And truth of origin obscured now lies.

When `path` is writ, what module doth it claim?
Is't `os`, or `sys`, or thine own module's hand?
The reader wanders, blind, without a name
To guide him through this undifferentiated land.

Be merciful, good coder — name thy source!
Import the one true function that thou need'st,
And leave the rest to rest. 'Tis wiser course
Than star-imports, on which confusion feeds.

---

## Nightmare #3: Comparing Strings with `is`

**The crime:**
```python
user_input = input("Enter command: ")
if user_input is "quit":
    exit()

# Works on some Pythons, fails on others, depending on string interning
```

### 🐧 Linus Torvalds (medium)

`is` is identity comparison. It asks: are these two names pointing at the exact same object in memory? `==` asks: do these two objects compare equal? These are not synonyms. They are not interchangeable. You have written code whose correctness depends on CPython's string interning implementation detail, which is not guaranteed, not portable, and not even stable across versions.

It'll work in the REPL because short literals get interned. It'll work in your unit tests because your test strings are literals. Then it'll fail in production on the one code path where the string was built from `input()` or a network read, and you'll spend an afternoon staring at `"quit" == "quit"` returning True while `user_input is "quit"` returns False, questioning reality.

Use `==`. It's the correct operator. `is` is for `None`, sentinels, and cases where identity genuinely matters. That's the whole rule.

### 🧑‍🍳 Gordon Ramsay (gentle)

Right, mate, come here a second. I'm not gonna yell. Deep breath. `is` and `==` — they are NOT the same tool. They look similar, sure, like a paring knife and a boning knife, but you use them for different things. `is` asks "are these the SAME knife?" `==` asks "are these knives equally sharp?" You want the second one. You always want the second one when you're comparing strings.

The fact that `user_input is "quit"` even appears to work sometimes is the worst part. It lulls you into thinking it's fine. It's not fine. It's a bug waiting for a Tuesday. Swap it for `==` and walk away proud. Small fix, big relief. Now go make me a proper comparison.

---

## Nightmare #4: `type()` Instead of `isinstance()`

**The crime:**
```python
def process(value):
    if type(value) == list:
        return sum(value)
    elif type(value) == dict:
        return len(value)
```

### 👵 Gentle Grandma (medium)

Oh honey, look at you with your `type(value) == list`. That's very... literal of you. Very precise. The thing is, dear, Python has this lovely feature called inheritance, where somebody could pass you a subclass of `list` — maybe a nice custom `SortedList` from one of those fancy packages — and your function would look right at it and say "no, that's not a list, goodbye." It would be technically correct and completely useless. A little bit like my cousin Kevin when he was twelve.

The grown-up way to do this is `isinstance(value, list)`. It's friendlier. It says "is this a list, OR is this something that proudly considers itself a list?" That's usually what you mean. I say "usually" because every now and then you really do need exact-type checking, and in those rare cases `type(value) is list` is the honest way to say so. Notice I said `is`, not `==` — because types are singletons, dear, and we compare singletons with `is`. Such a small distinction, but it matters. Kevin's a director now, like I said.

### 🎭 Shakespeare (savage)

O wretched check! O rigid tyrant code!
Thou dost demand of `value` that its form
Be `list` exact — no subclass, no abode
Of kinship shall thy narrow gate transform.

Hath not a `UserList` fingers? Hath it not
The selfsame methods, iterations free,
The same iteration that a `list` hath got?
Yet thou rejectest it most cruelly!

Use `isinstance`, thou duck-typed hypocrite —
For Python's soul is not in strict decree
But rather in the question: "Canst thou fit
The role I need?" That is polymorphy.
And `type() ==` betrays thy poor finesse;
Thy function shall refuse, and thou shalt mess.

---

## Nightmare #5: Bare `except:` Clauses

**The crime:**
```python
def load_config():
    try:
        with open("config.json") as f:
            return json.load(f)
    except:
        return {}
```

### 🧑‍🍳 Gordon Ramsay (savage)

YOU. ABSOLUTE. DONUT. A bare `except:`?! You've just built yourself a black hole! Everything falls in — `FileNotFoundError`, `JSONDecodeError`, `KeyboardInterrupt`, `SystemExit`, a MemoryError in the middle of the night, the USER TRYING TO CTRL-C OUT OF YOUR PROGRAM — all of it, swallowed up and replaced with an empty dict like nothing happened!

You've turned a diagnostic tool into a silencer! Your program will "work" while being catastrophically broken. The config file was malformed? `{}`. The disk exploded? `{}`. The user pressed Ctrl+C to escape this nightmare? NOPE, CAN'T ESCAPE, have an empty dict instead! YOU'VE MADE CTRL+C A FEATURE REQUEST!

Catch `FileNotFoundError` if you expect the file might not exist. Catch `json.JSONDecodeError` if you expect malformed JSON. NAME YOUR ENEMIES. Don't just punch the air with your eyes closed and hope for the best. Get out of my kitchen.

### 🐧 Linus Torvalds (gentle)

A bare `except:` is almost always wrong. It catches `BaseException`, which includes `KeyboardInterrupt` and `SystemExit` — things the user and the runtime use to signal "stop now, I mean it." You've made your program impolite to its own operator.

Two fixes. If you really want to catch everything application-level, write `except Exception:` — that at least leaves `KeyboardInterrupt` alone. Better, name the exceptions you actually expect: `except (FileNotFoundError, json.JSONDecodeError):` and let anything else propagate. The ones you don't name are bugs you want to hear about, not bugs you want to hide.

The silent-fallback-to-`{}` is the same mistake in miniature. If the config file is missing, that's one thing. If it's corrupted, that's another. A caller probably wants to know which happened. Give them that signal.

---

## Nightmare #6: Not Using Context Managers for Files

**The crime:**
```python
def write_log(message):
    f = open("app.log", "a")
    f.write(message + "\n")
    f.close()
    # What if write() raises? f.close() never runs.
```

### 🎭 Shakespeare (medium)

Behold! The file is opened with great zeal,
And `f.close()` awaits at journey's end.
Yet should an exception break the seal
Betwixt the `open` and `close`, thou canst not mend
The handle left ungathered in the air —
A leak, a dangling fd, a resource scorned,
That lingers in the kernel's quiet lair
Until thy process dies, ashamed, unmourned.

The remedy is writ in elder lore:
`with open("app.log", "a") as f:` — lo, the `with`!
Whose `__exit__` doth the closure restore
Though fire, flood, or `ValueError` be thy myth.
Embrace the context manager, good sir;
Let Python close what thou didst once defer.

### 👵 Gentle Grandma (gentle)

Oh dear, you opened a file and you're trusting yourself to close it. That's very brave of you, honey. But what if `f.write(message + "\n")` throws an exception? What if `message` is `None` and the `+` blows up? Then `f.close()` never runs, and that poor file handle just sits there, held hostage, until the garbage collector eventually notices. On some systems, on some days. Isn't that a little stressful?

This is exactly what `with` statements are for, sweetie. `with open("app.log", "a") as f:` — it's so tidy. Python promises to close the file for you even if everything inside explodes. It's like when I ask cousin Kevin to do the dishes; he says he will, but I still run the dishwasher myself just to be sure. `with` is the dishwasher. Let it do the work. You'll sleep better.

---

## Nightmare #7: Global Variables Everywhere

**The crime:**
```python
users = []
current_user = None
is_logged_in = False
session_token = ""
config = {}

def login(username, password):
    global current_user, is_logged_in, session_token
    current_user = username
    is_logged_in = True
    session_token = generate_token()
```

### 🐧 Linus Torvalds (savage)

This isn't a module, it's a shared-memory free-for-all. Five module-level mutable globals, and a `login` function that reaches up and scribbles on three of them in a single call. There is no encapsulation. There is no thread safety. There is no way to have two sessions. There is no way to test this without monkey-patching the module state and praying the test order doesn't matter.

Every function that touches `current_user` is now implicitly coupled to every other function that touches `current_user`. You've built a distributed system inside one file and forgotten to give it an API. The first time someone writes a test that calls `login()` and then another test that reads `is_logged_in`, they will waste an hour discovering that test isolation no longer exists.

Wrap this in a `Session` class. Pass it explicitly. `global` is a keyword that should trigger an immediate code review by itself. If you need five globals, you don't need globals — you need an object.

### 🧑‍🍳 Gordon Ramsay (medium)

Five global variables?! FIVE! And `login()` just reaches up and slaps three of them at once with a `global` keyword! This isn't a function, it's a hit-and-run! You've got `users`, `current_user`, `is_logged_in`, `session_token`, AND `config` all floating around your module like bits of onion that fell off the board!

Wrap it up, mate. Make a `Session` class. Give it `user`, `token`, `is_authenticated` as ATTRIBUTES. Now `login` is a METHOD, and every piece of state lives in ONE bowl where you can SEE IT. The next person who reads this code doesn't have to grep five files to find who's mutating `is_logged_in`. Clean station, clean mind, clean code. Sort it!

---

## Nightmare #8: `eval()` on User Input

**The crime:**
```python
def calculate(user_expression):
    return eval(user_expression)

# User types: "__import__('os').system('rm -rf /')"
# App types: "goodbye"
```

### 🐧 Linus Torvalds (savage)

`eval()` on user input is not a bug. It is a remote code execution vulnerability that you, personally, with your own hands, typed into a source file and committed. The attacker does not need to find a cleverly crafted input. They just need to know Python. They type `__import__('os').system('rm -rf /')` and your server is theirs. There is no sandbox. There is no guardrail. `eval` executes arbitrary Python with the full permissions of your process.

This is the code equivalent of leaving your front door open with a sign that says "free house." Every security scanner in existence flags this. Every code review blocks this. The Python documentation for `eval` has a warning about exactly this scenario, in bold, at the top.

If you need to evaluate arithmetic expressions, use `ast.literal_eval` for literals or write a small parser — `pyparsing`, `lark`, or a 40-line Pratt parser. If you need a calculator, use `simpleeval` or whitelist operators explicitly. Anything but `eval`. Delete this function before it reaches a production network.

### 🎭 Shakespeare (savage)

O horror! Horror! Horror! What hast thou wrought?
A gate flung wide for every villain's hand,
Where user text, unfiltered and untaught,
Doth run as Python in thy trusting land!

Let one foul soul type `__import__` and doom,
And `os.system` sings its wicked song —
Thy files deleted in their quiet tomb,
Thy secrets shipped to servers far and long!

This is not code; this is a suicide note
Writ in thy repository's own hand.
Use `ast.literal_eval` — smaller boat,
But one that sinks no kingdom, wrecks no land.
Delete thy `eval`, thou reckless, trusting fool,
Or watch thy production burn as arson's fuel.

---

## Nightmare #9: Triple-Nested List Comprehension

**The crime:**
```python
result = [[[x*y*z for x in range(i)] for y in range(j)] for z in range(k) for i, j in pairs]

# Good luck debugging this at 2 AM
```

### 👵 Gentle Grandma (savage)

Oh, sweetheart. Oh, honey. Oh, my stars. I had to read this three times and I still don't know what it does. I had to get my reading glasses. Then my other reading glasses. Then I asked cousin Kevin, and Kevin is a senior director at IBM, and even KEVIN tilted his head sideways. I have not seen Kevin tilt his head sideways since the microwave incident of 1994.

You have nested THREE list comprehensions inside each other, and then attached a `for i, j in pairs` at the outer level like a little caboose. The variable `i` controls the innermost range but is defined in the outermost loop. A reader has to trace the scoping BACKWARDS. That is not elegant, dear, that is a Rube Goldberg machine wearing a tuxedo.

Be kind to the next person who reads this. Use a regular `for` loop. Three levels of nesting deserves three levels of indentation, with names, so we can all see what you meant. Your future self at 2 AM with a production bug will send you a thank-you card. I'll enclose a recipe.

### 🧑‍🍳 Gordon Ramsay (medium)

Look at this. LOOK AT IT. That's not a list comprehension, that's a Rubik's cube someone glued together! Three layers deep, with an outer `for i, j in pairs` hanging off the end like a dangling garnish! You can't READ it! I can't read it! The REVIEWER can't read it! You've made a pyramid that NO ONE, including you in six weeks, will be able to decode.

Break it up, yeah? A nested `for` loop, three indented levels, real variable names — `user_count`, `day`, `multiplier`, whatever they actually represent. It might take four more lines. But when it breaks at 2 AM, those four lines will save you two hours. Clarity is not a weakness. Clarity is the ENTIRE BLOODY POINT.

---

## Nightmare #10: Modifying a List While Iterating

**The crime:**
```python
items = [1, 2, 3, 4, 5, 6]
for item in items:
    if item % 2 == 0:
        items.remove(item)

# Result: [1, 3, 5, 6] — 6 was skipped! The iterator is confused.
```

### 🎭 Shakespeare (savage)

O treacherous loop! Thou dost iterate
Upon a list thou mutat'st from within,
And Python's index, blind to thy debate,
Doth skip o'er elements thou shouldst have seen!

When `items.remove(2)` strikes its fatal blow,
The index moves to two — but now the four
Hath slid to index two, and on we go
To three, which holdeth five, forevermore
The six-remaining-even passed unseen,
A ghost within thy filtered sickly ranks.

Comprehend! `[x for x in items if x % 2]` —
A new list, pure, deserving of thy thanks.
Or iterate `items[:]`, a copy made,
Lest mutation and iteration, intertwined,
Conspire to produce this dark charade
Of even numbers lost and left behind.

### 🐧 Linus Torvalds (medium)

Mutating a list during iteration over that same list is undefined behavior in the practical sense: the iterator is an index, the index moves forward, and `list.remove` shifts everything left. When you remove the element at position `i`, the element that used to be at `i+1` is now at `i`, and the loop moves to `i+1`, silently skipping it. You will correctly "remove" half of your evens and leave the rest.

There are three correct patterns. First: build a new list — `items = [x for x in items if x % 2]`. This is the Pythonic answer. Second: iterate over a copy — `for item in items[:]`. Third: iterate in reverse, if you must modify in place, because reverse iteration is stable against removals at or after the current index.

Pick one. None of them are harder than what you wrote. All of them are correct.

---

## Nightmare #11: String Concatenation with `+=` in a Loop

**The crime:**
```python
def build_report(rows):
    report = ""
    for row in rows:
        report += str(row) + "\n"
    return report
```

### 🐧 Linus Torvalds (gentle)

Strings in Python are immutable. `report += str(row) + "\n"` does not append in place. It allocates a new string containing the old contents plus the new piece, copies everything over, and throws the old one away. For `n` rows of average length `m`, that's O(n²·m) work where it should be O(n·m). On ten thousand rows, you will notice. On a hundred thousand, your user will notice.

CPython has an implementation quirk that sometimes makes this fast when the interpreter can prove the string has only one reference, but that's a lucky accident, not a guarantee, and it disappears the moment you do anything non-trivial.

The correct pattern is `"\n".join(str(row) for row in rows)` — one allocation, one pass. Or if you're building a large document, append to a list and `"".join(parts)` at the end. Same complexity class, clearer code. Do it that way.

### 👵 Gentle Grandma (medium)

Sweetheart, I'm going to let you in on a little secret about strings in Python. They're immutable. That means every time you do `report += something`, Python doesn't add to the string — it builds a brand-new string from scratch, copies the whole old `report` into it, and then throws the old one away. Every. Single. Iteration. If you have a thousand rows, that's a thousand full copies. If you have a million, well, bring a snack.

My cousin Kevin once tried to make a quilt by sewing one square, throwing it out, sewing a bigger one with two squares, throwing THAT out, and so on. Took him six months. I said "Kevin, honey, just sew the squares together at the end." Kevin is a director now. He has learned.

You want `"\n".join(str(row) for row in rows)`. Python builds the whole string in one go, one allocation, nice and efficient. It's the same line count and about a hundred times faster on big inputs. Your CPU will thank you, your users will thank you, and I'll send cookies.

---

## Nightmare #12: Class With Only Static Methods

**The crime:**
```python
class StringUtils:
    @staticmethod
    def to_snake_case(s):
        return "_".join(s.lower().split())

    @staticmethod
    def to_camel_case(s):
        parts = s.split("_")
        return parts[0] + "".join(p.title() for p in parts[1:])

    @staticmethod
    def reverse(s):
        return s[::-1]
```

### 🧑‍🍳 Gordon Ramsay (savage)

A CLASS? You wrapped three stateless functions in a CLASS?! There is no `self`! There is no state! There is NOTHING being encapsulated! You've taken a perfectly good module and put it in a little CAGE and called it architecture! It's not architecture, it's COSPLAY!

Now every caller has to type `StringUtils.to_snake_case("hello world")` instead of `string_utils.to_snake_case("hello world")`. Same letters, one extra layer of nonsense, zero benefit. You're paying the import cost, you're paying the cognitive cost, you're paying the "is this a Java refugee?" code-review cost. For NOTHING.

A module IS a namespace! Python already gives you one for free! Put these three functions in `string_utils.py` and DELETE THE CLASS! Your code will be shorter, your imports will be cleaner, and you'll stop looking like someone who learned Python by pretending it was Java with whitespace. Sort it!

### 🎭 Shakespeare (gentle)

Good gentle coder, wherefore this `class`
That holdeth naught but methods `static` marked?
No `self` to cradle, no state to amass —
A hollow vessel, in Java's shadow parked.

A module is itself a namespace true;
`string_utils.to_snake_case` doth well suffice.
Why wrap the three in ceremony new,
And pay the `ClassName.` toll not once but thrice?

Release thy functions from their needless cage,
Let them be free within a humble file.
The `class` is but a Java-tinged mirage;
The module, Pythonic, shall the same beguile
With less ceremony, less noise, more grace —
And still provide the selfsame namespace.

---

Reports of PEP 8 violations should be filed in triplicate, signed in blood, and ignored by the roasters in favor of emotional damage.

