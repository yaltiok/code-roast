# Performance Pitfalls ⚡

## Pitfall #1: O(n²) where O(n) would work

**The crime:**
```javascript
function findDuplicates(users) {
  const dupes = [];
  for (let i = 0; i < users.length; i++) {
    for (let j = 0; j < users.length; j++) {
      if (i !== j && users[i].email === users[j].email) {
        dupes.push(users[i]);
      }
    }
  }
  return dupes;
}
```

### Linus Torvalds — NUCLEAR
This is the kind of code that makes me want to revoke people's commit access. You have a nested loop doing string comparison on every single pair of users. On 10,000 users that's 100 MILLION comparisons. A Set. A single `Set`. That's all you needed. One data structure that every undergrad learns in week three, and you reached straight past it to write the slowest possible thing.

And you're pushing duplicates into an array twice, because when i=5 matches j=9 you also hit i=9 matches j=5. So you're not just quadratic, you're quadratic AND wrong. This code is a monument to someone who refused to think for thirty seconds. I'd reject this patch and tell you to read a book before trying again.

### Gentle Grandma — mild
Oh sweetheart, this reminds me of when I used to alphabetize my recipe box by taking every card out and comparing each one to every other one. My back was sore for a week! Then little Susan showed me a better way — she said "Grandma, just sort them once and flip through in order," and oh my, what a difference.

You could do something similar here, dear. Keep a little list of emails you've already seen — like my recipe index — and check against that. Much kinder on your poor computer. It's been working so hard for you.

---

## Pitfall #2: Query inside a loop (N+1)

**The crime:**
```python
def get_orders_with_customers(orders):
    result = []
    for order in orders:
        customer = db.query("SELECT * FROM customers WHERE id = ?", order.customer_id)
        result.append({"order": order, "customer": customer})
    return result
```

### Gordon Ramsay — BURNING
ARE YOU SERIOUS? You've got a hundred orders and you're hitting the database a HUNDRED TIMES? That's not a function, that's a denial-of-service attack on your own server! Every single iteration of that loop is a network round-trip. ROUND. TRIP. To the database. In a LOOP.

This is the code equivalent of sending the waiter back to the kitchen for every single grain of salt. ONE trip. You make ONE trip with a WHERE id IN clause, or you JOIN the tables, and you bring it all back at once. My grandmother could optimize this and she's been dead for fifteen years. Rewrite it. NOW.

### Shakespeare — medium
Lo, what folly doth my weary eye behold! A loop that beggeth of the database anew with every turning of its tireless wheel. O wretched traffic on yon humble wire, where once a single query might suffice, thou sendest hundreds, each a tiny herald bearing but one crumb of what a banquet could convey.

Gather, gentle coder, thy customer IDs into one noble list, and dispatch a single messenger to fetch them all. Thy server shall sing thy praises, and thy p99 latency shall fall from mountains into meadows.

---

## Pitfall #3: Recomputing expensive value in render/hot path

**The crime:**
```jsx
function Dashboard({ transactions }) {
  const total = transactions.reduce((sum, t) => sum + expensiveCalculation(t), 0);
  const sorted = [...transactions].sort((a, b) => b.date - a.date);
  const categories = transactions.map(t => classifyWithML(t));

  return <View total={total} items={sorted} categories={categories} />;
}
```

### Linus Torvalds — HIGH
Every time React sneezes, you're re-running an ML classifier on every transaction. Every keystroke in a parent component. Every state change anywhere in the tree. You're classifying the same transactions TEN TIMES A SECOND and pretending that's fine.

`useMemo` exists. It has existed for YEARS. React literally ships with a tool designed specifically to fix this exact problem, and you ignored it. This isn't a performance pitfall, it's performance malpractice. Wrap every one of those three computations in `useMemo` with proper dependencies and stop setting your users' laptops on fire.

### Gentle Grandma — mild
Oh honey, this is like me recalculating my entire checkbook every time I write down a new grocery item. I used to do that, you know, until my accountant nephew told me I was being silly — "Grandma, just remember the running total!"

Your little screen doesn't need to sort and classify everything from scratch every time something changes. There's a thing called memoization, which is a big word for "remember what you already figured out." Give it a try, dear. Your fan won't spin so loudly.

---

## Pitfall #4: Sync I/O in async context (blocking the event loop)

