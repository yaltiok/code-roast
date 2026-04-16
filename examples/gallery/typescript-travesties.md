# TypeScript Travesties 🔷

## Travesty #1: `as any` Everywhere

**The crime:**
```typescript
const user = getUser() as any;
const response = (await fetch(url)).json() as any;
const config = JSON.parse(raw) as any;
(window as any).myGlobal = user as any;
```

### Gordon Ramsay (savage)
WHAT ARE YOU DOING?! You've taken a Michelin-starred type system and DUMPED it in the bin! `as any`?! That's not TypeScript, that's JavaScript in a bloody TRENCHCOAT pretending to be grown-up! Every `as any` is another customer walking out of my restaurant, you donut!

Look at this kitchen! FOUR `as any` casts in FOUR LINES! You've managed to disable the single feature you're paying Microsoft to give you! This is like buying a Ferrari and towing it behind a bicycle! GET OUT OF MY CODEBASE!

### Gentle Grandma (passive-aggressive)
Oh sweetheart, I see you've found the `any` keyword. That's... certainly one way to write code. Back at IBM we called this "job security" because someone would always have to come back and fix it. Usually at 2am. Usually sobbing.

I'm sure you had your reasons, dear. Maybe the types were "too hard" or the deadline was "too tight". Don't you worry. I've made a little note in my journal so when production goes down next Tuesday, we'll all know exactly where to look. No pressure though. It's only money.

---

## Travesty #2: `// @ts-ignore` On Every Other Line

**The crime:**
```typescript
// @ts-ignore
const result = processData(input);
// @ts-ignore
result.nested.deeply.nested.property = "hello";
// @ts-ignore
return result.something();
```

### Linus Torvalds (savage)
This is not programming. This is vandalism with a keyboard. You have a compiler. It is telling you, in plain English, that your code is broken. Your response is to tape over the check-engine light and keep driving into the ditch.

Every `@ts-ignore` is you publicly admitting you don't understand your own code. Not once. Three times in six lines. If you cannot be bothered to fix it, at least be bothered to use `@ts-expect-error` so the thing screams when you finally stumble into a correct type by accident. This is the kind of garbage that makes me hate Tuesdays.

### Shakespeare (medium)
Hark! What comment through yonder codebase breaks? 'Tis `@ts-ignore`, and the compiler is the sun, which thou hast cruelly blinded with a rag! Thrice in six short lines thou dost silence the oracle, preferring ignorance to counsel.

Forsooth, good coder, this is no fix but merely a shroud laid upon the corpse of thy logic. The bug, like Banquo's ghost, shall return at the feast of production, and no `@ts-ignore` shall banish him then.

---

## Travesty #3: Casting Without Narrowing

**The crime:**
```typescript
function greet(x: unknown) {
  console.log((x as User).name.toUpperCase());
}
```

### Gordon Ramsay (medium)
You've just served raw chicken and called it confit! `x` is `unknown`! UNKNOWN! That means the entire BLOODY UNIVERSE, mate! Could be a number. Could be `null`. Could be a goat. And you've slapped a `User` sticker on it and shoved it out the pass!

One call with `x = undefined` and your `.name.toUpperCase()` explodes in production like a microwaved egg. Type-check it. Narrow it. `if (isUser(x))`. It's not hard, you muppet!

### Gentle Grandma (gentle)
Oh honey, a little type assertion there. That's sweet. You just... told TypeScript it was a User. Without, you know, *checking*. Like putting a "FRAGILE" sticker on a box and hoping the truck drivers respect your wishes.

In my day, we had something called a type guard. It was a tiny little `if` statement. Very polite. It asked before it assumed. But I'm sure your way works too, dear. Until Tuesday.

---

## Travesty #4: Using `Object` or `Function` as Type

**The crime:**
```typescript
function processItem(item: Object, callback: Function): Object {
  return callback(item);
}
```

### Linus Torvalds (medium)
`Object` and `Function`. The two most useless types the standard library exposes, and you've picked both in the same function signature. Impressive commitment to uselessness.

`Object` matches literally everything that isn't `null` or `undefined`. `Function` accepts any callable with any signature returning anything. You have written a function whose type information is indistinguishable from having written no type information at all. Use `object`, `Record<string, unknown>`, or an actual signature like `(item: T) => U`. This is not a stylistic preference. This is TypeScript 101.

### Shakespeare (gentle)
Good sir, thou hast summoned the ghosts of JavaScript past! `Object` and `Function`, capitalized like noble titles, yet possessing no substance. They are the painted scenery of a stage play, masquerading as true castle walls.

Lowercase `object` is what thou dost seek, or better still, a typed signature that speaks plainly of its intent. Let thy types describe the shape of things, not merely gesture vaguely toward the kingdom of all possible values.

