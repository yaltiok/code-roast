# Architecture Astronauts 🚀

## Launch #1: AbstractFactoryBuilderFactory

**The crime:**
```java
public interface IAbstractFactoryBuilderFactoryProvider<T extends IFactoryBuilder<? extends IFactory<?>>> {
    IAbstractFactoryBuilderFactory<T> createAbstractFactoryBuilderFactory(
        IAbstractFactoryBuilderFactoryConfig config
    );
}

public class DefaultAbstractFactoryBuilderFactoryProviderImpl
    implements IAbstractFactoryBuilderFactoryProvider<UserFactoryBuilder> {
    // 400 lines of delegation
}
```

### Gordon Ramsay (CRITICAL)
WHAT. IS. THIS. You've made a factory, to build a factory, to make a factory, to eventually — if we're very lucky — produce a User object. This is the Russian nesting doll of software. It's turtles all the way down except every turtle is screaming.

I asked for a User. A USER. One struct. One line. Instead you handed me a seven-course tasting menu where every course is a menu describing the next course. By the time your code actually instantiates anything the heat death of the universe has already been queued in a build pipeline. Rip it up. Start again. Write `new User()` like a normal human being.

### Shakespeare (HIGH)
O, what tangled webs we weave, when first we practice to abstract! Thou hast built a cathedral of providers, a Babel of builders, and at its summit — behold — a single, trembling User, clutching a name and an email, weeping softly for the simpler life it was promised.

Methinks the Bard himself would tire of naming thy classes, for each one doth contain the word "Factory" thrice, and meaning not at all. Strike the scaffold. Let the User stand plainly, as Nature intended, untroubled by the ghosts of patterns past.

---

## Launch #2: Strategy pattern for adding two numbers

**The crime:**
```typescript
interface AdditionStrategy {
  add(a: number, b: number): number;
}

class DefaultAdditionStrategy implements AdditionStrategy {
  add(a: number, b: number): number { return a + b; }
}

class AdditionContext {
  constructor(private strategy: AdditionStrategy) {}
  execute(a: number, b: number): number {
    return this.strategy.add(a, b);
  }
}

const ctx = new AdditionContext(new DefaultAdditionStrategy());
const result = ctx.execute(2, 3);
```

### Linus Torvalds (CRITICAL)
This is the kind of code that makes me want to un-invent git just so you can't check it in. You took `2 + 3`, a thing a calculator from 1974 can do in hardware, and wrapped it in three classes, an interface, and a "context" — because apparently addition is a geopolitical situation now.

There's exactly one strategy. ONE. The "default" one. You've implemented a pattern whose entire purpose is variation, with zero variation. That's not abstraction, that's cosplay. Delete it. Use `+`. It's been in the language since before you were born and it hasn't needed a context object yet.

### Gentle Grandma (MEDIUM)
Oh sweetheart, come sit down, grandma made cookies. Now, I was just reading your code — I don't understand most of it, but I do know my numbers. And honey, when I add two eggs and three eggs I just… add them. I don't call a strategy. I don't have a context. I just count the eggs.

I'm sure you had a lovely reason, pumpkin. Maybe your teacher taught you about patterns and you got excited, and that's wonderful. But next time you want to add, just add. Grandma believes in you. Also eat something, you're too thin.

---

## Launch #3: Generic `<T extends BaseEntity>` chain for a simple User

**The crime:**
```typescript
abstract class BaseEntity<ID extends Serializable> { /* ... */ }
abstract class AuditableEntity<ID extends Serializable> extends BaseEntity<ID> { /* ... */ }
abstract class SoftDeletableEntity<ID extends Serializable> extends AuditableEntity<ID> { /* ... */ }
abstract class VersionedEntity<ID extends Serializable> extends SoftDeletableEntity<ID> { /* ... */ }
abstract class TenantAwareEntity<ID extends Serializable> extends VersionedEntity<ID> { /* ... */ }

class User extends TenantAwareEntity<UUID> {
  name: string;
  email: string;
}
```