**The crime:**
```javascript
app.get('/user/:id', async (req, res) => {
  const config = fs.readFileSync('./config.json');
  const template = fs.readFileSync('./template.html');
  const user = await db.getUser(req.params.id);
  res.send(render(template, user, config));
});
```

### Linus Torvalds — NUCLEAR
You wrote `async` on the function and then immediately called `readFileSync`. TWICE. Do you understand what you've done? You have a single-threaded event loop serving every request to your application, and you just froze it solid while the disk spins up. Every other user — every single one — is waiting behind your blocking read. For a config file. That never changes.

This is worse than not knowing async. This is knowing async and then walking into the kitchen and stabbing it. Use `fs.promises.readFile`, or better yet, read the bloody config ONCE at startup and cache it. Node.js is not Python's threading model. You cannot hand-wave your way through this.

### Shakespeare — medium
What treachery is this? Thou hast donned the cloak of async, yet beneath it stabb'st thy event loop with a dagger of sync. Each request that doth knock upon thy humble route must wait in line while thou, with stubborn hand, readeth from the disk as if time itself were free.

Use thou the promised version of this read, or better still, read once at dawn and hold the config dear in memory's faithful arms. Thy server shall serve a thousand where now it serveth one.

---

## Pitfall #5: Loading entire file into memory instead of streaming

**The crime:**
```python
def process_log_file(path):
    with open(path, 'r') as f:
        content = f.read()
    lines = content.split('\n')
    errors = [line for line in lines if 'ERROR' in line]
    return errors
```

### Gordon Ramsay — HOT
It's a LOG FILE! Log files are MASSIVE! You just pulled a 12 gigabyte file into RAM to search for the word "ERROR"! Your memory is SCREAMING! Your swap is on fire! And for what? To do a string match you could have done ONE LINE AT A TIME!

Stream it, you donkey! `for line in f:` — that's it, that's the whole fix, that's the entire difference between a program that works and one that OOM-kills your server at 3am. Python's file objects are ITERABLE. They stream BY DEFAULT. You had to go OUT OF YOUR WAY to write the slow version.

### Gentle Grandma — mild
Oh bless your heart, you've gone and brought the whole library home when you only needed one book! My dear late husband used to do that at the grocery store — come home with the entire aisle when I just asked for flour.

There's a lovely way in Python to read files one line at a time, just like turning pages. `for line in f`, they call it. Your computer has a much easier time of it that way, and honestly sweetie, so will you when you're not watching it crash.

---

## Pitfall #6: Regex recompiled in a hot loop

**The crime:**
```python
def extract_emails(texts):
    results = []
    for text in texts:
        matches = re.findall(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}', text)
        results.extend(matches)
    return results
```

### Linus Torvalds — HIGH
Every. Single. Iteration. You are re-parsing and re-compiling that regex pattern. The regex engine is building the same state machine over and over, millions of times, for a pattern that NEVER CHANGES. This is the kind of waste that would get you laughed out of any serious code review.

`re.compile` once, outside the loop. That's it. That's the fix. The Python documentation tells you this on page ONE of the regex section. The fact that you didn't even bother to read it, and then put this in a hot path, tells me everything about the care you put into your work. Which is zero.

### Shakespeare — medium
Behold! A pattern crafted fine, yet forged anew with every step upon the loop's endless road. Each iteration melteth down the mold and castest it again, as if the engine hath no memory of yesterday's toil.

Compile thy regex once, good sir, and keep it near thee like a trusted blade. The function `re.compile` shall serve thee well, and what took thousands of tiny forgings shall take but one. Thy CPU shall thank thee in the currency of cycles spared.

---

## Pitfall #7: JSON.parse(JSON.stringify(obj)) for deep clone

**The crime:**
```javascript
function updateNestedState(state, path, value) {
  const clone = JSON.parse(JSON.stringify(state));
  setDeep(clone, path, value);
  return clone;
}
```

### Gordon Ramsay — MEDIUM
Oh, you clever clever donkey. You've SERIALIZED an entire object to a string just to DESERIALIZE it again. That's TWO full traversals of your state tree, one of them producing a massive string allocation in the middle! For a deep clone!

And it doesn't even WORK properly! Dates become strings! `undefined` disappears! Functions vanish! `Map` and `Set` turn into empty objects! Your "clone" is a LIE and a SLOW LIE at that. Use `structuredClone`. It's built into the browser. It's built into Node. It's been there for years. USE IT.

