# Database Disasters 💾

## Disaster #1: N+1 Query In A Loop

**The crime:**
```python
users = db.query("SELECT * FROM users WHERE active = 1")
for user in users:
    orders = db.query(f"SELECT * FROM orders WHERE user_id = {user.id}")
    for order in orders:
        items = db.query(f"SELECT * FROM order_items WHERE order_id = {order.id}")
        user.total += sum(i.price for i in items)
```

### Gordon Ramsay — SEVERITY: NUCLEAR
YOU ABSOLUTE DONKEY. You've got ten thousand users, each with twenty orders, each with five items. That's ONE MILLION QUERIES. ONE. MILLION. Your database is on its knees begging for mercy and you're standing there with a for-loop and a smile like you've invented fire.

A single JOIN. ONE. That's all it takes. But no, you decided to chat up the database like it's your therapist, one row at a time, for the entire afternoon. The connection pool is EXHAUSTED. Your SRE is in tears. I've seen calmer kitchens during a gas leak.

And the SQL injection via f-string? On top of this? You've taken a catastrophe and wrapped it in a security hole. GET OUT. Out of my database. Out of my server room. Out.

### Gentle Grandma — SEVERITY: HORRIFIED
Oh sweetheart. Oh dear. Grandma worked on IMS at IBM in Poughkeepsie for thirty-one years and I want you to know we wrote JOINs by hand on green bar paper before you could call a query a query. We had a saying at the shop: "the fastest query is the one you don't send." You, my love, are sending a million of them.

I'm not angry, I'm just... oh, I'm a little angry actually. On the 360/67 we'd have been fired for this by lunchtime. A whole career ended before the pension vested. Do you know what a pension is, dear? It's what you get when you don't write loops like this.

Come sit down. Grandma will make you some tea and we'll talk about LEFT JOIN. It's going to be okay. Shhhh. There, there.

---

## Disaster #2: SELECT * On A 50-Column Table When Only ID Is Needed

**The crime:**
```sql
SELECT * FROM customers_full_profile
WHERE email = 'bob@example.com';
-- we only use result.id
```

### Linus Torvalds — SEVERITY: HIGH
This is the kind of code that makes me want to unsubscribe from the internet. You have a table with fifty columns — which is its own war crime we'll get to later — and you pull down every single byte of it, across the network, through the parser, into the application heap, through serialization, so you can read `.id` and throw the rest into the GC.

If you can't be bothered to type the column name you need, you shouldn't be bothered to write queries. `SELECT id` is seven characters. SEVEN. You typed "SELECT *" which is eight. You actively did more work to be slower.

This isn't laziness. Laziness would be efficient. This is anti-laziness. This is paying extra to get less. I'd revert the commit but I don't want to touch it.

### Shakespeare — SEVERITY: MEDIUM
O, what a wastrel fetcheth all the wares,
When but a single coin would serve the hour!
Fifty columns summoned from their stony crypts,
That one small integer might dance alone.

The network groans beneath thy idle freight,
The parser sighs, the heap doth swell with ghosts
Of fields unread, of blobs unlooked upon —
A banquet hauled across the wire to feed a mouse.

Name thou the column, gentle one, by name,
And let the rest remain where rest is meet.
For greed without a purpose is mere waste,
And waste, good sir, the compiler shall not pardon.

---

## Disaster #3: No Index On Columns Used In WHERE

**The crime:**
```sql
-- orders table: 40 million rows, zero indexes
SELECT * FROM orders
WHERE customer_id = 12345
  AND status = 'pending'
  AND created_at > '2026-01-01';
-- runs every 3 seconds from the dashboard
```

### Gordon Ramsay — SEVERITY: NUCLEAR
FORTY. MILLION. ROWS. And you're doing a full table scan every three seconds. Every THREE seconds. Do you understand what that means? Your disk is SPINNING ITSELF INTO DUST while you sip your oat milk latte.

You've got THREE columns in the WHERE clause — customer_id, status, created_at — and not a single index between them. Not one. It's like running a Michelin kitchen with no knives. Every request is a linear scan through forty million rows. Your query planner is in the corner WEEPING.

`CREATE INDEX`. Two words. Ten seconds. You've had this code in production for EIGHT MONTHS. Your DBA quit. Your cloud bill tripled. And you're still here, still full-scanning, still wondering why the dashboard "feels slow." IT'S NOT SLOW, IT'S DEAD. YOU KILLED IT.