### Gordon Ramsay (HIGH)
A User. It's a User. It has a name. It has an email. That's it. That's the whole dish. And you've buried it under five layers of abstract inheritance like it's trying to escape through a prison tunnel.

Your User is now tenant-aware, version-aware, soft-deletable, auditable, and generic over some mystery ID type — for an app that has one tenant, no versions, hard deletes everything, and has never been audited because nobody can FIND the actual business logic under this skyscraper of abstraction. Flatten it. Put `name` and `email` on a class. Stop punishing your colleagues.

### Shakespeare (MEDIUM)
Lo, here stands User — a humble soul of name and letter — now robed in five inheritances like a king who hath forgotten he is merely a clerk. Each parent class doth whisper noble intent — audit, version, tenancy — yet not a single one hath ever been summoned in anger.

'Tis speculative royalty, a crown fashioned for a head that hath not grown. Strip him bare. Let User be User, and when the realm doth truly demand a tenant, then — and only then — shall we dress him for the occasion.

---

## Launch #4: 6 microservices for a todo app

**The crime:**
```yaml
services:
  todo-auth-service:        # handles login
  todo-user-service:        # stores users
  todo-list-service:        # stores lists
  todo-item-service:        # stores items
  todo-notification-service: # sends emails nobody reads
  todo-gateway-service:     # routes to the other 5
```

### Linus Torvalds (CRITICAL)
Six services. Six. For a todo app. You could fit this entire application in a single SQLite file and a 200-line Python script, and it would be faster, more reliable, and wouldn't require a Kubernetes cluster to remind you to buy milk.

You've introduced distributed-systems failure modes — network partitions, eventual consistency, cascading timeouts, half the team learning about circuit breakers — so that "add todo" can traverse four services before hitting a database. Congratulations, you've turned a for-loop into a Byzantine fault tolerance problem. This isn't architecture. This is a resume.

### Gentle Grandma (HIGH)
Oh my, six little services all talking to each other just to remember the groceries? That sounds so tiring for them. In my day we wrote things down on a pad by the phone. The pad didn't need a gateway.

Sweetie, I think you might be making the computer do a lot of running around. Grandma gets dizzy just reading the diagram. Maybe — and I say this with love — one little program could do all of it, and then the notification one wouldn't have to email the gateway to ask the user service what your name is. That poor little service. Let it rest.

---

## Launch #5: Event sourcing for a config setting

**The crime:**
```typescript
class ThemeChangedEvent {
  constructor(
    public readonly aggregateId: string,
    public readonly oldTheme: Theme,
    public readonly newTheme: Theme,
    public readonly timestamp: Date,
    public readonly version: number,
    public readonly causationId: string,
    public readonly correlationId: string,
  ) {}
}

// to read current theme: replay every event since 2019
const theme = await eventStore
  .getEvents('user-settings', userId)
  .reduce(themeReducer, DEFAULT_THEME);
```

### Gordon Ramsay (HIGH)
Event sourcing. For a theme toggle. Dark mode and light mode. Two values. TWO. And to find out which one the user picked, you replay three years of their entire settings history like it's a war crimes tribunal.

"Your honour, on the 14th of March at 09:42:13 UTC, the defendant switched to dark mode. Then back. Then dark again. Then light for four seconds. Then dark." Nobody cares. It's a boolean. Store the boolean. When they change it, overwrite the boolean. That's the whole feature. Stop auditing people's aesthetic preferences like they're laundering money.

### Shakespeare (MEDIUM)
Hark! A chronicle most grand hath been composed — not of kings, nor wars, nor love's sweet ruin — but of one user, toggling darkness unto light, and light unto darkness, across the quiet years of their idle tinkering.

Each flick of the switch, immortalized; each fleeting whim, notarized with correlation ID. Wouldst thou truly know the present theme? Then summon the full saga from the vaults, and let the reducer march through every mood the user hath ever harbored. Methinks a single column named `theme` would suffice, and save the scribes much grief.

---