### Gentle Grandma — mild
Oh my, this is clever in a way, isn't it sweetie? Like when I photocopy a recipe, cut it up, and tape it back together just to make a copy. It works! Sort of. Until I realize I lost the little note Grandpa wrote in the corner because the copier didn't pick it up.

There's a newer way called `structuredClone`, dear. It's like a proper photocopier that actually catches all the little details. Give it a try — I think you'll find it kinder to your dates and your Maps and all the little things that JSON just... forgets.

---

## Pitfall #8: Re-rendering entire list on every keystroke

**The crime:**
```jsx
function SearchableList({ items }) {
  const [query, setQuery] = useState('');
  return (
    <>
      <input onChange={(e) => setQuery(e.target.value)} />
      {items
        .filter(i => i.name.includes(query))
        .map(item => <HeavyItemCard key={Math.random()} item={item} />)}
    </>
  );
}
```

### Linus Torvalds — NUCLEAR
Three crimes in one component. THREE. First, you filter 50,000 items on every single keystroke with no debounce. Second, you're using `Math.random()` as a key, which means React literally cannot reconcile ANYTHING — every render unmounts and remounts every card in the list. Third, `HeavyItemCard` isn't memoized, so even if you had stable keys it would still re-render all of them.

This component doesn't just have a performance problem. It is ENTIRELY a performance problem. It has no non-performance aspects. Pressing a key in this input should trigger ONE re-render of ONE component. Instead it triggers thousands of unmount/mount cycles. You have built a machine whose sole purpose is heat.

### Shakespeare — medium
Oh tragic trio of wasted cycles! Thrice doth this humble component sin against the compact 'twixt React and reason. The filter runneth unbounded on every stroke of key. The keys themselves are random, severing the thread that maketh reconciliation possible. The cards, ungirded by memo's blessed shield, do re-render with every breath.

Debounce thy input, gentle author. Grant thy items stable keys drawn from their very essence. And wrap thy HeavyItemCard in `React.memo`, that it might rest when nothing 'bout it changes. Do these three, and thy list shall glide.

---

## Pitfall #9: setInterval not cleared, accumulating instances

**The crime:**
```jsx
function LiveTicker({ symbol }) {
  const [price, setPrice] = useState(0);
  useEffect(() => {
    setInterval(async () => {
      const p = await fetchPrice(symbol);
      setPrice(p);
    }, 1000);
  }, [symbol]);
  return <div>{price}</div>;
}
```

### Gordon Ramsay — BURNING
You set an interval. You NEVER clear it. And then your `useEffect` depends on `symbol`, which means every time the symbol changes you spin up ANOTHER interval on top of the old one! AAPL, TSLA, MSFT — now you've got THREE intervals running, hammering the API every second, forever, until the tab dies!

The cleanup function exists for a reason, you clown! `return () => clearInterval(id);` — that's the one line of code between "working component" and "resource leak that eventually eats someone's battery alive". Every effect that starts something must STOP it. That is THE RULE.

### Linus Torvalds — HIGH
This is a textbook resource leak dressed up in JSX. You start a timer. You hold a reference to that timer for exactly zero microseconds before throwing it away. The browser now has a ghost process polling your API until the component unmounts, except you've ALSO got a dependency array that re-runs the effect, meaning every symbol change stacks another ghost on top.

Return a cleanup. This is not optional. This is not a nice-to-have. An uncleaned `setInterval` inside `useEffect` is a bug, full stop. If you can't be bothered to clean up after yourself, don't use effects.

---

## Pitfall #10: Synchronous hashing (bcrypt sync) in request handler

**The crime:**
```javascript
app.post('/login', (req, res) => {
  const user = users.find(u => u.email === req.body.email);
  if (!user) return res.status(401).send();
  const ok = bcrypt.compareSync(req.body.password, user.hash);
  if (!ok) return res.status(401).send();
  res.send({ token: sign(user) });
});
```

### Linus Torvalds — NUCLEAR
`bcrypt.compareSync`. In an Express handler. Under load. Do you have ANY idea what you've just done? Bcrypt is, by DESIGN, CPU-expensive — that's the entire point, that's the security property. And you just took that deliberately-slow CPU work and put it on the SINGLE-THREADED EVENT LOOP.

One login attempt blocks every other request in your entire process for 100+ milliseconds. Ten concurrent logins and your server is a slideshow. A hundred and you're a denial-of-service target. The async version uses `libuv`'s thread pool. It exists precisely so this work happens OFF the event loop. Use it. Always. There is no excuse.