### Gentle Grandma — SEVERITY: HORRIFIED
Oh my stars. Oh dearie me. Grandma needs to sit down. At the bank in '78 we had to justify every index in a formal review — we didn't add them carelessly — but by heavens we *added* them. You, sweetheart, have added *none*.

I remember a young man named Raymond who forgot an index on a customer table and the nightly batch job ran until Tuesday. Tuesday, dear. The job was a Monday job. He cried in the break room. We all cried a little. Then we added the index and went home.

You run this query every three seconds. Every three seconds! That's twenty-eight thousand eight hundred full table scans a day. Grandma did the math on a napkin. Oh honey. Oh no. Please, please, `CREATE INDEX idx_orders_customer_status_date`. Do it for Grandma. Do it for Raymond.

---

## Disaster #4: Storing JSON In A TEXT Column For Fields You Query

**The crime:**
```sql
CREATE TABLE events (
  id BIGSERIAL PRIMARY KEY,
  payload TEXT  -- contains {"user_id": 123, "type": "click", "ts": "..."}
);

SELECT * FROM events
WHERE payload LIKE '%"user_id":123%'
  AND payload LIKE '%"type":"click"%';
```

### Linus Torvalds — SEVERITY: HIGH
You're storing structured data in a TEXT column. Then you're querying it with LIKE. You've reinvented the filesystem, but worse, because at least the filesystem has an inode table. You have nothing. You have a blob. You have a CSV file pretending to be a database.

Postgres has JSONB. It has GIN indexes on JSONB. It has been shipping this for over a decade. You are so far behind the state of the art that the state of the art has forgotten you exist. And you're using LIKE with leading wildcards — which means even the B-tree index you don't have wouldn't help you anyway.

If you're going to ignore every feature the database offers, stop using a database. Write to /dev/null. It's faster and the output is equally useful.

### Shakespeare — SEVERITY: HIGH
Within a TEXT didst thou entomb thy truth,
And cast away the keys that would unlock it.
Now, seeking but one soul among the throng,
Thou sweep'st each character with LIKE's blind broom.

"Percent user_id colon one two three percent" —
A sorcerer's chant, yet sorcery it is not,
For no index shall heed the leading wildcard,
And every row must yield its secret verse.

JSONB waits, with GIN upon its brow,
A crown of indexes, swift and true to call.
Yet thou preferrest strings to spells of schema —
O tragic scribe, refactor ere thou fall.

---

## Disaster #5: Passwords In Plaintext

**The crime:**
```sql
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255),
  password VARCHAR(255)  -- plaintext. yes. really.
);

INSERT INTO users (email, password)
VALUES ('alice@example.com', 'hunter2');
```

### Gordon Ramsay — SEVERITY: NUCLEAR
PLAINTEXT. PASSWORDS. IN 2026. I'm standing in the middle of your database and I can READ every single credential your users ever trusted you with. I can see "hunter2." I can see "password123." I can see someone used their mother's maiden name. IT'S A BUFFET OF BETRAYAL.

bcrypt. argon2. scrypt. PICK ONE. They've been free, open-source, battle-tested for YEARS. It's not even hard. It's `hash(password)` on the way in, `verify(password, hash)` on the way out. A child could do it. A TRAINED PIGEON could do it. But you? YOU chose plaintext.

When this breaches — and it WILL breach, it's not "if," it's "which Tuesday" — every user you have will be phished on every other site they reuse that password on. You haven't built a product. You've built an ARSON FACTORY. Shut it down. Shut it all down. NOW.

### Gentle Grandma — SEVERITY: HORRIFIED
Oh. Oh no. Oh sweetheart, no. Grandma needs to sit down for this one. Grandma needs her pills.

Dearie, when I was at IBM we hashed passwords on the System/370 using DES-based crypt — yes, we did! In the SEVENTIES! Seventies, dear! Before you were born, before your PARENTS were born probably, we knew not to store them like this. And here you are, in the year of our Lord 2026, with a varchar column that says "password" and contains... the password. Just sitting there. Naked. Like a roast in the window at Christmas.

I need you to listen to Grandma very carefully. You are going to add a column called `password_hash`. You are going to install bcrypt. You are going to hash every existing password the next time each user logs in. And you are going to never, ever, *ever* tell anyone at my old IBM office that you did this, because Harold would have a stroke. Harold is 89. He cannot take another stroke.

---

## Disaster #6: Storing Dates As VARCHAR