---

## Travesty #5: Optional Chain Then Non-Null Assert

**The crime:**
```typescript
const name = user?.profile?.name!.toUpperCase();
```

### Gordon Ramsay (savage)
WHAT IS THIS?! You've asked the chef "is there chicken?" and then screamed "THERE IS DEFINITELY CHICKEN!" in the same breath! The `?.` says "might be nothing" and the `!` says "DEFINITELY SOMETHING"! PICK ONE, YOU DOUGHNUT!

This is schizophrenic code! If `user` is undefined, `user?.profile` is undefined, `.name` is undefined, and then `!` lies about it and `.toUpperCase()` blows up the kitchen! You've written a bug with extra punctuation! GET OUT!

### Gentle Grandma (passive-aggressive)
Well, isn't that... interesting. You asked if `user` exists, you asked if `profile` exists, and then at the very last second you decided to trust the universe with a little exclamation point. So confident. So bold.

I do hope it works out for you. Back at IBM we had a saying: "the runtime does not care about your feelings". But you do you, dear. I'll just be over here with my cup of tea, waiting for the stack trace.

---

## Travesty #6: Enums With Duplicate Values

**The crime:**
```typescript
enum Status {
  Active = 1,
  Pending = 1,
  Archived = 2,
  Deleted = 2,
}
```

### Linus Torvalds (savage)
An enum is supposed to give distinct names to distinct values. You have given distinct names to the same value. Twice. This is not an enum. This is a broken dictionary with extra typing.

`Status.Active === Status.Pending` now returns `true`. Every switch statement over this enum is quietly wrong. Every database query mapping this is quietly wrong. You have introduced four bugs in four lines and labeled them as a feature. Delete this file. Delete the branch. Possibly delete the repository.

### Shakespeare (medium)
O monstrous creation! Thou hast given two children the selfsame name, and now Active and Pending walk the earth as twins indistinguishable! When thy code doth ask "art thou Active?", Pending shall answer "aye" and none shall know the difference.

An enum, good coder, is a covenant: each name, a unique value. Thou hast broken the covenant in the very act of making it. This is not code. This is a riddle with consequences.

---

## Travesty #7: Declaration File Lies

**The crime:**
```typescript
// types.d.ts
declare function fetchUser(id: string): User;

// actual runtime
function fetchUser(id) {
  return fetch(`/api/users/${id}`).then(r => r.json()); // returns Promise<User>
}
```

### Gordon Ramsay (savage)
YOU'VE PUT "BEEF" ON THE MENU AND YOU'RE SERVING HORSE! The declaration says `User`, the function returns `Promise<User>`! That's not a type mismatch, that's FRAUD!

Every single caller thinks they're getting a user and they're getting a BLOODY PROMISE! They'll call `.name` on it and it'll be `undefined` and they'll spend THREE HOURS in the debugger while you sip coffee like nothing's wrong! This is how CAREERS END, you clown!

### Gentle Grandma (passive-aggressive)
Oh my. A declaration file. How... aspirational. You've told TypeScript what you *wished* the function did, rather than what it actually does. That's a very creative approach to types, dear.

At IBM we had a word for declaration files that don't match runtime. We called them "lies". But that's such a harsh word. Let's call them "narratives". Your narrative is that `fetchUser` returns a `User`. The reality is it returns a `Promise`. I'm sure the two will reconcile eventually. Maybe in therapy.

---

## Travesty #8: Generics That Don't Constrain

**The crime:**
```typescript
function getProperty<T>(obj: T, key: string): any {
  return (obj as any)[key];
}
```

### Linus Torvalds (savage)
You have written a generic function. Congratulations. It is completely useless. `T` is never constrained, never returned, never referenced except to be immediately cast away with `as any`. You might as well have not typed this function at all. In fact, you didn't.

This is cargo-cult TypeScript. You saw `<T>` in a tutorial and sprinkled it on top like parmesan. The correct signature is `function getProperty<T, K extends keyof T>(obj: T, key: K): T[K]`. That is the signature you will never write because you do not care. But I am telling you anyway, for the next person who has to read this.

### Shakespeare (medium)
Behold, a generic parameter `T`, wandering the function signature like a ghost with no purpose! It constrains nothing, returns nothing, and is immediately betrayed by `as any` — the Judas of type assertions.

Thou hast invoked the power of generics and then smothered it in the cradle. `keyof T` was thy rightful path, good coder. A generic without constraint is but a decoration, and `any` is the opposite of craftsmanship.

---

## Travesty #9: Optional Props Treated as Required

**The crime:**
```typescript
interface User {
  name?: string;
  email?: string;
  age?: number;
}

function displayUser(u: User) {
  return `${u.name.toUpperCase()} <${u.email.toLowerCase()}> (${u.age + 1})`;
}
```