### Gordon Ramsay — BURNING
SYNC! In a LOGIN handler! The ONE place in your entire application where an attacker can deliberately trigger expensive work by hammering the endpoint! You've handed them a loaded gun and labeled it "aim here"! Every failed login locks your event loop! Your healthy users can't even load the homepage because some bot is spraying bad passwords at your sync bcrypt!

Use `bcrypt.compare` — no "Sync" at the end — and `await` it like a normal human being. Async bcrypt runs on the libuv pool. Your main thread stays free. Users get served. Attackers get rate-limited. Rewrite this. Immediately.

---

## Pitfall #11: Array.concat in a loop instead of push/spread

**The crime:**
```javascript
function flattenPages(pages) {
  let result = [];
  for (const page of pages) {
    result = result.concat(page.items);
  }
  return result;
}
```

### Shakespeare — medium
Oh what a subtle squandering of cycles hides within these lines! With every turn of page, thou buildest a new array entire, copying all that came before, just to append a modest handful more. 'Tis the handshake renewed at every meeting, when a nod would have sufficed.

Use `push` with the spread, good scribe — `result.push(...page.items)` — and the array shall grow in place, rather than being reborn with every step. Or reach for `flatMap`, that elegant one-liner which speaketh thy intent with grace.

### Gentle Grandma — mild
Oh honey, this is just like when I used to unpack the groceries one bag at a time by emptying the fridge, putting everything back plus the new bag, and then doing it all over again for the next bag. My daughter laughed at me for weeks!

The trick, sweetie, is to just add things to the fridge you already have. In your code that's `push` with those three little dots — `...` — and it's much quicker. Your arrays will be ever so grateful.

---

## Pitfall #12: Creating functions inside render/map

**The crime:**
```jsx
function TodoList({ todos, onToggle }) {
  return todos.map(todo => (
    <TodoItem
      key={todo.id}
      todo={todo}
      onToggle={() => onToggle(todo.id)}
      onStyle={{ color: todo.done ? 'green' : 'red' }}
    />
  ));
}
```

### Linus Torvalds — HIGH
Every render, you allocate a new `onToggle` closure and a new `onStyle` object for every item in the list. Every. Single. One. `React.memo` on TodoItem? Useless — the prop references are fresh each time, so shallow equality always fails, and every child re-renders anyway. You've actively DEFEATED the memoization you probably thought you had.

Hoist the handler with `useCallback` keyed by id, or pass the id down and let the child call `onToggle(todo.id)` itself. Move the style logic inside the child component where it can be computed against its own props. This is not advanced React. This is page two of the performance guide.

### Shakespeare — medium
Observe how, with each render's passing, a freshly-minted function is born for every todo in thy list, and a freshly-minted style object besides. These newborns bear no kinship to their yesterday's selves, and so thy memoization, however noble its intent, findeth them strangers and doth re-render all.

Lift thy handlers above the map, or pass the id alone and let the child invoke. Thy components, unshackled from needless rebirth, shall render only when truth demands it.

---

## Pitfall #13: No memoization of expensive computations

**The crime:**
```javascript
function getRecommendations(userId) {
  const user = db.getUser(userId);
  const history = db.getHistory(userId);
  const model = loadModel('./recommender.bin');
  const embeddings = computeEmbeddings(history);
  return model.predict(user, embeddings);
}
```

### Gordon Ramsay — BURNING
You load the model from DISK. On every single call. Every. Call. The model is a static binary artifact! It doesn't change between requests! It's the same bytes every time! And you're pulling it off the disk, parsing it, allocating all its weights into memory, for EVERY call to this function!

And `computeEmbeddings` — that's expensive too, and you're running it fresh every time even when the user's history hasn't changed since last request! Cache the model at module load. Cache embeddings by history hash. This function should touch disk ONCE at startup and never again. You're cooking a five-star meal from scratch for every single customer including the ones ordering the same thing!

### Linus Torvalds — NUCLEAR
A function called `getRecommendations` that loads an ML model from disk on every invocation. I had to read that twice because I couldn't believe someone wrote it. The model is immutable. Load it ONCE at module scope. Done. That's five seconds of thought and you couldn't spare them.

And then there's no caching layer anywhere — not on the user lookup, not on the history, not on the embeddings, not on the prediction. This function will run the EXACT same computation for the EXACT same inputs as many times as you call it. Memoization is not a luxury, it's the baseline. This code is an insult to every CPU cycle it consumes.

---