**The crime:**
```sql
CREATE TABLE invoices (
  id SERIAL,
  due_date VARCHAR(20),  -- "12/3/2025", "2025-3-12", "March 12, 2025", "next tuesday"
  amount VARCHAR(20)     -- "$1,200.00"
);

SELECT * FROM invoices
WHERE due_date < '2026-01-01'
ORDER BY due_date;
-- sorts lexicographically. "12/3/2025" comes before "2/1/2026". good luck.
```

### Linus Torvalds — SEVERITY: HIGH
Dates as VARCHAR. Money as VARCHAR. You've taken two of the four things databases are specifically good at — typed comparison, typed arithmetic — and thrown them in the bin. What's next? IP addresses as JSON? Booleans as enum('y','n','maybe')?

The lexicographic sort on mixed date formats is the funniest part. "12/3/2025" sorts before "2025-01-01" which sorts before "March 12." Your "ORDER BY due_date" returns a dadaist poem. It's performance art. The CFO opens the report and sees invoices due in ancient Greek.

Pick DATE. Pick TIMESTAMP. Pick NUMERIC for money. These types exist for a reason. The reason is people like you.

### Shakespeare — SEVERITY: HIGH
What fool hath writ the hours in common speech,
And bound the coin in letters, not in number?
"Twelfth March" and "March twelfth" and "three-twelve"
All jostle in one column, none the wiser.

The ORDER BY, poor wretch, knows naught of time —
It sorts by alphabet, as magpies sort the shiny —
And so "December" creeps before "January,"
While "next Tuesday" wanders lost and weeping.

Thy DATE awaits thee, patient as the grave,
Thy NUMERIC, steadfast as the northern star.
Cast off the VARCHAR mask from honest types,
And let the database be what it was born to be.

---

## Disaster #7: LIKE '%search%' On A 10M Row Table, No Full-Text Index

**The crime:**
```sql
-- products table: 10M rows, no full-text, no trigram, nothing
SELECT * FROM products
WHERE name LIKE '%wireless%'
   OR description LIKE '%wireless%'
   OR tags LIKE '%wireless%';
-- wired to the search bar, fires on every keystroke
```

### Gordon Ramsay — SEVERITY: HIGH
A leading percent. On a LIKE. On TEN MILLION rows. On every keystroke. I want you to walk to the server room and apologize to the hardware IN PERSON. Tell the SSD you're sorry. Tell the RAM you're sorry. They don't deserve this.

OR across THREE columns, each doing a full scan, because you've given the planner NO way to use an index. A leading wildcard nukes B-trees dead. You're searching ten million rows three times per keypress. A user types "wireless" — that's eight scans. THIRTY MILLION row reads per word typed.

Postgres has `pg_trgm`. It has tsvector. It has GIN. MySQL has FULLTEXT. They're FREE. They're BUILT IN. You just didn't read the docs. You are the reason databases have alert thresholds.

### Gentle Grandma — SEVERITY: HIGH
Oh honeylamb. At IBM we had a saying: "if you're searching, you should have an index; if you don't, you should be ashamed." It rhymed in German. The original was catchier.

Every keystroke, dearie. Every single one. A child types "wireless" with their sticky little fingers and your poor database scans thirty million rows before they're done spelling it. It's like asking the library to read every book each time you want to find "Moby Dick." The librarian would cry, sweetheart. Grandma would cry.

Full-text search is a real thing! It's been a real thing since — goodness — since before I retired, and I retired in 2011. Please, please look up `pg_trgm` or `tsvector` tonight. Grandma will knit you a scarf. Just fix the search.

---

## Disaster #8: Hardcoded Credentials In ORM Config

**The crime:**
```python
# settings.py, committed to main branch on public GitHub
DATABASE_URL = "postgres://admin:P@ssw0rd2024!@prod-db.company.com:5432/customers"

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'USER': 'admin',
        'PASSWORD': 'P@ssw0rd2024!',
        'HOST': 'prod-db.company.com',
    }
}
```

### Gordon Ramsay — SEVERITY: NUCLEAR
IT'S ON GITHUB. IT'S PUBLIC. The production password. The production hostname. The ADMIN USER. You've handed every script kiddie on earth a map, a key, and a handwritten invitation. "Please," the commit says, "take our customer data. We insist."

`P@ssw0rd2024!` — and let me guess, that exclamation point is what makes it "secure." It satisfied the complexity rule. You put your complexity in the password instead of, oh I don't know, a SECRET MANAGER. AWS Secrets Manager. Vault. `.env` files with `.gitignore`. ANYTHING. A postcard would be more secure than this.

I want that file scrubbed. I want the git history rewritten. I want the password rotated. I want every key this admin user touched audited. AND I WANT IT DONE YESTERDAY. Move. MOVE!

