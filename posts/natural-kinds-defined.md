---
title: Natural Kinds Defined
date: 2021-07-05
---

This is part 2 of the series on natural kinds. The previous post is [here](./intro-to-natural-kinds.html).

### Baby Steps
We expect natural kinds to be special collections of things out in the world, with "world" interpreted pretty much however you like. This could be physically-existing things, or a mathematical universe, or a combination of the two for the mathematical realists. I'll leave that decision to the reader, and simply call the aggregate of all "things in the world", or objects, the collection $\mathbb{O}$. Each object in $\mathbb{O}$ comes with a corresponding collection of properties, and we can call the totality of all such properties the collection $\mathbb{P}$.

Each object $o \in \mathbb{O}$ has one or more properties $p \in \mathbb{P}$ that hold of it, and conversely, each property $p \in \mathbb{P}$ is related to one or more objects. We'll call this relation $\Phi = \mathbb{O} \times \mathbb{P}$.

We can define two functions $ob$ and $pr$, which respectively map sets of properties to sets of objects of which all those properties hold, and map sets of objects to sets of properties common to all the objects, in the following way. For a set of properties $P \subset \mathbb{P}$ and a set of objects $O \subset \mathbb{O}$:

- $ob(P) = \{ o \in \mathbb{O}: \forall p \in P,\ o \Phi p \}$
- $pr(O) = \{ p \in \mathbb{P}: \forall o \in O,\ o \Phi p \}$

In English, this says that $ob(P)$ is the set of objects in the world which instantiate every property in $P$, and $pr(O)$ is the set of properties instantiated by every object in $O$.

### A Working Definition
So far we've said a bit about how natural kinds should behave, but nothing about what they /are/. Let's take a crack at it now. I'll try to gradually build us up to a first formalization in this section, by ~~throwing some symbols around~~ successively refining our intuition.

Evidently, we're concerned with some interaction between objects $o \in O$ and properties $p \in P$ that hold of them, and that relation is mediated by $\Phi$. Let's assume then that we have some such sets, and let's say that the triple $(O, P, \Phi)$ constitutes a natural kind, which we'll call $K$.

We require any object in $O$ to instantiate all of the properties in $P$. We further require that no other object, besides the ones already in $O$, can have all of the properties in $P$, so that $O$ is in some sense the largest possible set of objects for which all the $P\text{-properties}$ hold. At the same time, it's possible that some objects in $O$ have properties that are not in $P$, but which other $O\text{-objects}$ do not have (else those properties would be in $P$ by construction), so $P$ is the maximal possible set of properties common to all objects in $O$.

We want the following things from a putative natural kind:

- (totality) every object in $O$ should instantiate every property in $P$,
- (selectivity) no object not in $O$ should instantiate every property in $P$
- (exclusivity) no property not in $P$ should be instantiated by every object in $O$.

For these properties to hold of $K$, it must in turn be the case that:

- $pr(O) = P$,
- $ob(P) = O$,
- $\neg \exists o \notin O,\ \forall p \in P,\ o \Phi p$, and
- $\neg \exists p \notin P,\ \forall o \in O,\ o \Phi p$.

The first two conditions above tell us something rather remarkable: if $ob(P) = O$, and $pr(O) = P$, then we have both $pr(O) = pr(ob(P)) = P$ and $ob(P) = ob(pr(O)) = O$. These two facts say that the compositions $pr \circ ob$ and $ob \circ pr$ are closure operators on the sets $P$ and $O$, the significance of which will take some more work (in the next section) to explicate.

We are now in a decent position to define a natural kind $K = (O,P,\Phi)$ as a subset of the relation $\Phi = \mathbb{O} \times \mathbb{P}$, such that $pr(O) = P$ and $ob(P) = O$.

### Further Considerations
At this point, I should point out that we've only been looking at a single natural kind, in the abstract. To reiterate, our kind $K=(O,P,\Phi)$ has some subset $O$ of objects from the collection $\mathbb{O}$ of all objects, however you want to interpret that, and all of the properties common to those objects. The set $P$ is, in turn, a subset of $\mathbb{P}$, which consists of all possible properties that could be predicated of any object in the universe you choose.

Not every subset of $\mathbb{O}$ will constitute a natural kind, but some will, and we should consider how they stand in relation to one another. For example, I talked in the last post about the natural kind of human beings, and we may also consider the natural kind of cats, say. If we were to collect every cat up into a subset $O_{cats}$ of $\mathbb{O}$, we expect that the corresponding set of properties $P_{cats} \subset \mathbb{P}$ would contain at least a few properties not present in $P_{humans}$ (though we may count several catboys among our friends).

Different subsets of $\mathbb{O}$ or of $\mathbb{P}$ will generate different natural kinds, if they satisfy the definition given above. In general, the collection of objects (respectively properties) generating all natural kinds is a subcollection of the powerset of all objects (respectively properties), and is similarly ordered by inclusion.

### In the Arms of an Angel
By casting our discussion in terms of powersets and their partial orders, we unlock new ways to build out our theory, and in particular, to clarify what is meant by "closure operator" above. This will be the most technical section of this post and the first proof in this series. I'll do my best to provide background where I can reasonably do so, but you may require reference to other sources, and in any case it's best to have your textbooks at the ready.