## Launch #6: Every class implements an interface of one method

**The crime:**
```java
public interface IUserGreeter { String greet(User u); }
public class UserGreeter implements IUserGreeter {
  public String greet(User u) { return "Hello, " + u.getName(); }
}

public interface IEmailFormatter { String format(String s); }
public class EmailFormatter implements IEmailFormatter { /* ... */ }

public interface IButtonClicker { void click(); }
// 400 more of these
```

### Linus Torvalds (HIGH)
There is exactly one implementation of `IUserGreeter`. It's called `UserGreeter`. Shocking twist. And yet you've duplicated the signature into an interface "for testability" — as if the real `UserGreeter` can't be mocked, as if every class in existence deserves a ceremonial twin prefixed with `I`.

You're not designing for flexibility. You're designing for the ghost of a second implementation that will never arrive. Every file doubled, every navigation click now hits the interface first, and when someone actually needs to read what `greet` does, they get "it greets — see implementation." You are the reason IDEs have a "go to implementation" shortcut.

### Gentle Grandma (LOW)
Oh honey, you've got two of everything! One that says what it does, and one that actually does it. Like when your grandfather would write the shopping list twice so he could lose both copies. It's very thorough, dear.

But listen — when there's only one baker in town, you don't need a sign saying "this is where the baker might be." You just walk into the bakery. Maybe some of these little interface friends could just go take a nap, and the real classes could do their jobs in peace. They look tired, sugar.

---

## Launch #7: Manager → Handler → Processor → Executor chain

**The crime:**
```typescript
class UserRegistrationManager {
  constructor(private handler: UserRegistrationHandler) {}
  manage(req: Req) { return this.handler.handle(req); }
}
class UserRegistrationHandler {
  constructor(private processor: UserRegistrationProcessor) {}
  handle(req: Req) { return this.processor.process(req); }
}
class UserRegistrationProcessor {
  constructor(private executor: UserRegistrationExecutor) {}
  process(req: Req) { return this.executor.execute(req); }
}
class UserRegistrationExecutor {
  execute(req: Req) { return db.users.insert(req); } // finally
}
```

### Gordon Ramsay (CRITICAL)
Four classes. FOUR. To insert one row. Manager calls Handler, Handler calls Processor, Processor calls Executor, and at the bottom of this corporate org chart is a single `INSERT`. You've built a middle-management simulator.

None of these classes DO anything. They pass the request along and take credit. It's a relay race where every runner is just handing the baton to the next runner in the same room. Fire three of them. Keep the one that actually talks to the database. Rename it `registerUser`. Ship it. Go outside.

### Shakespeare (HIGH)
Behold the court of the Request! First greeted by the Manager, most stately; then handed unto the Handler, most dutiful; then processed by the Processor, most thorough; and at long last executed by the Executor, who — surprise most mild — merely doth what any clerk could have done in line the first.

Four nobles bow, four nobles pass the scroll, and the scroll itself is unchanged. Methinks thy hierarchy serves only itself, a pageant of titles with no deed beneath. Dismiss the court. One honest scribe shall do.

---

## Launch #8: Custom ORM on top of Sequelize

**The crime:**
```typescript
class CustomRepository<T> {
  constructor(private model: SequelizeModel<T>) {}

  async findMagic(criteria: MagicCriteria): Promise<T[]> {
    // 600 lines translating our custom DSL into Sequelize,
    // which then translates into SQL,
    // which is what you wanted in the first place.
    return this.model.findAll(this.translateMagic(criteria));
  }
}
```

### Linus Torvalds (CRITICAL)
You wrapped an ORM in an ORM. Sequelize already abstracts SQL. You've now abstracted the abstraction. The abstraction's abstraction. Every query now passes through two translation layers, each lossy, each undocumented, each maintained by someone who quit.

And of course your "magic criteria" DSL supports 40% of what Sequelize supports, and 0% of what actual SQL supports, so every non-trivial query becomes a bug report that ends with someone dropping to raw Sequelize anyway — at which point, remind me, what did the custom ORM do? Right. It slowed you down and hid the stack traces. Delete it. Use Sequelize. Or don't use Sequelize. But pick one layer of lies and stick with it.