### Linus Torvalds — SEVERITY: NUCLEAR
I'm not even going to dignify this with a long rant. You committed production credentials to a repository. Public or private, it doesn't matter — you lost control of those credentials the moment they hit `git add`. Every developer, every CI runner, every forked copy, every stale laptop that ever pulled this branch is now a credential leak vector.

The fix is not "rotate the password." The fix is "rotate the password, rewrite the history, assume compromise, audit the logs, and never do this again." Environment variables are a solved problem. `.env` files are a solved problem. Secret managers are a solved problem. You unsolved a solved problem.

Git does not forget. Ever. Your `P@ssw0rd2024!` lives forever in the reflog of every clone on earth. That's your legacy now.

---

## Disaster #9: No Foreign Key Constraints — "We Handle It In App Code"

**The crime:**
```sql
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INT,        -- "references users.id" (vibes only)
  product_id INT,     -- "references products.id" (trust me bro)
  shipping_addr_id INT
);
-- no FKs. "the ORM handles it." the ORM does not, in fact, handle it.
```

### Linus Torvalds — SEVERITY: HIGH
"We handle it in app code." I've been hearing this sentence for thirty years and I have never — not once — seen it survive contact with production. Some batch job runs with the wrong transaction isolation, some migration forgets a step, some junior dev does a manual DELETE in the REPL, and suddenly you have orders for users that don't exist, pointing at products that don't exist, shipping to addresses that don't exist.

The database has a feature. It is called the foreign key constraint. It has existed since the 1970s. It is free. It is enforced by the storage engine, not by your spaghetti pile of service methods. It works even when your app code doesn't run, which — let me remind you — is most of the time, because cron jobs and DBAs and ad-hoc scripts all exist.

"We handle it in app code" means "we have orphan rows and we don't know it yet." You will learn. You will learn the hard way.

### Shakespeare — SEVERITY: HIGH
"The app shall guard the gate," the architect swore,
And set no lock upon the cellar door.
The schema, naked, trusts in human hand,
And human hands, alas, are frail as sand.

A midnight script doth DELETE without care,
A migration slips, a transaction tears —
And lo! ten thousand orders, bastard-born,
Point to no user, from no product torn.

The FOREIGN KEY, that faithful iron ring,
Was spurned in favor of the app's soft string.
Now orphan rows do haunt the weary cursor,
And every JOIN returns a phantom nurser.

---

## Disaster #10: DELETE FROM Users With No WHERE Clause (In A Migration)

**The crime:**
```sql
-- migration_047_cleanup_inactive_users.sql
BEGIN;

DELETE FROM users;
-- TODO: add WHERE last_login < '2024-01-01'
-- (shipped to prod, ran on master)

COMMIT;
```

### Gordon Ramsay — SEVERITY: NUCLEAR
A. TODO. IN. A. MIGRATION. You left a TODO comment NEXT to a `DELETE FROM users`. AND YOU COMMITTED IT. AND IT RAN. ON PRODUCTION. Every user. Every account. Every paying customer. GONE. Because you forgot to type seven words after the DELETE.

A migration is meant to be ATOMIC. DELIBERATE. REVIEWED. You've turned it into a Post-It note. "Hey future me, add a WHERE clause." Future you didn't read it. Future you was on vacation. Past you shipped it. The database did exactly what you asked. It always does.

And you wrapped it in a TRANSACTION as if COMMIT was going to save you. COMMIT is the opposite of saving you. COMMIT is what made it PERMANENT. I've seen restaurants survive kitchen fires with more data left over than your users table. Get. The. Backup. NOW.

### Gentle Grandma — SEVERITY: HORRIFIED
Oh. Oh dear God in heaven. Oh my stars. Grandma is going to need to lie down, and also possibly call Harold, because Harold needs to hear this to believe it.

At IBM, dearie, we had a rule: no DELETE without a WHERE, EVER, not even in development. We had a rule: every migration reviewed by two humans. We had a rule: production writes go through change control. We had *so many rules*, sweetheart, and every single one of them was written in blood — someone, somewhere, once did what you just did, and we wrote a rule so it would never happen again. And here you are. Doing it again. With a TODO comment. A TODO COMMENT, dear.

Now listen to me. You will restore from backup. You will write a post-mortem. You will add `WHERE` to every DELETE template in your editor snippets. And you will never, ever write "TODO" next to a destructive statement again. Grandma loves you. Grandma is very disappointed. Grandma is also calling your manager. I'm sorry, dear, it has to be done.

---