The dual relationship between the objects and properties of a natural kind $K$ gives rise to curious phenomena: if we add more properties, there are more criteria for objects of $K$ to satisfy, and thus there will be fewer objects in $K$. Conversely, if we add more objects, the set of properties they all have in common will shrink. In partially-ordered sets, this behavior is known as a Galois connection, named for its similarity to a situation in group theory originally developed by a young French mathematician, who died in a duel.

Formally, a *Galois connection* between those two posets $P$ and $Q$ is a pair of functions $f: P \rightarrow Q$, $g:Q \rightarrow P$, satisfying the following:

- $\forall a,b \in P,\ a \leq b \Rightarrow f(a) \geq f(b)$
- $\forall x,y \in Q,\ x \leq y \Rightarrow g(x) \geq g(y)$
- $\forall a \in P,\ a \leq g(f(a))$
- $\forall x \in Q,\ x \leq f(g(x))$


In the next few paragraphs, I'll show that $(ob, pr)$ forms a Galois connection between the powersets $\mathcal{P}\mathbb{P}$ and $\mathcal{P}\mathbb{O}$. You can skip the rest of this section if you like, but Galois connections are rather beautiful, and I put a lot of work into the typesetting.

First, $pr(O)$ is a set of properties from $\mathbb{P}$ -- that is, $pr(O)$ is some subset of $\mathbb{P}$ -- with $O$ a subset of $\mathbb{O}$. We can then rewrite $pr(O): \mathbb{O} \rightarrow \mathbb{P}$ as $pr(O): \mathcal{P}\mathbb{O} \rightarrow \mathcal{P}\mathbb{P}$. So too for $ob(P)$: $P$ is a subset of $\mathbb{P}$, and the image of $ob$ is a set of objects of $O$ (so, a subset of $\mathbb{O}$). As a result, we can lift this function signature to $ob(P): \mathcal{P}\mathbb{P} \rightarrow \mathcal{P}\mathbb{O}$.

Next, we consider subsets $A$ and $B$ of $\mathbb{O}$, with $A \subseteq B$. There are possibly fewer objects in $A$ than in $B$ (indeed, $A$ is contained in $B$), so the collection of properties necessary to fully determine $A$ will have cardinality no smaller than that of the collection of properties necessary to fully determine $B$, and so $pr(B) \subseteq pr(A)$.

Similarly, consider subsets $X$ and $Y$ of $\mathbb{P}$, with $X \subseteq Y$. By the same reasoning, there are possibly fewer properties in $X$ than in $Y$, so the collection of objects determined by the properties in $X$ will be no smaller than the collection determined by the properties of $Y$, and thus $ob(Y) \subseteq ob(X)$.

Finally, consider a single arbitrary subset $A$ of $\mathbb{O}$. By definition, $pr(A) = \{p \in \mathbb{P} : \forall a \in A,\ a\Phi p\}$. Applying the $ob$ function to this set, we have $ob(pr(A)) = \{o \in \mathbb{O} : \forall p \in pr(A),\ o\Phi p\}$. $pr(A)$ gives the set of properties instantiated by all objects of $A$, while, for some set of properties $X$, $ob(X)$ gives the set of objects which instantiate all properties of $X$; surely the collection of objects instantiating *all the properties instantiated by all objects of $A$* is no smaller than $A$ itself, so $A = ob(pr(A))$. The same reasoning applies in the other direction: for an arbitrary subset $X$ of $\mathbb{P}$, $ob(X) = \{o \in \mathbb{O} : \forall p \in X,\ o\Phi p\}$ is the set of objects instantiating all properties of $X$, and $pr(ob(X)) = \{p \in \mathbb{P} : \forall o \in ob(X),\ o\Phi p\}$ is the set of properties instantiated by all *objects who instantiate every property of $X$* -- again certainly no smaller than $X$ itself -- and so $X = pr(ob(X))$. We found this earlier as an outcome of the properties $pr(O) = P$ and $ob(P) = O$ of a natural kind $K = (O,P,\Phi)$.

The last few paragraphs prove that $pr$ and $ob$ form a Galois connection between $\mathcal{P}\mathbb(O)$ and $\mathcal{P}(P)$.

We'll return to this fact later, when we lift our discussion into the realm of categories.


### A Note on Size Issues
I'm choosing to call $\mathbb{P}$ and $\mathbb{O}$ "collections" rather than "sets" or "classes", and eliding any discussion of their size. This can be dealt with in the usual ways, via Grothendieck universes or large cardinal axioms or whatever else you like. The original formulation of this approach to natural kinds that I am working from (cited below) considers $\mathbb{P}$ and $\mathbb{O}$ to be sets, but I am not committed to this; any category on which a powerset-like-functor can be defined should work; this only necessitates updating the Galois correspondence discussion to fit the collection scheme of choice.

### Debt and Sin
My interest in this topic was motivated by Hardegree's 1982 article *An Approach to the Logic of Natural Kinds*, appearing in Issue 63 of the Pacific Philosophical Quarterly, and by Hardegree's mentorship in general. Readers of that article will note the unavoidable similarities with this post; for these, and for any mistakes, I take full responsibility. The primary departure of this post from the article is that, what Hardegree calls individuals and traits, I call objects and properties. I do this largely for personal aesthetics, but also because I originally interpreted traits as being essentially predicates, and we are ultimately trying to categorify the situation so talk of objects will occur soon anyway.