### Gentle Grandma (MEDIUM)
Oh dear, you've put the computer database inside another computer database, inside another one. It's like when I put leftovers in Tupperware, inside a bigger Tupperware, inside a grocery bag. By the time I find the meatloaf, it's Thursday.

Sweetpea, I think the library you're already using does the thing you built on top of it. And now when something goes wrong, you have to open two Tupperwares before you even see the meatloaf. Maybe just let the nice library do its job. Trust it. It went to school for this.

---

## Launch #9: Redux for a form with 3 fields

**The crime:**
```typescript
// actions.ts
export const SET_NAME = 'form/SET_NAME';
export const SET_EMAIL = 'form/SET_EMAIL';
export const SET_AGE = 'form/SET_AGE';

// action-creators.ts, reducers.ts, selectors.ts, thunks.ts,
// form.slice.ts, form.saga.ts, form.types.ts, store.ts,
// provider.tsx, hooks.ts ...

// component.tsx
const name = useSelector(selectName);
const dispatch = useDispatch();
<input onChange={e => dispatch(setName(e.target.value))} />
```

### Gordon Ramsay (HIGH)
Three fields. Name, email, age. That's a business card. And you've wired it up to a global state store with actions, reducers, selectors, thunks, sagas, and a provider at the root of your app — so that when the user types the letter "A," it travels through seven files before it appears on screen.

`useState`. TWO words. That's all this needed. Instead you've built a Rube Goldberg machine where pressing a key dispatches an action that gets intercepted by middleware that logs to devtools that nobody's looking at. Strip it out. This form could be done with a hook and 10 lines. Your component is drowning in boilerplate and it hasn't even validated an email yet.

### Gentle Grandma (MEDIUM)
Oh honey, this is just a little form for a name, an email, and an age. Back in my day, I'd write those on an index card and stick it to the fridge. The fridge didn't have actions and reducers, dear. It just had a magnet.

You've got so many files for such a small thing. It's like using a filing cabinet to store one grocery receipt. I'm sure somebody told you this was the right way, and they meant well, but sometimes the simple tool is the right tool. Try `useState`, pumpkin. It's like a sticky note. You'll feel so much lighter.

---

## Launch #10: Kubernetes for a weekend project

**The crime:**
```yaml
# infra/k8s/
# - deployment.yaml
# - service.yaml
# - ingress.yaml
# - hpa.yaml
# - configmap.yaml
# - secret.yaml
# - network-policy.yaml
# - pdb.yaml
# - service-monitor.yaml
# - cert-issuer.yaml
# - terraform/eks/...
#
# Serves: one static blog with 3 posts, 12 readers/month
```

### Linus Torvalds (CRITICAL)
You spun up a Kubernetes cluster, wrote eleven YAML files, configured an ingress with TLS, set up a horizontal pod autoscaler, and paid a cloud provider $87 a month — so that twelve people can read your blog post about productivity. The autoscaler has never scaled. There is nothing to scale. There are three posts.

A static site generator and any free host would've done this in under a minute, for zero dollars, with zero operational burden. Instead you've built yourself a second job babysitting a control plane for an audience that could fit in a minivan. Tear it down. Put the HTML on a CDN. Go write the fourth post.

### Shakespeare (HIGH)
O mighty orchestrator, commander of pods, steward of clusters — dost thou know what thou dost guard? Three humble essays and a photograph of a cat. For this, thou hast summoned etcd, persuaded Helm, befriended Prometheus, and pledged thy weekends unto the god of YAML.

The autoscaler stands sentry over an empire of twelve subscribers, poised to conjure replicas should the horde descend — a horde that shall never come. Lay down thy kubectl, gentle architect. A single humble file, hosted freely upon the winds, would serve thy readership with grace, and return unto thee the Saturdays thou hast so solemnly surrendered.

---