### Gordon Ramsay (savage)
YOU'VE MARKED EVERYTHING OPTIONAL AND THEN USED IT LIKE IT'S MANDATORY! That's like putting "MAY CONTAIN PEANUTS" on a jar of peanuts and then acting SHOCKED when someone has a reaction!

`name?` means IT MIGHT NOT EXIST! And you're calling `.toUpperCase()` on it?! `age + 1` when `age` might be `undefined`?! That's `NaN`, you muppet! Three properties, three runtime bombs waiting for a real user to trigger them! GET! OUT!

### Gentle Grandma (gentle)
Oh dear, sweetie. You made everything optional. That means "might be there, might not". And then you... used all of them as if they were definitely there. That's a bit of a mixed message, don't you think?

If they're required, take the question marks off. If they're optional, give them defaults or check for them. It's really one or the other, pumpkin. You can't have it both ways. Well, you *can*, but the computer gets very cross about it later.

---

## Travesty #10: The `[key: string]: any` Catch-All

**The crime:**
```typescript
type User = { [key: string]: any };

const u: User = getUser();
u.naem = "Alice"; // typo
u.email.toUpperCase(); // could be anything
```

### Linus Torvalds (medium)
You have defined a type called `User` that accepts any string key with any value. This is not a type. This is a JavaScript object with a name tag. TypeScript now lets you write `u.naem` without complaint. Congratulations on unshipping autocomplete.

If you know the shape, write the shape: `{ name: string; email: string; age: number }`. If you don't know the shape, use `unknown` values and narrow at the boundary. `any` as a value type plus `string` as a key type is the most expensive way to write untyped code I have ever seen.

### Shakespeare (gentle)
Good coder, thou hast defined a `User` that is no user at all — a vessel that accepts any key, any value, any nonsense. Thy compiler, once a vigilant sentinel, now slumbers at his post, for thou hast told him that all is permitted.

`u.naem` passes his gaze, though 'tis clearly a typo of `name`. Each such silent acceptance is a wound to thy future self. Define the shape, good friend. A type that accepts all things distinguishes nothing.

---

## Travesty #11: `string` Instead of Union Literal

**The crime:**
```typescript
interface Task {
  status: string; // "active" | "pending" | "done" would be nice
  priority: string; // "low" | "medium" | "high" also nice
}

task.status = "actve"; // typo, compiler doesn't care
```

### Gordon Ramsay (medium)
You've got THREE valid statuses and you typed it as `string`?! That's the whole universe of strings, mate! "actve", "banana", "my cat's name"! All valid! All accepted! All WRONG!

A union type `'active' | 'pending' | 'done'` would catch the typo at compile time. But no. You went with `string` because it was EASIER to type. Well guess what's NOT easier? Debugging why half your tasks are stuck in state "actve" in production! USE THE UNION, you donut!

### Gentle Grandma (passive-aggressive)
Oh, `string`. Such a... *flexible* choice. You've allowed your status field to be any string in the entire language. "active". "pending". "done". "please fire me". All equally valid, according to your types.

I noticed you wrote "actve" just now. Missing the `i`. TypeScript didn't mention it, of course, because you told it not to care. But I noticed, dear. I always notice. The database will notice too, eventually, when the dashboard shows zero active tasks and everyone wonders why.

---

## Travesty #12: `Promise<any>` Return Types

**The crime:**
```typescript
async function fetchUser(id: string): Promise<any> {
  const res = await fetch(`/api/users/${id}`);
  return res.json();
}

const user = await fetchUser("123");
user.somethingThatDoesntExist.chainedCalls.whatever(); // all fine, apparently
```

### Linus Torvalds (savage)
`Promise<any>`. You have managed to write an async function whose return type conveys less information than no return type at all. TypeScript would have inferred something more useful if you had simply said nothing.

Every caller of `fetchUser` now operates in an `any`-zone, chaining property access into the void. One mistyped key and your UI renders "undefined" to a real user. Use `Promise<User>`. Use `Promise<unknown>` and validate. Use `z.infer<typeof UserSchema>`. Use anything except this. `Promise<any>` is a surrender disguised as a type annotation.

### Shakespeare (savage)
O foulest of return signatures! `Promise<any>` — a vow to deliver *something*, but what that something be, the author knoweth not, and the caller shall divine by catastrophe alone! Thou hast taken the async function, a marvel of modern contrivance, and stripped it bare of all meaning.

Every `.then` that follows is a leap of faith into an unlit well. Every destructuring is a gamble with the runtime gods. Fie upon thee, and fie upon thy `any`! Let thy Promises speak the truth of what they carry, lest they become mere envelopes of deceit sealing unknown curses within!

---
